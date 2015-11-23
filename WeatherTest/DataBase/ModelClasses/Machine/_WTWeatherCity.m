// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WTWeatherCity.m instead.

#import "_WTWeatherCity.h"

const struct WTWeatherCityAttributes WTWeatherCityAttributes = {
	.cityName = @"cityName",
	.lastUpdate = @"lastUpdate",
};

const struct WTWeatherCityRelationships WTWeatherCityRelationships = {
	.weather = @"weather",
};

@implementation WTWeatherCityID
@end

@implementation _WTWeatherCity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"WTWeatherCity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"WTWeatherCity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"WTWeatherCity" inManagedObjectContext:moc_];
}

- (WTWeatherCityID*)objectID {
	return (WTWeatherCityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic cityName;

@dynamic lastUpdate;

@dynamic weather;

@end

