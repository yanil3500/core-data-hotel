//
//  LookReservationsTests.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/27/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LookUpReservationsControlla.h"

@interface LookReservationsTests : XCTestCase

@property(strong, nonatomic) NSDate *testDate;

@end

@implementation LookReservationsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
        self.testDate = [[NSDate alloc]initWithTimeIntervalSinceNow:[[NSDate date] timeIntervalSinceNow]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.testDate = nil;
    [super tearDown];
}

//Unit Test 3
-(void)testGetDateString{
    id dateString = [LookUpReservationsControlla getDateString:self.testDate];
    
    //Assertion 5
    //Checks to see if getDateString returns a string
    XCTAssert([dateString isKindOfClass:[NSString class]], @"The method did not return a string");
    
    //Assertion 6
    //Makes sure that the method throws an exception when given wrong input
    XCTAssertThrows([LookUpReservationsControlla getDateString:nil],@"The method did not throw.");
    
}


@end
