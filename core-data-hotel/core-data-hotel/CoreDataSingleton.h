//
//  CoreData.h
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/27/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"

#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"

#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"

@interface CoreDataSingleton : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+(instancetype)shared;

-(void)saveContext;

-(void)bootStrapApp;
@end
