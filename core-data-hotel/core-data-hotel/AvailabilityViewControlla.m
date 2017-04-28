//
//  AvailabilityViewControlla.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/25/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "AvailabilityViewControlla.h"
#import "AutoLayout.h"

#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

#import "CustomCell.h"
#import "BookViewControlla.h"

#import "HotelService.h"

@interface AvailabilityViewControlla () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) UITableView *tableView;

@property(strong, nonatomic) NSFetchedResultsController *availableRooms;

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

-(NSFetchedResultsController *)availableRooms{
    return self.availableRooms = [[HotelService shared] getAllAvailableRoomsBetweenStartDate:self.startDate andEndDate:self.endDate];
}
#pragma mark UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Room *currentRoom = [[Room alloc]init];
    
    currentRoom = [self.availableRooms objectAtIndexPath:indexPath];
    
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *roomInformation = [[NSString alloc]initWithFormat:@"Room Number: %hd",[[self.availableRooms objectAtIndexPath:indexPath] roomNumber]];
    [[cell labelOne] setText:roomInformation];
    NSString *numberOfBeds = [[NSString alloc]initWithFormat:@"Number of beds: %i",[[self.availableRooms objectAtIndexPath:indexPath] beds]];
    [[cell labelTwo] setText:numberOfBeds];
    NSString *costOfRoom = [[NSString alloc]initWithFormat:@"Rate: $%.02f a night",[[self.availableRooms objectAtIndexPath:indexPath] rate]];
    [[cell labelThree] setText:costOfRoom];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.availableRooms sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BookViewControlla *bookViewControlla = [[BookViewControlla alloc] init];
    [bookViewControlla setSelectedRoom:[self.availableRooms objectAtIndexPath:indexPath]];
    [bookViewControlla setStartDate:self.startDate];
    [bookViewControlla setEndDate:self.endDate];
    [[self navigationController] pushViewController:bookViewControlla animated:true];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.availableRooms.sections.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [[[self.availableRooms sections] objectAtIndex:section] name];
}

#pragma mark UITableView helper methods
-(void) setUpTableView {
    
    self.tableView = [[UITableView alloc]init];
    
    [self.view addSubview:self.tableView];
    
    [AutoLayout fullScreenConstraintsWithVFL:self.tableView];
    
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView setEstimatedRowHeight:50.0];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
}




@end
