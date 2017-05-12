//
//  AvailabilityViewCell.h
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/25/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvailabilityViewCell : UITableViewCell

@property(strong, nonatomic) UILabel *roomNumberForCell;
@property(strong, nonatomic) UILabel *numberOfBedsForCell;
@property(strong, nonatomic) UILabel *roomRateForCell;



-(UILabel *)roomNumberForCell;
-(UILabel *)numberOfBedsForCell;
-(UILabel *)roomRateForCell;
@end
