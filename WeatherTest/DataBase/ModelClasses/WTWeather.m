#import "WTWeather.h"

@interface WTWeather ()

// Private interface goes here.

@end

@implementation WTWeather

+ (RKEntityMapping *)apiMapping {
    RKEntityMapping *retMapping = [RKEntityMapping mappingForEntityForName:[WTWeather entityName] inManagedObjectStore:[RKManagedObjectStore defaultStore]];
    [retMapping setIdentificationAttributes:@[WTWeatherAttributes.cityName]];
    
    [retMapping addAttributeMappingsFromDictionary:
     @{
       @"name" : WTWeatherAttributes.cityName,
       @"weather.main.@firstObject" : WTWeatherAttributes.main,
       @"weather.description.@firstObject" : WTWeatherAttributes.desc,
       @"main.temp" : WTWeatherAttributes.temp,
       @"wind.speed" : WTWeatherAttributes.windSpeed,
       }];
    
    //Connect for city
    [retMapping addConnectionForRelationship:WTWeatherRelationships.cities connectedBy:@{ WTWeatherAttributes.cityName : WTWeatherCityAttributes.cityName }];
    
    return retMapping;
}

+ (NSArray *)apiResponseDescriptors:(NSIndexSet *)successCodes {
    return @[
             [RKResponseDescriptor responseDescriptorWithMapping:[self apiMapping] method:RKRequestMethodGET pathPattern:WTAPIWeather.weather keyPath:nil statusCodes:successCodes]
             ];
}

@end
