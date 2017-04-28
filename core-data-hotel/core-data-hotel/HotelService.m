//
//  HotelService.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/27/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "HotelService.h"


@implementation HotelService


+(instancetype)shared{
    static HotelService *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[[self class] alloc] init];
    });
    return shared;
}


-(NSArray *)allHotels{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    
    NSError *fetchError;
    NSArray *hotels = [[[[CoreDataSingleton shared] persistentContainer] viewContext]  executeFetchRequest:request error: &fetchError];
    
    if (fetchError){
        NSLog(@"Failed to fetch hotels from Core Data");
    }
    _allHotels = hotels;
    
    return _allHotels;
}

-(void)makeReservationSelectedRoom:(Room *)room
                     WithFirstName:(NSString *)firstName
                        andLastName:(NSString *)lastName
                          withEmail:(NSString *)email
                         startingOn:(NSDate *)startDate
                        andEndingOn:(NSDate*)endDate{
    
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext: [[[CoreDataSingleton shared] persistentContainer] viewContext]];
    guest.firstName = firstName;
    guest.lastName = lastName;
    guest.email = email;
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext: [[[CoreDataSingleton shared] persistentContainer] viewContext]];
    reservation.startDate = startDate;
    reservation.endDate = endDate;
    reservation.guest = guest;
    reservation.room = room;
    
    
    NSError *saveError;
    [[[[CoreDataSingleton shared] persistentContainer] viewContext] save:&saveError];
    
    if (saveError){
        NSLog(@"Failed to save to Core Data.");
    } else {
        NSLog(@"Successfully saved reservation to Core Data.");
    }

    
}

-(void)getAllAvailableRoomsBetweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate{
    NSFetchedResultsController *availableRooms;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate];
    
    NSError *fetchError;
    NSArray *rooms = [[[[CoreDataSingleton shared]persistentContainer ]viewContext ] executeFetchRequest:request error:&fetchError];
    NSMutableArray *unavailableRooms = [[NSMutableArray alloc] init];
    
    for (Reservation *reservation in rooms) {
        [unavailableRooms addObject:reservation.room];
    }
    
    NSFetchRequest *roomRequest = [NSFetchRequest  fetchRequestWithEntityName:@"Room"];
    roomRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
    
    NSSortDescriptor *roomSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"hotel.name" ascending:YES];
    
    NSSortDescriptor *roomNumberSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"roomNumber" ascending:YES];
    
    [roomRequest setSortDescriptors:@[roomSortDescriptor, roomNumberSortDescriptor]];
    NSError *availableRoomError;
    
    availableRooms = [[NSFetchedResultsController alloc] initWithFetchRequest:roomRequest managedObjectContext:[[[CoreDataSingleton shared]persistentContainer]viewContext] sectionNameKeyPath:@"hotel.name" cacheName:nil];
    [availableRooms performFetch: &availableRoomError];
    _allAvailableRooms = availableRooms;
}

-(NSArray *)allReservations{
    NSFetchRequest *reservationsByGuestRequest = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"guest" ascending:YES];
    [reservationsByGuestRequest setSortDescriptors:@[descriptor]];
    
    NSError *fetchError;
    NSArray *reservations;
    
    reservations = [[[[CoreDataSingleton shared] persistentContainer] viewContext] executeFetchRequest:reservationsByGuestRequest error:&fetchError];
    _allReservations = reservations;
    return _allReservations;
}


@end
