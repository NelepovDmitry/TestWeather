#import "WTWeatherCity.h"
#import "WTWeather.h"

@interface WTWeatherCity ()

// Private interface goes here.

@end

@implementation WTWeatherCity

+ (void)weatherForCity:(NSString *)cityName responseBlock:(WTWeatherBlock)responseBlock {
    NSDictionary *params = @{ @"q" : cityName, @"appid" : kOpenWeatherKey, @"units" : @"metric"};
    [[WTAPI api] getObject:nil path:WTAPIWeather.weather parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        WTWeather *weather = (WTWeather *)mappingResult.firstObject;
        if (responseBlock) {
            if ([weather.cityName isEqualToString:cityName]) {
                responseBlock([self weatherCity:weather]);
            } else {
                responseBlock(nil);
            }
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (responseBlock) {
            responseBlock(nil);
        }
    }];
}

+ (void)weatherForCoordinates:(CLLocation *)location responseBlock:(WTWeatherBlock)responseBlock {
    NSDictionary *params = @{
                             @"lat" : @(location.coordinate.latitude),
                             @"lon" : @(location.coordinate.longitude),
                             @"appid" : kOpenWeatherKey,
                             @"units" : @"metric"};
    [[WTAPI api] getObject:nil path:WTAPIWeather.weather parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        WTWeather *weather = (WTWeather *)mappingResult.firstObject;
        if (responseBlock) {
            responseBlock([self weatherCity:weather]);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (responseBlock) {
            responseBlock(nil);
        }
    }];
}

+ (WTWeatherCity *)weatherCity:(WTWeather *)weather {
    WTWeatherCity *city = [WTWeatherCity MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"%K=%@", WTWeatherCityAttributes.cityName, weather.cityName] inContext:weather.managedObjectContext];
    if (!city) {
        city = [WTWeatherCity MR_createEntityInContext:weather.managedObjectContext];
        city.cityName = weather.cityName;
        city.weather = weather;
    }
    [city.managedObjectContext MR_saveToPersistentStoreAndWait];
    return city;
}

@end
