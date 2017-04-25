//
//  ViewController.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/24/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "ViewControlla.h"
#import "AutoLayout.h"
#import "HotelsViewControlla.h"
#import "DatePickerViewControlla.h"

@interface ViewControlla ()

@end

@implementation ViewControlla


-(void)loadView{
    [super loadView];
    self.navigationController.topViewController.title = @"Core Data Hotel";
    //Changes background of viewController
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupLayout];
}

-(void)setupLayout{
    
    UIButton *browseButton = [self createButtonWithTitle:@"Browse"];
    UIButton *bookButton = [self createButtonWithTitle:@"Book"];
    UIButton *lookupButton = [self createButtonWithTitle:@"Look Up"];
    
    [AutoLayout leadingConstraintFromView:browseButton toView:self.view];
    [AutoLayout trailingConstraintFromView:browseButton toView:self.view];
    [AutoLayout leadingConstraintFromView:bookButton toView:self.view];
    [AutoLayout trailingConstraintFromView:bookButton toView:self.view];
    [AutoLayout leadingConstraintFromView:lookupButton toView:self.view];
    [AutoLayout trailingConstraintFromView:lookupButton toView:self.view];
    
    browseButton.backgroundColor = [UIColor colorWithRed:0.13 green:0.38 blue:0.44 alpha:1.0];
    bookButton.backgroundColor = [UIColor colorWithRed:0.65 green:0.54 blue:0.69 alpha:1.0];
    lookupButton.backgroundColor = [UIColor colorWithRed:0.04 green:0.24 blue:0.10 alpha:1.0];
    
    NSLayoutConstraint *browserButtonTop = [AutoLayout genericConstraintFrom:browseButton toView:self.view withAttribute:NSLayoutAttributeTop];
    
    NSLayoutConstraint *bookButtonLocation = [AutoLayout genericConstraintFrom:bookButton toView:self.view withAttribute:NSLayoutAttributeCenterY];
    
    NSLayoutConstraint *lookUpButton = [AutoLayout genericConstraintFrom:lookupButton toView:self.view withAttribute:NSLayoutAttributeBottom];
    
    
    browserButtonTop.constant = CGRectGetHeight(self.navigationController.navigationBar.frame) + 20;
    NSLayoutConstraint *browseHeight = [AutoLayout equalHeightConstraintFromView:browseButton toView:self.view withMultiplier:0.25];
    NSLayoutConstraint *bookHeight = [AutoLayout equalHeightConstraintFromView:bookButton toView:self.view withMultiplier:0.25];
    NSLayoutConstraint *lookUpHeight = [AutoLayout equalHeightConstraintFromView:lookupButton toView:self.view withMultiplier:0.25];
    

    
    [browseButton addTarget:self action:@selector(browseButtonSelected) forControlEvents: UIControlEventTouchUpInside];
    [bookButton addTarget:self action:@selector(bookButtonSelected) forControlEvents:UIControlEventTouchUpInside];
    [lookupButton addTarget:self action:@selector(lookUpButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)browseButtonSelected {
    HotelsViewControlla *hotelViewControlla = [[HotelsViewControlla alloc] init];
    [[self navigationController] pushViewController:hotelViewControlla animated:YES];
    
    NSLog(@"Work on this for lab.");
}

-(void)bookButtonSelected{
    DatePickerViewControlla *datePickerViewControlla = [[DatePickerViewControlla alloc]init];
    [[self navigationController] pushViewController:datePickerViewControlla animated:YES];
    NSLog(@"bookButton selected");
}

-(void)lookUpButtonPressed{
    NSLog(@"lookUpButton selected");
}

-(UIButton *)createButtonWithTitle:(NSString *)title {
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle: title forState: UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    
    [button setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    [[self view] addSubview:button];
    
    return button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
