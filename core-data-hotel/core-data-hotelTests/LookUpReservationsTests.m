//
//  LookReservationsTests.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/27/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LookUpReservationsControlla.h"

@interface LookUpReservationsTests : XCTestCase

@property(strong, nonatomic) NSDate *testDate;
@property(strong, nonatomic) NSString *testFirstName;
@property(strong, nonatomic) NSString *testLastName;
@property(strong, nonatomic) NSString *testSearchTerms;


@end

@implementation LookUpReservationsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.testDate = [[NSDate alloc]initWithTimeIntervalSinceNow:[[NSDate date] timeIntervalSinceNow]];
    
    self.testFirstName = @"firstName";
    self.testLastName = @"lastName";
    self.testSearchTerms = @"guest.firstName";
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.testDate = nil;
    
    self.testFirstName = nil;
    self.testLastName = nil;
    self.testSearchTerms = nil;
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

//Unit Test 4
-(void)testFilterByFirstNameandLastNameUsingSearchTerms{
    
    id predicate = [LookUpReservationsControlla filterByFirstName:self.testFirstName andLastName:self.testLastName usingSearchTerms:self.testSearchTerms];
    //Assertion 7
    //Checks to see if filter method returns a predicate
    XCTAssert([predicate isKindOfClass:[NSPredicate class]], @"The filter method did not return a predicate.");
    
    //Assertion 8
    //Makes sure that the method throws an exception when given wrong input
    XCTAssertThrows([LookUpReservationsControlla filterByFirstName:nil andLastName:nil usingSearchTerms:nil],@"filter method did not throw.");
    
}


@end
