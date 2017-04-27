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

-(UILabel *)labelOne {
    return _labelOne;
}

-(UILabel *)labelTwo {
    return _labelTwo;
}

-(UILabel *)labelThree{
    return _labelThree;
}

-(void)initializeLabels {
    self.labelOne = [[UILabel alloc] init];
    self.labelTwo = [[UILabel alloc] init];
    self.labelThree = [[UILabel alloc] init];
}




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    [self initializeLabels];
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UILabel *labelOne = [self labelOne];
        [labelOne setTextColor:[UIColor blackColor]];
        [labelOne setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [labelOne setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:labelOne];
        
        
        
        UILabel *labelTwo = [self labelTwo];
        [labelTwo setTextColor:[UIColor blackColor]];
        [labelTwo setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [labelTwo setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:labelTwo];
        
        UILabel *labelThree = [self labelThree];;
        [labelThree setTextColor:[UIColor blackColor]];
        [labelThree setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [labelThree setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:labelThree];
        
        NSDictionary *views = @{@"labelOne": labelOne, @"labelTwo": labelTwo, @"labelThree":labelThree};
        NSArray *horizontalConstraintOne = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[labelOne]|"
                                                                                          options: 0
                                                                                          metrics:nil
                                                                                            views:views];
        NSArray *horizontalConstraintTwo = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[labelTwo]|"
                                                                                   options: 0
                                                                                   metrics:nil
                                                                                     views:views];
        NSArray *horizontalConstraintThree = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[labelThree]|"
                                                                                     options: 0
                                                                                     metrics:nil
                                                                                       views:views];
        

        [NSLayoutConstraint activateConstraints:horizontalConstraintOne];
        [NSLayoutConstraint activateConstraints:horizontalConstraintTwo];
        [NSLayoutConstraint activateConstraints:horizontalConstraintThree];
        [self.contentView addConstraints:horizontalConstraintOne];
        [self.contentView addConstraints:horizontalConstraintTwo];
        [self.contentView addConstraints:horizontalConstraintThree];
        
        
        NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[labelOne]-[labelTwo]-[labelThree]-20-|"
                                                                  options: 0
                                                                  metrics:nil
                                                                    views:views];
        [NSLayoutConstraint activateConstraints:verticalConstraints];
        [self.contentView addConstraints:verticalConstraints];
    }
    return self;
    
}
@end
