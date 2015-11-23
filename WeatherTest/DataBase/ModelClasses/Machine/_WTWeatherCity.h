// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WTWeatherCity.h instead.

#import <CoreData/CoreData.h>

extern const struct WTWeatherCityAttributes {
	__unsafe_unretained NSString *cityName;
	__unsafe_unretained NSString *lastUpdate;
} WTWeatherCityAttributes;

extern const struct WTWeatherCityRelationships {
	__unsafe_unretained NSString *weather;
} WTWeatherCityRelationships;

@class WTWeather;

@interface WTWeatherCityID : NSManagedObjectID {}
@end

@interface _WTWeatherCity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) WTWeatherCityID* objectID;

@property (nonatomic, strong) NSString* cityName;

//- (BOOL)validateCityName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* lastUpdate;

//- (BOOL)validateLastUpdate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) WTWeather *weather;

//- (BOOL)validateWeather:(id*)value_ error:(NSError**)error_;

@end

@interface _WTWeatherCity (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCityName;
- (void)setPrimitiveCityName:(NSString*)value;

- (NSDate*)primitiveLastUpdate;
- (void)setPrimitiveLastUpdate:(NSDate*)value;

- (WTWeather*)primitiveWeather;
- (void)setPrimitiveWeather:(WTWeather*)value;

@end
