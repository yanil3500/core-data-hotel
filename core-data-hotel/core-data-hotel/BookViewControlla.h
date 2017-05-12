//
//  BookViewControlla.h
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/25/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room+CoreDataClass.h"

@interface BookViewControlla : UIViewController

-(void)setSelectedRoom:(Room *)selectedRoom;

-(void)setStartDate:(NSDate*)start;

-(void)setEndDate:(NSDate*)end;

@end
