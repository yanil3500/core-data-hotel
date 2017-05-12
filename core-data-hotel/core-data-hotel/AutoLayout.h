//
//  AutoLayout.h
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/24/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

@import UIKit;

@interface AutoLayout : NSObject

+(NSLayoutConstraint *)genericConstraintFrom:(UIView *)view
                                      toView:(UIView *)superView
                               withAttribute:(NSLayoutAttribute)attribute
                               andMultiplier:(CGFloat)multiplier;

+(NSLayoutConstraint *)genericConstraintFrom:(UIView *)view
                                      toView:(UIView *)superView
                               withAttribute:(NSLayoutAttribute)attribute;

+(NSArray *)fullScreenConstraintsWithVFL:(UIView *)view;

+(NSArray *)leadingConstraintAndTrailingConstraintFromView:(UIView *)view
                                                    toView:(UIView *)otherView;

+(NSLayoutConstraint *)equalHeightConstraintFromView:(UIView *)view toView:(UIView *)otherView withMultiplier:(CGFloat)multiplier;

+(NSLayoutConstraint *)leadingConstraintFromView:(UIView *)view toView:(UIView *)otherView;

+(NSLayoutConstraint *)trailingConstraintFromView:(UIView *)view toView:(UIView *)otherView;

+(NSLayoutConstraint *)bottomConstraintFromView:(UIView *)view toView:(UIView *)otherView;

+(NSLayoutConstraint *)topConstraintFromView:(UIView *)view toView:(UIView *)otherView;

+(NSArray *)constraintsWithVFLForViewDictionary:(NSDictionary *)viewDictionary
                           forMetricsDictionary:(NSDictionary *)metricsDictionary
                                    withOptions:(NSLayoutFormatOptions)options
                               withVisualFormat:(NSString *)visualFormat;

@end
