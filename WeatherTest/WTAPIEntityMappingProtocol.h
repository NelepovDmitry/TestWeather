//
//  WTAPIEntityMappingProtocol.h
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 Dmitry Nelepov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTAPIEntityMappingProtocol <NSObject>

@optional
+ (NSArray *)apiRoutes;

@required
+ (NSArray *)apiResponseDescriptors:(NSIndexSet *)successCodes;
+ (RKEntityMapping *)apiMapping;

@end
