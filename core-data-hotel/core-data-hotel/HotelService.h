//
//  HotelService.h
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/27/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataSingleton.h"
@interface HotelService : NSObject

+(instancetype)shared;

-(NSArray *)getAllHotels;

-(NSArray *)getAllReservations;

-(NSFetchedResultsController *)getAllAvailableRoomsBetweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate;

-(void)makeReservationSelectedRoom:(Room *)room
                     WithFirstName:(NSString *)firstName
                       andLastName:(NSString *)lastName
                         withEmail:(NSString *)email
                        startingOn:(NSDate *)startDate
                       andEndingOn:(NSDate*)endDate;




@end
