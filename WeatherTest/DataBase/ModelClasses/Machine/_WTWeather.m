// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WTWeather.m instead.

#import "_WTWeather.h"

const struct WTWeatherAttributes WTWeatherAttributes = {
	.cityName = @"cityName",
	.desc = @"desc",
	.icon = @"icon",
	.id = @"id",
	.main = @"main",
	.temp = @"temp",
	.windSpeed = @"windSpeed",
};

const struct WTWeatherRelationships WTWeatherRelationships = {
	.cities = @"cities",
};

@implementation WTWeatherID
@end

@implementation _WTWeather

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"WTWeather" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"WTWeather";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"WTWeather" inManagedObjectContext:moc_];
}

- (WTWeatherID*)objectID {
	return (WTWeatherID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"tempValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"temp"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"windSpeedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"windSpeed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic cityName;

@dynamic desc;

@dynamic icon;

@dynamic id;

- (int32_t)idValue {
	NSNumber *result = [self id];
	return [result intValue];
}

- (void)setIdValue:(int32_t)value_ {
	[self setId:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result intValue];
}

- (void)setPrimitiveIdValue:(int32_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithInt:value_]];
}

@dynamic main;

@dynamic temp;

- (double)tempValue {
	NSNumber *result = [self temp];
	return [result doubleValue];
}

- (void)setTempValue:(double)value_ {
	[self setTemp:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveTempValue {
	NSNumber *result = [self primitiveTemp];
	return [result doubleValue];
}

- (void)setPrimitiveTempValue:(double)value_ {
	[self setPrimitiveTemp:[NSNumber numberWithDouble:value_]];
}

@dynamic windSpeed;

- (int32_t)windSpeedValue {
	NSNumber *result = [self windSpeed];
	return [result intValue];
}

- (void)setWindSpeedValue:(int32_t)value_ {
	[self setWindSpeed:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveWindSpeedValue {
	NSNumber *result = [self primitiveWindSpeed];
	return [result intValue];
}

- (void)setPrimitiveWindSpeedValue:(int32_t)value_ {
	[self setPrimitiveWindSpeed:[NSNumber numberWithInt:value_]];
}

@dynamic cities;

- (NSMutableSet*)citiesSet {
	[self willAccessValueForKey:@"cities"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"cities"];

	[self didAccessValueForKey:@"cities"];
	return result;
}

@end

