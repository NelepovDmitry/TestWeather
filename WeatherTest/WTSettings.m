//
//  WTSettings.m
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 NelepovDS. All rights reserved.
//

#import "WTSettings.h"

NSString * const kDefaultsSessionId = @"sm_session_id";


@implementation WTSettings {
    NSUserDefaults* _defaults;
}

+ (instancetype)settings {
    static WTSettings *settings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[WTSettings alloc] init];
    });
    
    return settings;
}

- (instancetype)init {
    self = [super init];
    _defaults = [NSUserDefaults standardUserDefaults];
    return self;
}

- (void)writeWithKey:(NSString*)key value:(id)value {
    if (![value isKindOfClass:[NSString class]]) {
        value = [NSKeyedArchiver archivedDataWithRootObject:value];
    }
    [_defaults setObject:value forKey:key];
    [_defaults synchronize];
}

- (id)readWithKey:(NSString*)key defaultValue:(id)value {
    id retValue = nil;
    if ( (retValue = [_defaults objectForKey:key]) != nil){
        if (![retValue isKindOfClass:[NSString class]]) {
            retValue = [NSKeyedUnarchiver unarchiveObjectWithData:retValue];
        }
    } else {
        retValue = value;
    }
    return retValue;
}



@end
