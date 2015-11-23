//
//  WTSettings.h
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 NelepovDS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTSettings : NSObject

+ (instancetype)settings;
- (void)writeWithKey:(NSString*)key value:(id)value;
- (id)readWithKey:(NSString*)key defaultValue:(id)value;

@end

#define SettingsInstance [WTSettings settings]