//
//  ViewController.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/24/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "ViewControlla.h"

@interface ViewControlla ()

@end

@implementation ViewControlla


-(void)loadView{
    [super loadView];
    
    //Changes background of viewController
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setupLayout{
    
    UIButton *browseButton = [self createButtonWithTitle:@"Browse"];
    UIButton *bookButton = [self createButtonWithTitle:@"Book"];
    UIButton *lookupButton = [self createButtonWithTitle:@"Look Up"];
    
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
