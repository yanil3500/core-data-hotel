//
//  AutoLayoutTests.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/26/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AutoLayout.h"
#import "ViewControlla.h"


@interface AutoLayoutTests : XCTestCase

@property(strong, nonatomic) UIViewController *testController;

@property(strong, nonatomic) UIView *testView1;

@property(strong, nonatomic) UIView *testView2;

@property(strong, nonatomic) ViewControlla *viewControllaTest;

@property(strong, nonatomic) NSString *buttonTestString;


@end

@implementation AutoLayoutTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.testController = [[UIViewController alloc] init];
    
    self.testView1 = [[UIView alloc]init];
    self.testView2 = [[UIView alloc]init];
    
    [[self.testController view] addSubview:self.testView1];
    [[self.testController view] addSubview:self.testView2];
    
    self.buttonTestString = nil;
    self.viewControllaTest = [[ViewControlla alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.testController = nil;
    self.testView1 = nil;
    self.testView2 = nil;
    self.buttonTestString = nil;
    self.viewControllaTest = nil;
    [super tearDown];
}



-(void)testgenericConstraintFromViewtoViewWithAttribute{
    
    XCTAssertNotNil(self.testController, @"The testcontroller");
    XCTAssertNotNil(self.testView1, @"self.testView1 is nil.");
    XCTAssertNotNil(self.testView2, @"self.testView2 is nil.");
    
    id constraint = [AutoLayout genericConstraintFrom:self.testView1 toView:self.testView2 withAttribute:NSLayoutAttributeTop];
    
    
    XCTAssert([constraint isKindOfClass:[NSLayoutConstraint class]], @"Constraint is not an instance of NSLayoutConstraint.");
    
    XCTAssertTrue([(NSLayoutConstraint *)constraint isActive], @"Constraint was not activated.");
}

//Unit Test 1
-(void)testcreateButtonWithTitle {
    
    id button = [self.viewControllaTest createButtonWithTitle:self.buttonTestString];
    
    //Assertion 1
    //Tests to see if a valid button is created when given an NSString nil
    XCTAssert([button isKindOfClass:[UIButton class]], @"Button is not an instance of NSLayoutConstraint");
}

//Unit Test 2
-(void)testleadingConstraintAndTrailingConstraintFromViewtoView{
    
    id constraints = [AutoLayout leadingConstraintAndTrailingConstraintFromView:self.testView1 toView:self.testView2];
    
    //Assertion 2
    //Since the method is responsible for setting two constraints, I'm asserting that the array returned by the method contains two items
    XCTAssertEqual([(NSArray *)constraints count], 2, @"The number of constrains is not equal to two.");
    
    //Assertion 3
    //Tests to see if the method activates the constraints
    XCTAssert([(NSLayoutConstraint *)constraints[0] isActive], @"The constraints were not activated.");
    
    //Assertion 4
    //Checks to see if the method inside of leadingConstraintAndTrailingConstraintFromViewtoView sets translatesAutoResizingMaskIntoConstraints for the view that passed in to NO
    XCTAssertEqual([self.testView1 translatesAutoresizingMaskIntoConstraints], NO,@"The property translatesAutoResizingMaskIntoConstraints has not been set to NO. ");
    
}

//Unit Test 3






@end
