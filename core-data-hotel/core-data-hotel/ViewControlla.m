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
    [AutoLayout topConstraintFromView:browseButton toView:self.view];

    
    browseButton.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.75 alpha:0.5];
    
    NSLayoutConstraint *browseHeight = [AutoLayout equalHeightConstraintFromView:browseButton toView:self.view withMultiplier:0.33];
    
    
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
