//
//  AvailabilityViewCell.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/25/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "AvailabilityViewCell.h"

@implementation AvailabilityViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UILabel *)roomNumberForCell {
    return _roomNumberForCell;
}

-(UILabel *)numberOfBedsForCell {
    return _numberOfBedsForCell;
}

-(UILabel *)roomRateForCell{
    return _roomRateForCell;
}

-(void)initializeLabels {
    self.roomRateForCell = [[UILabel alloc] init];
    self.roomNumberForCell = [[UILabel alloc] init];
    self.numberOfBedsForCell = [[UILabel alloc] init];
}




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    [self initializeLabels];
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UILabel *roomNumber = [self roomNumberForCell];
        [roomNumber setTextColor:[UIColor blackColor]];
        [roomNumber setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [roomNumber setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:roomNumber];
        
        
        
        UILabel *roomRate = [self roomRateForCell];
        [roomRate setTextColor:[UIColor blackColor]];
        [roomRate setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [roomRate setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:roomRate];
        
        UILabel *numberOfBeds = [self numberOfBedsForCell];;
        [numberOfBeds setTextColor:[UIColor blackColor]];
        [numberOfBeds setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [numberOfBeds setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:numberOfBeds];
        
        NSDictionary *views = @{@"roomNumber": roomNumber, @"roomRate": roomRate, @"numberOfBeds":numberOfBeds};
        NSArray *horizontalConstraintOne = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[roomNumber]|"
                                                                                          options: 0
                                                                                          metrics:nil
                                                                                            views:views];
        NSArray *horizontalConstraintTwo = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[roomRate]|"
                                                                                   options: 0
                                                                                   metrics:nil
                                                                                     views:views];
        NSArray *horizontalConstraintThree = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[numberOfBeds]|"
                                                                                     options: 0
                                                                                     metrics:nil
                                                                                       views:views];
        

        [NSLayoutConstraint activateConstraints:horizontalConstraintOne];
        [NSLayoutConstraint activateConstraints:horizontalConstraintTwo];
        [NSLayoutConstraint activateConstraints:horizontalConstraintThree];
        [self.contentView addConstraints:horizontalConstraintOne];
        [self.contentView addConstraints:horizontalConstraintTwo];
        [self.contentView addConstraints:horizontalConstraintThree];
        
        
        NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[roomNumber]-[roomRate]-[numberOfBeds]-20-|"
                                                                  options: 0
                                                                  metrics:nil
                                                                    views:views];
        [NSLayoutConstraint activateConstraints:verticalConstraints];
        [self.contentView addConstraints:verticalConstraints];
    }
    return self;
    
}
@end
