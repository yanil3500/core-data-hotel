//
//  BookViewControlla.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/25/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "BookViewControlla.h"

#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"

#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"

#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"

#import "AutoLayout.h"
#import "AppDelegate.h"
@interface BookViewControlla () <UITextFieldDelegate>

@property(strong, nonatomic)Room* selectedRoom;
@property(strong, nonatomic)UITextField* firstName;
@property(strong, nonatomic)UITextField* lastName;
@property(strong, nonatomic)UITextField* email;
@property(strong, nonatomic)NSDate* startDate;
@property(strong, nonatomic)NSDate* endDate;
@end

@implementation BookViewControlla

-(void)setSelectedRoom:(Room *)selectedRoom{
    _selectedRoom = selectedRoom;
}

- (void)viewDidLoad {
    NSLog(@"Inside of BookViewControlla");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}



- (void)loadView{
    [super loadView];
    self.navigationController.topViewController.title = @"Booking Info.";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUpTextFields];
    
}

#pragma mark UITextFieldDelegate


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    //255, 232, 233
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
    NSLog(@"Text So Far: %@",textField.text);
    if (![[textField text] isEqualToString:@""]) {
        [[[self navigationItem] rightBarButtonItem] setEnabled:"YES"];
        
    }
    
    NSLog(@"Inside of textFieldDidEndEditing");
    [[[self navigationItem] rightBarButtonItem] setEnabled:"NO"];
    
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
#pragma mark helper methods

-(void)makeGuest{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext: [appDelegate.persistentContainer viewContext]];
    guest.firstName = self.firstName.text;
    guest.lastName = self.lastName.text;
    guest.email = self.email.text;
    
    Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext: [appDelegate.persistentContainer viewContext]];
    reservation.startDate = self.startDate;
    reservation.endDate = self.endDate;
    reservation.guest = guest;
    reservation.room = self.selectedRoom;
    
    
    NSError *saveError;
    [appDelegate.persistentContainer.viewContext save:&saveError];
    
    if (saveError){
        NSLog(@"Failed to save to Core Data.");
    } else {
        NSLog(@"Successfully saved to Core Data.");
        [[self navigationController] popToRootViewControllerAnimated:YES];
    }
    
}


-(void)setUpDoneButton{

    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    
    [done setEnabled:NO];
    [[self navigationItem] setRightBarButtonItem:done];
}

-(void)doneButtonPressed{
    if ([[[self firstName] text] isEqualToString:@""]) {
        [[self firstName]setPlaceholder:@"Required."];
    } else {
        [self makeGuest];
    }
}
-(void)autoLayoutForTextFields{
    //set placeholder text
    [self.firstName setPlaceholder:@"First Name (Required)"];
    [self.lastName setPlaceholder:@"Last Name"];
    [self.email setPlaceholder:@"Email"];
    
    
    //set border style
    [self.firstName setBorderStyle:UITextBorderStyleRoundedRect];
    [self.lastName setBorderStyle:UITextBorderStyleRoundedRect];
    [self.email setBorderStyle:UITextBorderStyleRoundedRect];
    
    CGFloat navBarHeight = CGRectGetHeight([[[self navigationController] navigationBar] frame]);
    CGFloat statusBarHeight = 20.0;
    CGFloat topMargin = navBarHeight + statusBarHeight;
    
    NSDictionary *viewDictionary = @{@"firstName":self.firstName, @"lastName":self.lastName, @"email":self.email};
    
    NSDictionary *metricDictionary = @{@"topMargin":[NSNumber numberWithFloat:topMargin]};
    
    NSString *visualFormat = @"V:|-200-[firstName]-[lastName]-[email]";
    
    
    
    [AutoLayout leadingConstraintFromView:self.firstName toView:self.view];
    [AutoLayout trailingConstraintFromView:self.firstName toView:self.view];
    [AutoLayout leadingConstraintFromView:self.lastName toView:self.view];
    [AutoLayout trailingConstraintFromView:self.lastName toView:self.view];
    [AutoLayout leadingConstraintFromView:self.email toView:self.view];
    [AutoLayout trailingConstraintFromView:self.email toView:self.view];
    
    [AutoLayout constraintsWithVFLForViewDictionary:viewDictionary forMetricsDictionary:metricDictionary withOptions:0 withVisualFormat:visualFormat];
    
    [self.firstName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.lastName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.email setTranslatesAutoresizingMaskIntoConstraints:NO];
}

-(void)setUpTextFields{
    self.firstName = [[UITextField alloc]init];
    self.lastName = [[UITextField alloc]init];
    self.email = [[UITextField alloc]init];
    
    self.firstName.delegate = self;
    
    
    [[self view] addSubview:self.firstName];
    [[self view] addSubview:self.lastName];
    [[self view] addSubview:self.email];
    
    [self setUpDoneButton];
    [self autoLayoutForTextFields];
}



@end
