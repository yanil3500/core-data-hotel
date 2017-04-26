//
//  LookUpReservationsControlla.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/26/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "LookUpReservationsControlla.h"
#import "AutoLayout.h"

@interface LookUpReservationsControlla () <UITableViewDataSource>
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UISearchBar *searchBar;
@end

@implementation LookUpReservationsControlla

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Inside of LookUpReservationsControlla");
}

-(void)loadView{
    [super loadView];
    self.navigationController.topViewController.title = @"Reservations";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpSearchBar];
}

#pragma mark UITableViewDataSource



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"Money";
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

-(void) setUpSearchBar {
    self.searchBar = [[UISearchBar alloc]init];
    [[self searchBar] setPlaceholder:@"Search Reservations by name"];
    [self.view addSubview:[self searchBar]];
    [self setUpTableView];
}


#pragma mark UITableView helper methods
-(void) setUpTableView {
    
    self.tableView = [[UITableView alloc]init];
    
    [self.view addSubview:[self tableView]];
    
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView setEstimatedRowHeight:50.0];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.dataSource = self;
    
    [self autoLayoutForLookUpReservations];
    
}
-(void)autoLayoutForLookUpReservations{
    
    CGFloat navBarHeight = CGRectGetHeight([[[self navigationController] navigationBar] frame]);
    CGFloat statusBarHeight = 20.0;
    CGFloat topMargin = navBarHeight + statusBarHeight;
    CGFloat windowHeight = self.view.frame.size.height;
    CGFloat heightForSearchBar = ((windowHeight - topMargin) / 2) / 8;
    
    NSDictionary *viewDictionary = @{@"searchBar":self.searchBar, @"tableView": self.tableView};
    
    NSDictionary *metricDictionary = @{@"topMargin":[NSNumber numberWithFloat:topMargin],@"heightForSearchBar":[NSNumber numberWithFloat:heightForSearchBar]};
    
    NSString *visualFormat = @"V:|-topMargin-[searchBar(==heightForSearchBar)][tableView]|";
    
    
    [AutoLayout leadingConstraintAndTrailingConstraintFromView:self.searchBar toView:self.view];
    [AutoLayout leadingConstraintAndTrailingConstraintFromView:self.tableView toView:self.view];
    
    
    
    
    [AutoLayout constraintsWithVFLForViewDictionary:viewDictionary forMetricsDictionary:metricDictionary withOptions:0 withVisualFormat:visualFormat];
    
}




@end
