//
//  HotelsViewControlla.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/24/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "HotelsViewControlla.h"
#import "RoomsViewControlla.h"

#import "AppDelegate.h"

#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"

#import "AutoLayout.h"
#import "CustomCell.h"
@interface HotelsViewControlla () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSArray *allHotels;

@property(strong, nonatomic) UITableView *tableView;

@end

@implementation HotelsViewControlla

-(void)viewDidLoad {
    [super viewDidLoad];


}

-(void)loadView{
    [super loadView];
    self.navigationController.topViewController.title = @"Hotels";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTableView];
}


-(NSArray *)allHotels{
    if(!_allHotels){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
        
        NSError *fetchError;
        NSArray *hotels = [[[appDelegate persistentContainer] viewContext]  executeFetchRequest:request error: &fetchError];
        
        if (fetchError){
            NSLog(@"Failed to fetch hotels from Core Data");
        }
        
        _allHotels = hotels;
    }
    return _allHotels;
}
#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section {
    
    NSLog(@"Number of hotels: %lu",(unsigned long)self.allHotels.count);
    return self.allHotels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [[cell labelOne] setText:[[NSString alloc]initWithString:[[[self allHotels] objectAtIndex:indexPath.row] name]]];
    [[cell labelOne] setFont:[UIFont boldSystemFontOfSize:16]];
    
    [[cell labelTwo] setText:[[NSString alloc]initWithFormat:@"Number of beds: %lu",[[[[self allHotels] objectAtIndex:indexPath.row] rooms] count]]];
    
    
    
    return cell;
}


#pragma mark UITableViewDataDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected row: %li", (long)indexPath.row);
    
    RoomsViewControlla *roomsViewControlla = [[RoomsViewControlla alloc] init];
    
    [roomsViewControlla setAllRooms: [[self.allHotels[indexPath.row] rooms] allObjects]];
    
    [[self navigationController] pushViewController:roomsViewControlla animated:YES];
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
