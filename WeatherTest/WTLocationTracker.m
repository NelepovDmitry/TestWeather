//
//  WTLocationTracker.m
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 NelepovDS. All rights reserved.
//

#import "WTLocationTracker.h"
#import <objc/runtime.h>


#define LOCATION_TRACKER_ACCURACY_CLASS kCLLocationAccuracyHundredMeters
#define LOCATION_TRACKER_DISTANCE_FILTER 500

@interface WTLocationTracker () <CLLocationManagerDelegate>

@end

@implementation WTLocationTracker

+ (instancetype)sharedTracker {
    static dispatch_once_t pred;
    static WTLocationTracker *singleton = nil;
    dispatch_once(&pred, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

+ (CLLocationManager *)sharedLocationManager {
    static CLLocationManager *locationManager;
    
    @synchronized(self) {
        if (locationManager == nil) {
            locationManager = [[CLLocationManager alloc] init];
            locationManager.desiredAccuracy = LOCATION_TRACKER_ACCURACY_CLASS;
            locationManager.distanceFilter = LOCATION_TRACKER_DISTANCE_FILTER;
        }
    }
    return locationManager;
}

- (void)startLocationTracking {
    CLLocationManager *locationManager = [[self class] sharedLocationManager];
    locationManager.delegate = self;
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        [locationManager requestWhenInUseAuthorization];
    
    //    if ([self isApplicationInBackgroundMode]) {
    //        [locationManager startMonitoringSignificantLocationChanges];
    //    } else {
    [locationManager startUpdatingLocation];
    //    }
    
}

- (BOOL)isApplicationInBackgroundMode {
    return
    ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) ||
    ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive);
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    switch ([error code]) {
        case kCLErrorNetwork: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error"
                                                            message:@"Please check your network connection."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
        case kCLErrorDenied: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enable Location Service"
                                                            message:@"You have to enable the Location Service to use this App. To enable, please go to Settings->Privacy->Location Services->LocationTracker (ON)"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (ABS(howRecent) < 15.0) {
        
        [self performCallbackBlockWithObject:location];
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
    }
    
    
    
}

#pragma mark - Universal callback mechanism

- (void)setCallbackBlock:(void (^)(id object))callbackBlock {
    //set block as an attribute in runtime
    if (callbackBlock) {
        objc_setAssociatedObject(self, "dismissBlockCallback", [callbackBlock copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    
    void (^block)(id obj) = objc_getAssociatedObject(self, "dismissBlockCallback");
    if (block)
        objc_removeAssociatedObjects(block);
}

//Return YES if there is a block object
- (BOOL)performCallbackBlockWithObject:(id)object {
    //get back the block object attribute we set earlier
    void (^block)(id obj) = objc_getAssociatedObject(self, "dismissBlockCallback");
    if (block) {
        block(object);
        return YES;
    }
    
    return NO;
}


@end
