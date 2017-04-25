//
//  AutoLayout.m
//  core-data-hotel
//
//  Created by Elyanil Liranzo Castro on 4/24/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

#import "AutoLayout.h"

@implementation AutoLayout


+(NSArray *)fullScreenConstraintsWithVFL:(UIView *)view {
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    NSDictionary *viewDictionary = @{ @"view" : view };
    
//If you have specific metrics for constraints, pass a dictionary of constraints to constraintsWithVisualFormat method
//    NSNumber *padding = @10.0;
//    NSNumber *paddingMultiplier = @5.0;
//    NSDictionary *metricDictionary = @{@"padding" : padding, @"multiplier" : paddingMultiplier};
    
    

    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                             options:0
                                                                             metrics: nil
                                                                               views:viewDictionary];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[view]|"
                                                                             options:0
                                                                             metrics: nil
                                                                               views:viewDictionary];
    
    [constraints addObjectsFromArray:horizontalConstraints];
    [constraints addObjectsFromArray:verticalConstraints];
    
    [NSLayoutConstraint activateConstraints:constraints];
    
    return constraints.copy;
}

+(NSLayoutConstraint *)genericConstraintFrom:(UIView *)view
                                      toView:(UIView *)superView
                               withAttribute:(NSLayoutAttribute)attribute
                               andMultiplier:(CGFloat)multiplier{
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:view
                                      attribute:attribute
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:superView
                                      attribute:attribute
                                      multiplier:multiplier
                                      constant:0.0];
    constraint.active = YES;
    
    return constraint;
    
}

+(NSLayoutConstraint *)genericConstraintFrom:(UIView *)view
                                      toView:(UIView *)superView
                               withAttribute:(NSLayoutAttribute)attribute{
    return [AutoLayout genericConstraintFrom:view
                                      toView:superView
                               withAttribute:attribute
                               andMultiplier:1.0];
}


+(NSLayoutConstraint *)equalHeightConstraintFromView:(UIView *)view
                                              toView:(UIView *)otherView
                                      withMultiplier:(CGFloat)multiplier{
    
    NSLayoutConstraint *heightConstraint = [AutoLayout genericConstraintFrom:view toView:otherView withAttribute:NSLayoutAttributeHeight andMultiplier:multiplier];
    
    return heightConstraint;
    
}

+(NSLayoutConstraint *)leadingConstraintFromView:(UIView *)view
                                          toView:(UIView *)otherView{
    return [AutoLayout genericConstraintFrom:view toView:otherView withAttribute:NSLayoutAttributeLeading];
    
}

+(NSLayoutConstraint *)trailingConstraintFromView:(UIView *)view
                                       toView:(UIView *)otherView{
    return [AutoLayout genericConstraintFrom:view toView:otherView withAttribute:NSLayoutAttributeTrailing];
}

+(NSLayoutConstraint *)topConstraintFromView:(UIView *)view
                                  toView:(UIView *)otherView {
    return [AutoLayout genericConstraintFrom:view toView:otherView withAttribute:NSLayoutAttributeTop];
}

+(NSLayoutConstraint *)bottomConstraintFromView:(UIView *)view
                                     toView:(UIView *)otherView{
    return [AutoLayout genericConstraintFrom:view toView:otherView withAttribute:NSLayoutAttributeBottom];
}


























@end
