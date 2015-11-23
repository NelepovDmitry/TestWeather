//
//  WTWeatherUpdates.h
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 NelepovDS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WTWeatherUpdatesBlock)();

@interface WTWeatherUpdates : NSObject

+ (void)updateWeathers:(NSArray *)array success:(WTWeatherUpdatesBlock)success;

@end
