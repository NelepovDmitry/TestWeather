// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WTWeather.h instead.

#import <CoreData/CoreData.h>

extern const struct WTWeatherAttributes {
	__unsafe_unretained NSString *cityName;
	__unsafe_unretained NSString *desc;
	__unsafe_unretained NSString *icon;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *main;
	__unsafe_unretained NSString *temp;
	__unsafe_unretained NSString *windSpeed;
} WTWeatherAttributes;

extern const struct WTWeatherRelationships {
	__unsafe_unretained NSString *cities;
} WTWeatherRelationships;

@class WTWeatherCity;

@interface WTWeatherID : NSManagedObjectID {}
@end

@interface _WTWeather : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) WTWeatherID* objectID;

@property (nonatomic, strong) NSString* cityName;

//- (BOOL)validateCityName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* desc;

//- (BOOL)validateDesc:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* icon;

//- (BOOL)validateIcon:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* id;

@property (atomic) int32_t idValue;
- (int32_t)idValue;
- (void)setIdValue:(int32_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* main;

//- (BOOL)validateMain:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* temp;

@property (atomic) double tempValue;
- (double)tempValue;
- (void)setTempValue:(double)value_;

//- (BOOL)validateTemp:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* windSpeed;

@property (atomic) int32_t windSpeedValue;
- (int32_t)windSpeedValue;
- (void)setWindSpeedValue:(int32_t)value_;

//- (BOOL)validateWindSpeed:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *cities;

- (NSMutableSet*)citiesSet;

@end

@interface _WTWeather (CitiesCoreDataGeneratedAccessors)
- (void)addCities:(NSSet*)value_;
- (void)removeCities:(NSSet*)value_;
- (void)addCitiesObject:(WTWeatherCity*)value_;
- (void)removeCitiesObject:(WTWeatherCity*)value_;

@end

@interface _WTWeather (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCityName;
- (void)setPrimitiveCityName:(NSString*)value;

- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;

- (NSString*)primitiveIcon;
- (void)setPrimitiveIcon:(NSString*)value;

- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int32_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int32_t)value_;

- (NSString*)primitiveMain;
- (void)setPrimitiveMain:(NSString*)value;

- (NSNumber*)primitiveTemp;
- (void)setPrimitiveTemp:(NSNumber*)value;

- (double)primitiveTempValue;
- (void)setPrimitiveTempValue:(double)value_;

- (NSNumber*)primitiveWindSpeed;
- (void)setPrimitiveWindSpeed:(NSNumber*)value;

- (int32_t)primitiveWindSpeedValue;
- (void)setPrimitiveWindSpeedValue:(int32_t)value_;

- (NSMutableSet*)primitiveCities;
- (void)setPrimitiveCities:(NSMutableSet*)value;

@end
