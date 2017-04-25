//
//  AppDelegate.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/24/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControlla.h"

#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"

#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

@interface AppDelegate ()

@property(strong, nonatomic) UINavigationController *navController;
@property(strong, nonatomic) ViewControlla *viewControlla;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupRootViewController];
    [self bootStrapApp];
    return YES;

}

-(void)setupRootViewController{
    self.window = [[UIWindow alloc]initWithFrame: [[UIScreen mainScreen] bounds]];
    
    self.viewControlla = [[ViewControlla alloc]init];
    
    self.navController = [[UINavigationController alloc]initWithRootViewController:self.viewControlla];
    
    self.window.rootViewController = self.navController;
    
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
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
            newHotel.location = hotel[@"location"];
            newHotel.stars = (NSInteger)hotel[@"stars"];
            for (NSDictionary *room in hotel[@"rooms"]) {
                Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.persistentContainer.viewContext];
                NSNumber *number = room[@"number"];
                newRoom.roomNumber = [number integerValue];
                newRoom.beds = (NSInteger)room[@"beds"];
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

@end
