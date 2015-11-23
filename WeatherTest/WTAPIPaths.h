//
//  WTAPIPaths.h
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 Dmitry Nelepov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTAPIPaths : NSObject


FOUNDATION_EXPORT const struct WTAPIWeather {
    __unsafe_unretained NSString *weather;
} WTAPIWeather;

FOUNDATION_EXPORT const struct SMAPIPathItem {
    __unsafe_unretained NSString *item;
    __unsafe_unretained NSString *itemObject;
    __unsafe_unretained NSString *itemComments;
} SMAPIPathItem;

FOUNDATION_EXPORT const struct SMAPIPathProfile {
    __unsafe_unretained NSString *auth;
    __unsafe_unretained NSString *authCheck;
    __unsafe_unretained NSString *profile;
    __unsafe_unretained NSString *profileObject;
} SMAPIPathProfile;

FOUNDATION_EXPORT const struct SMAPIPathReference {
    __unsafe_unretained NSString *enums;
    __unsafe_unretained NSString *catalog;
    __unsafe_unretained NSString *brand;
} SMAPIPathReference;

@end
