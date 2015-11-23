//
//  WTLocationTracker.h
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 NelepovDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface WTLocationTracker : NSObject

+ (instancetype)sharedTracker;

- (void)startLocationTracking;
- (void)setCallbackBlock:(void (^)(id object))callbackBlock;


@end
