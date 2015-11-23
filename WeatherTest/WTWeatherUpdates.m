//
//  WTWeatherUpdates.m
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 NelepovDS. All rights reserved.
//

#import "WTWeatherUpdates.h"

@implementation WTWeatherUpdates

+ (void)updateWeathers:(NSArray *)array success:(WTWeatherUpdatesBlock)success {
    
    NSMutableArray *operations = [NSMutableArray array];
    
    for (WTWeatherCity *wCity in array) {
        NSDictionary *params = @{ @"q" : wCity.cityName, @"appid" : kOpenWeatherKey, @"units" : @"metric"};
        [operations addObject:[[WTAPI api] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:WTAPIWeather.weather parameters:params]];
    }
    
    dispatch_async(kBgQueue, ^{
        [[WTAPI api] enqueueBatchOfObjectRequestOperations:operations progress:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
            
        } completion:^(NSArray *operations) {
            if (success) {
                success();
            }
        }];
        
    });
}

@end
