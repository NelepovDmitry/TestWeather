//
//  WTAPI.m
//  WeatherTest
//
//  Created by Dmitry Nelepov on 23.11.15.
//  Copyright © 2015 Dmitry Nelepov. All rights reserved.
//

#import "WTAPI.h"



// Use a class extension to expose access to MagicalRecord's private setter methods
@interface NSManagedObjectContext ()
+ (void)MR_setRootSavingContext:(NSManagedObjectContext *)context;
+ (void)MR_setDefaultContext:(NSManagedObjectContext *)moc;
@end

@implementation WTAPI


+ (RKObjectManager *)api {
    return [RKObjectManager sharedManager];
}

+ (void)configureWithBaseURL:(NSURL *)baseURL {
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    [RKObjectManager setSharedManager:objectManager];
    [self configCoreData:objectManager];
    
    
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"User-Agent" value:@"iOS"];
    [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"Content-Type" value:@"application/json"];
    //Appid c53848b166e687116be8a0617a653ff9
    //Appid 2de143494c0b295cca9337e1e96b00e0
#ifdef DEBUG
    [[RKObjectManager sharedManager] HTTPClient].allowsInvalidSSLCertificate = YES;
#endif
    
    objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
    
    [objectManager addRequestDescriptorsFromArray:[self requestDescriptors]];
    [objectManager addResponseDescriptorsFromArray:[self responseDescriptors]];
    [objectManager.router.routeSet addRoutes:[self routes]];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}

+ (void)configCoreData:(RKObjectManager *)manager {
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    BOOL success = RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), nil);
    if (! success) {
        RKLogError(@"Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), @"Error");
    }
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"WeatherTest.sqlite"];
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:nil];
    if (! persistentStore) {
        RKLogError(@"Failed adding persistent store at path '%@': %@", path, @"Error");
    }
    [managedObjectStore createManagedObjectContexts];
    
    manager.managedObjectStore = managedObjectStore;
    
    // Configure MagicalRecord to use RestKit's Core Data stack
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:managedObjectStore.persistentStoreCoordinator];
    [NSManagedObjectContext MR_setRootSavingContext:managedObjectStore.persistentStoreManagedObjectContext];
    [NSManagedObjectContext MR_setDefaultContext:managedObjectStore.mainQueueManagedObjectContext];
    
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
    
}

+ (NSArray *)requestDescriptors {
    return
    @[
      ];
}

+ (NSArray *)responseDescriptors {
    NSIndexSet *successCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    NSMutableIndexSet *errorCodes = [NSMutableIndexSet indexSet];
    [errorCodes addIndexes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];
    [errorCodes addIndexes:RKStatusCodeIndexSetForClass(RKStatusCodeClassServerError)];
    NSMutableArray *retResponse = [NSMutableArray array];
    
    
    //Weather
    [retResponse addObjectsFromArray:[WTWeather apiResponseDescriptors:successCodes]];
    
    return retResponse;
}

+ (NSArray *)routes {
    NSMutableArray *retRoutes = [NSMutableArray array];
    
    
    return retRoutes;
}

#pragma mark - Common responses
+ (NSArray *)commonResponseDescriptors:(NSIndexSet *)success {
    return @[
             [self nullMapping],
             
             ];
}

+ (RKObjectMapping *)nullMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[NSNull class]];
    return mapping;
}

@end
