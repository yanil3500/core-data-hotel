//
//  AvailabilityViewControlla.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/25/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "AvailabilityViewControlla.h"
#import "AppDelegate.h"
#import "AutoLayout.h"

#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"

#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

#import "AvailabilityViewCell.h"

#import "BookViewControlla.h"

@interface AvailabilityViewControlla () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) UITableView *tableView;

@property(strong, nonatomic) NSArray *availableRooms;

@end

@implementation AvailabilityViewControlla

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView{
    [super loadView];
    self.navigationController.topViewController.title = @"Availability";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUpTableView];
    
}

-(NSArray *)availableRooms{
    
    if (!_availableRooms) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", self.endDate, self.startDate];
        
        NSError *fetchError;
        NSArray *rooms = [[[appDelegate persistentContainer] viewContext] executeFetchRequest:request error:&fetchError];
        NSMutableArray *unavailableRooms = [[NSMutableArray alloc] init];
        
        for (Reservation *reservation in rooms) {
            [unavailableRooms addObject:reservation.room];
        }
        
        NSFetchRequest *roomRequest = [NSFetchRequest  fetchRequestWithEntityName:@"Room"];
        roomRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
        NSError *availableRoomError;
        
        _availableRooms = [[[appDelegate persistentContainer] viewContext] executeFetchRequest:roomRequest error:&availableRoomError];
        
    }
    
    
    return _availableRooms;
}
#pragma mark UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AvailabilityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *roomInformation = [[NSString alloc]initWithFormat:@"Room Number: %hd",[[self availableRooms][indexPath.row] roomNumber]];
    [[cell roomNumberForCell] setText:roomInformation];
    NSString *numberOfBeds = [[NSString alloc]initWithFormat:@"Number of beds: %i",[[self availableRooms][indexPath.row] beds]];
    [[cell numberOfBedsForCell] setText:numberOfBeds];
    NSString *costOfRoom = [[NSString alloc]initWithFormat:@"Rate: $%.02f a night",[[self availableRooms][indexPath.row] rate]];
    [[cell roomRateForCell] setText:costOfRoom];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.availableRooms.count;
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Did select row");
    
    BookViewControlla *bookViewControlla = [[BookViewControlla alloc] init];
    [bookViewControlla setSelectedRoom:[self availableRooms][indexPath.row]];
    [bookViewControlla setStartDate:self.startDate];
    [bookViewControlla setEndDate:self.endDate];
    [[self navigationController] pushViewController:bookViewControlla animated:true];
}

#pragma mark UITableView helper methods
-(void) setUpTableView {
    
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    
    [AutoLayout fullScreenConstraintsWithVFL:self.tableView];
    
    [self.tableView registerClass:[AvailabilityViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self.tableView setEstimatedRowHeight:50.0];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
}



@end
