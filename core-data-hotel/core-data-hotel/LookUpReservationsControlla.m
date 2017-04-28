//
//  LookUpReservationsControlla.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/26/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "LookUpReservationsControlla.h"
#import "AutoLayout.h"

#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"

#import "CustomCell.h"

#import "HotelService.h"

@interface LookUpReservationsControlla () <UITableViewDataSource, UISearchBarDelegate>
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UISearchBar *searchBar;
@property (strong, nonatomic)NSArray *allReservations;
@property (strong, nonatomic)NSMutableArray *filteredResults;
@property BOOL isSearching;
@end

@implementation LookUpReservationsControlla

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)loadView{
    
    [super loadView];
    self.navigationController.topViewController.title = @"Reservations";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpSearchBar];
    [self setUpTableView];
}

#pragma mark UITableViewDataSource


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Inside of allReservations: ");
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(self.filteredResults != nil){
        Reservation *reservation = [[self filteredResults] objectAtIndex:indexPath.row];
        cell.labelOne.text = [[[[NSString alloc] initWithFormat:@"Guest Name: %@",reservation.guest.firstName] stringByAppendingString:@" "] stringByAppendingFormat:@"%@",reservation.guest.lastName];
        cell.labelTwo.text = [[NSString alloc] initWithFormat:@"Start Date: %@",[LookUpReservationsControlla getDateString:reservation.startDate]];
        cell.labelThree.text = [[NSString alloc] initWithFormat:@"End Date: %@",[LookUpReservationsControlla  getDateString:reservation.endDate]];
    } else {
        Reservation *reservation = [[self allReservations] objectAtIndex:indexPath.row];
        cell.labelOne.text = [[[[NSString alloc] initWithFormat:@"Guest Name: %@",reservation.guest.firstName] stringByAppendingString:@" "] stringByAppendingFormat:@"%@",reservation.guest.lastName];
        cell.labelTwo.text = [[NSString alloc] initWithFormat:@"Start Date: %@",[LookUpReservationsControlla  getDateString:reservation.startDate]];
        cell.labelThree.text = [[NSString alloc] initWithFormat:@"End Date: %@",[LookUpReservationsControlla  getDateString:reservation.endDate]];
    }

    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isSearching) {
        return self.filteredResults.count;
    } else {
        return self.allReservations.count;
    }
    
}

#pragma mark UISearchBarDelegate 


-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.isSearching = YES;
    self.filteredResults = [[NSMutableArray alloc] init];
    
    [self.filteredResults setArray:[[self.allReservations filteredArrayUsingPredicate:[self filterByFirstName:@"guest.firstName" andLastName:@"guest.lastName" usingSearchTerms:searchBar.text]]mutableCopy]];
    [[self tableView] reloadData];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.isSearching = YES;
    [self.filteredResults setArray:[[self.allReservations filteredArrayUsingPredicate:[self filterByFirstName:@"guest.firstName" andLastName:@"guest.lastName" usingSearchTerms:searchBar.text]]mutableCopy]];
    [[self tableView] reloadData];
}



-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.isSearching = NO;
    self.filteredResults = nil;
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (searchBar.text != nil) {
        self.filteredResults = [[NSMutableArray alloc]init];
        [self.filteredResults setArray:[[self.allReservations filteredArrayUsingPredicate:[self filterByFirstName:@"guest.firstName" andLastName:@"guest.lastName" usingSearchTerms:searchBar.text]]mutableCopy]];
    }
    self.isSearching = NO;
}

#pragma mark UISearchBar helper methods
-(void) setUpSearchBar {
    self.searchBar = [[UISearchBar alloc]init];
    [[self searchBar] setPlaceholder:@"Search Reservations by name"];
    [[self searchBar]setDelegate:self];
    [[self searchBar] setShowsCancelButton:YES];
    [[self searchBar] setShowsSearchResultsButton:YES];
    [[self view] addSubview:[self searchBar]];
}


#pragma mark UITableView helper methods
-(void) setUpTableView {
    
    self.tableView = [[UITableView alloc]init];
    
    [self.view addSubview:[self tableView]];
    
    [self.tableView registerClass: [CustomCell class] forCellReuseIdentifier:@"cell"];
    
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

-(NSArray *)allReservations{
    return self.allReservations = [[HotelService shared] getAllReservations];
}

+(NSString *)getDateString:(NSDate *)date{
    if (![date isKindOfClass:[NSDate class]]) {
        NSException *exception = [NSException exceptionWithName:@"InvalidInputException" reason:@"Input not of type NSDate" userInfo:nil];
        @throw exception;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    return [dateFormatter stringFromDate:date];
}

#pragma mark NSPredicateHelper

-(NSPredicate *)filterByFirstName:(NSString *)firstName
                      andLastName:(NSString *)lastName
                 usingSearchTerms:(NSString *)searchTerms{
    return [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@ || %K CONTAINS[cd] %@"
                              argumentArray:@[firstName, searchTerms, lastName, searchTerms]];
}


@end
