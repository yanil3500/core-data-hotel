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

@end

@implementation DatePickerViewControlla

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.topViewController.title = @"Reservations";
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
    
    [[self view] addSubview:self.startDate];
    [[self view] addSubview:self.endDate];
    
    [self.startDate setDatePickerMode:UIDatePickerModeDate];
    [self.endDate setDatePickerMode:UIDatePickerModeDate];
    
    [[self startDate] setMinimumDate:[NSDate date]];
    [[self endDate] setMinimumDate:[NSDate date]];
    
    [self autoLayoutForDatePicker];
    
}

-(void)doneButtonPressed{
    NSLog(@"doneButtonPressed");
    AvailabilityViewControlla *availabilityViewControlla = [[AvailabilityViewControlla alloc] init];
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
    
    NSDictionary *viewDictionary = @{@"startDate":self.startDate, @"endDate":self.endDate};
    
    NSDictionary *metricDictionary = @{@"topMargin":[NSNumber numberWithFloat:topMargin],@"frameHeight":[NSNumber numberWithFloat:frameHeight]};
    
    NSString *visualFormat = @"V:|-topMargin-[startDate(==frameHeight)][endDate(==startDate)]|";
    
    [AutoLayout leadingConstraintFromView:self.startDate toView:self.view];
    [AutoLayout trailingConstraintFromView:self.startDate toView:self.view];
    [AutoLayout leadingConstraintFromView:self.endDate toView:self.view];
    [AutoLayout trailingConstraintFromView:self.endDate toView:self.view];
    
    [AutoLayout constraintsWithVFLForViewDictionary:viewDictionary forMetricsDictionary:metricDictionary withOptions:0 withVisualFormat:visualFormat];
    
    [self.startDate setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.endDate setTranslatesAutoresizingMaskIntoConstraints:NO];
}



@end
