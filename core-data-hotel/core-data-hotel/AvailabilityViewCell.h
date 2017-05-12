//
//  AvailabilityViewCell.h
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/25/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvailabilityViewCell : UITableViewCell

@property(strong, nonatomic) UILabel *labelOne;
@property(strong, nonatomic) UILabel *labelTwo;
@property(strong, nonatomic) UILabel *labelThree;



-(UILabel *)labelOne;
-(UILabel *)labelTwo;
-(UILabel *)labelThree;
@end
