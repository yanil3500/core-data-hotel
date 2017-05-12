//
//  DatePickerViewControlla.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/25/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "DatePickerViewControlla.h"
#import "AvailabilityViewControlla.h"
#import "AutoLayout.h"

@interface DatePickerViewControlla ()
@property(strong, nonatomic)UIDatePicker *endDate;
@property(strong, nonatomic)UIDatePicker *startDate;
@property(strong, nonatomic)UILabel* startDateLabel;
@property(strong, nonatomic)UILabel* endDateLabel;

@end

@implementation DatePickerViewControlla

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.topViewController.title = @"Start/End Date";
    // Do any additional setup after loading the view.
}


-(void)loadView{
    [super loadView];
    [self setUpDoneButton];
    [self setUpDatePickers];
    [[self view] setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark UIDatePicker helper methods

-(void)setUpDatePickers {
    self.startDate = [[UIDatePicker alloc]init];
    self.endDate = [[UIDatePicker alloc] init];
    
    [[self startDate]  addTarget:self action:@selector(changesInDatePicker:) forControlEvents:UIControlEventValueChanged];
    [[self endDate]  addTarget:self action:@selector(changesInDatePicker:) forControlEvents:UIControlEventValueChanged];
    
    [[self startDate] sendActionsForControlEvents:UIControlEventValueChanged];
    [[self endDate] sendActionsForControlEvents:UIControlEventValueChanged];
    
    [[self view] addSubview:self.startDate];
    [[self view] addSubview:self.endDate];
    
    [self.startDate setDatePickerMode:UIDatePickerModeDate];
    [self.endDate setDatePickerMode:UIDatePickerModeDate];
    
    [[self startDate] setMinimumDate:[NSDate date]];
    [[self endDate] setMinimumDate:[NSDate date]];
    
    [self setUpDatePickerLabel];
    
    [self autoLayoutForDatePicker];
    
}

-(void)changesInDatePicker:(id)date{
    //if startDate is later than endDate
    if([[[self startDate] date]compare:([[self endDate]date])] == NSOrderedDescending){
        [[self endDate]setDate:([NSDate date])];
        [[self startDate] setDate:[NSDate date]];
    }
    NSLog(@"What is the start date?: %@",[self getDateString:[[self startDate] date]]);
    NSLog(@"What is the end date?: %@",[self getDateString:[[self endDate] date]]);
}

-(void)setUpDatePickerLabel{
    self.startDateLabel = [[UILabel alloc] init];
    self.endDateLabel = [[UILabel alloc]init];
    
    [[self view] addSubview:self.startDateLabel];
    [[self view] addSubview:self.endDateLabel];
    
    [self.startDateLabel setBackgroundColor:[UIColor grayColor]];
    [self.endDateLabel setBackgroundColor:[UIColor grayColor]];
    
    [self.startDateLabel setText:@"Start Date"];
    [self.endDateLabel setText:@"End Date"];
    
}
-(void)doneButtonPressed{
    AvailabilityViewControlla *availabilityViewControlla = [[AvailabilityViewControlla alloc] init];
    //if the startDate is later than endDate, switch dates
    if([[[self startDate] date]compare:([[self endDate]date])] == NSOrderedDescending){
        NSDate *tempDate = [[self endDate] date];
        [[self endDate]setDate:([[self startDate] date])];
        [[self startDate] setDate:tempDate];
        [availabilityViewControlla setEndDate: self.endDate.date];
        [availabilityViewControlla setStartDate: self.startDate.date];
    }
    NSLog(@"doneButtonPressed");
    [availabilityViewControlla setEndDate: self.endDate.date];
    [availabilityViewControlla setStartDate: self.startDate.date];
    [[self navigationController] pushViewController:availabilityViewControlla animated:YES];
    
}

-(void)setUpDoneButton{
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    [[self navigationItem] setRightBarButtonItem:done];
}

-(void)autoLayoutForDatePicker{
    CGFloat navBarHeight = CGRectGetHeight([[[self navigationController] navigationBar] frame]);
    CGFloat statusBarHeight = 20.0;
    CGFloat topMargin = navBarHeight + statusBarHeight;
    CGFloat windowHeight = self.view.frame.size.height;
    CGFloat frameHeight =((windowHeight - topMargin) / 2);
    CGFloat heightForLabels = frameHeight / 8;
    
    NSDictionary *viewDictionary = @{@"startDate":self.startDate, @"startDateLabel":self.startDateLabel, @"endDate":self.endDate, @"endDateLabel":self.endDateLabel};
    
    NSDictionary *metricDictionary = @{@"topMargin":[NSNumber numberWithFloat:topMargin],@"frameHeight":[NSNumber numberWithFloat:frameHeight],@"heightForLabels":[NSNumber numberWithFloat:heightForLabels]};
    
    NSString *visualFormat = @"V:|-topMargin-[startDateLabel(==heightForLabels)][startDate(==frameHeight)]-[endDateLabel(==startDateLabel)][endDate(==startDate)]|";
    
    [AutoLayout leadingConstraintAndTrailingConstraintFromView:self.startDate toView:self.view];
    [AutoLayout leadingConstraintAndTrailingConstraintFromView:self.endDate toView:self.view];

    
    [AutoLayout leadingConstraintAndTrailingConstraintFromView:self.startDateLabel toView:self.view];
    
    [AutoLayout leadingConstraintAndTrailingConstraintFromView:self.endDateLabel toView:self.view];
    

    
    [AutoLayout constraintsWithVFLForViewDictionary:viewDictionary forMetricsDictionary:metricDictionary withOptions:0 withVisualFormat:visualFormat];
    
}

-(NSString *)getDateString:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    return [dateFormatter stringFromDate:date];
}


@end
