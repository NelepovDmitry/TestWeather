//
//  WTWelcomeViewController.m
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 NelepovDS. All rights reserved.
//

#import "WTWelcomeViewController.h"

@interface WTWelcomeViewController ()

@end

@implementation WTWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) wSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf performSegueWithIdentifier:@"weatherListSegue" sender:nil];
    });
    //Setup default
    if ([WTWeatherCity MR_countOfEntities] == 0) {
        WTWeatherCity *london = [WTWeatherCity MR_createEntity];
        london.cityName = @"London";
        [london.managedObjectContext MR_saveToPersistentStoreAndWait];
        
        
        WTWeatherCity *tokyo = [WTWeatherCity MR_createEntity];
        tokyo.cityName = @"Tokyo";
        [tokyo.managedObjectContext MR_saveToPersistentStoreAndWait];
        
        WTWeatherCity *newYork = [WTWeatherCity MR_createEntity];
        newYork.cityName = @"New York";
        [newYork.managedObjectContext MR_saveToPersistentStoreAndWait];
    }
    
}

@end
