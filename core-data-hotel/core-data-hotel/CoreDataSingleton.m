//
//  CoreData.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/27/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "CoreDataSingleton.h"

#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"

#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"

#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"

@implementation CoreDataSingleton


+(instancetype)shared{
    static CoreDataSingleton *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[[self class] alloc] init];
    });
    return shared;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"core_data_hotel"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

-(void)bootStrapApp{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    
    NSError *error;
    
    NSInteger count = [self.persistentContainer.viewContext countForFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    if (count == 0){
        NSDictionary *hotels = [[NSDictionary alloc]init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hotels" ofType:@"json"];
        
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        
        NSError *jsonError;
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
        
        if (jsonError){
            NSLog(@"%@", jsonError.localizedDescription);
        }
        
        hotels = jsonDictionary[@"Hotels"];
        
        for (NSDictionary *hotel in hotels){
            Hotel *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel"
                                                            inManagedObjectContext:self.persistentContainer.viewContext];
            newHotel.name = hotel[@"name"];
            newHotel.hotelLocation = hotel[@"location"];
            newHotel.stars = [(NSNumber *)hotel[@"stars"] intValue];
            for (NSDictionary *room in hotel[@"rooms"]) {
                Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.persistentContainer.viewContext];
                NSNumber *number = room[@"number"];
                newRoom.roomNumber = [number integerValue];
                newRoom.beds = [(NSNumber *)room[@"beds"] intValue];
                NSNumber *roomRate = room[@"rate"];
                newRoom.rate = [roomRate floatValue];
                
                newRoom.hotel = newHotel;
            }
        }
    }
    
    NSError *saveError;
    [self.persistentContainer.viewContext save:&saveError];
    
    if (saveError){
        NSLog(@"Failed to save to Core Data.");
    } else {
        NSLog(@"Successfully saved to Core Data.");
    }

}

@end
