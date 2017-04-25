//
//  RoomsViewControlla.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/24/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "RoomsViewControlla.h"
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

@interface RoomsViewControlla () <UITableViewDataSource>

@property(strong, nonatomic) NSArray *allRooms;

@property(strong, nonatomic) UITableView *tableView;
@end

@implementation RoomsViewControlla

#pragma mark Setter and Getter

-(void)setAllRooms:(NSArray *)rooms{
    _allRooms = rooms;
}

-(NSArray *)allRooms {
    return _allRooms;
}




- (void)viewDidLoad {
    self.navigationController.topViewController.title = @"Rooms";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview: self.tableView];
    [[self tableView] setRowHeight:(CGFloat)100];
}


-(void)loadView{
    [super loadView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) style:UITableViewStylePlain];
    
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



@end
