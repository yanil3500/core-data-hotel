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
@interface HotelsViewControlla () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSArray *allHotels;

@property(strong, nonatomic) UITableView *tableView;

@end

@implementation HotelsViewControlla

-(void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Inside of HotelsViewControlla");
    self.navigationController.topViewController.title = @"Hotels";
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview: self.tableView];
}

-(void)loadView{
    [super loadView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 300) style:UITableViewStylePlain];
    
}


-(NSArray *)allHotels{
    if(!_allHotels){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [[appDelegate persistentContainer] viewContext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
        
        NSError *fetchError;
        NSArray *hotels = [context executeFetchRequest:request error: &fetchError];
        
        if (fetchError){
            NSLog(@"Failed to fetch hotels from Core Data");
        }
        
        _allHotels = hotels;
    }
    return _allHotels;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section {
    return self.allHotels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.allHotels[indexPath.row] name];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected row: %li", (long)indexPath.row);
    RoomsViewControlla *roomsViewControlla = [[RoomsViewControlla alloc] init];
    
    NSArray *rooms = [[self.allHotels[indexPath.row] rooms] allObjects];
    
    NSLog(@"Number of rooms: %lu",(unsigned long)rooms.count);
    
    [roomsViewControlla setAllRooms: rooms];
    
    [[self navigationController] pushViewController:roomsViewControlla animated:YES];
}


@end
