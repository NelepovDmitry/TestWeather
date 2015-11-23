#import "_WTWeatherCity.h"
#import <CoreLocation/CoreLocation.h>

typedef void(^WTWeatherBlock)(WTWeatherCity *weatherCity);

@interface WTWeatherCity : _WTWeatherCity {}
// Custom logic goes here.

+ (void)weatherForCity:(NSString *)cityName responseBlock:(WTWeatherBlock)responseBlock;
+ (void)weatherForCoordinates:(CLLocation *)location responseBlock:(WTWeatherBlock)responseBlock;

@end
