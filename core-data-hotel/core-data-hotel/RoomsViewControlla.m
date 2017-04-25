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

- (void)viewDidLoad {
    self.navigationController.topViewController.title = @"Rooms";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview: self.tableView];
}


-(void)loadView{
    [super loadView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 300) style:UITableViewStylePlain];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allRooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ;
    NSString *roomNumber = [[NSString alloc] initWithFormat:@"Room Number: %hd\n", [self.allRooms[indexPath.row] roomNumber]];
    NSString *numberOfBeds = [[NSString alloc]initWithFormat:@"Number of Beds: %hd\n", [self.allRooms[indexPath.row] beds]];
    NSString *roomRate = [[NSString alloc] initWithFormat:@"Room rate: $%.02f\n", [self.allRooms[indexPath.row] rate]];
    NSLog(@"%@",numberOfBeds);
    NSLog(@"%@", roomNumber);
    NSLog(@"%@",roomRate);
    cell.textLabel.text = (@"%@",roomNumber);
    
    
    return cell;
}

-(void)setAllRooms:(NSArray *)rooms{
    _allRooms = rooms;
}

-(NSArray *)allRooms {
    return _allRooms;
}


@end
