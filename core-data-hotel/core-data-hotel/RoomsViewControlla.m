//
//  RoomsViewControlla.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/24/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//
#import "AutoLayout.h"
#import "HotelService.h"
#import "RoomsViewControlla.h"
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

@interface RoomsViewControlla () <UITableViewDataSource>

@property (strong, nonatomic) NSArray *allRooms;
@property(strong, nonatomic) UITableView *tableView;
@end

@implementation RoomsViewControlla

#pragma mark Setter and Getter

-(NSArray *)allRooms{
    _allRooms = [self.hotel.rooms allObjects];
    return _allRooms;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)loadView{
    [super loadView];
    self.navigationController.topViewController.title = @"Rooms";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTableView];
}


#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allRooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSString *roomNumber = [[NSString alloc] initWithFormat:@"Room Number: %hd", [self.allRooms[indexPath.row] roomNumber]];
    NSString *numberOfBeds = [[NSString alloc]initWithFormat:@"\nNumber of Beds: %hd", [self.allRooms[indexPath.row] beds]];
    [roomNumber stringByAppendingString:numberOfBeds];
    NSString *roomRate = [[NSString alloc] initWithFormat:@"\nRoom rate: $%.02f", [self.allRooms[indexPath.row] rate]];
    [roomNumber stringByAppendingString:roomRate];
    cell.textLabel.text = roomNumber;
    
    
    return cell;
}

#pragma mark UITableView helper methods
-(void) setUpTableView {
    
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    
    [AutoLayout fullScreenConstraintsWithVFL:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.tableView.dataSource = self;
}


@end
