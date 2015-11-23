//
//  WTAPI.h
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 Dmitry Nelepov. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WTAPI : NSObject

+ (RKObjectManager *)api;
+ (void)configureWithBaseURL:(NSURL *)baseURL;

+ (RKObjectMapping *)nullMapping;

@end
