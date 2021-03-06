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
    
    
    
    [AutoLayout helperSetTranslatesAutoResizingMaskIntoConstraints:view];
    
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                             options:0
                                                                             metrics: nil
                                                                               views:viewDictionary];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
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

+(void)helperSetTranslatesAutoResizingMaskIntoConstraints:(UIView *)view{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
}

+(NSArray *)leadingConstraintAndTrailingConstraintFromView:(UIView *)view
toView:(UIView *)otherView{
    
    [AutoLayout helperSetTranslatesAutoResizingMaskIntoConstraints:view];
    return @[[AutoLayout leadingConstraintFromView:view toView:otherView],
             [AutoLayout trailingConstraintFromView:view toView:otherView]];
}

+(NSLayoutConstraint *)topConstraintFromView:(UIView *)view
                                  toView:(UIView *)otherView {
    return [AutoLayout genericConstraintFrom:view toView:otherView withAttribute:NSLayoutAttributeTop];
}

+(NSLayoutConstraint *)bottomConstraintFromView:(UIView *)view
                                     toView:(UIView *)otherView{
    return [AutoLayout genericConstraintFrom:view toView:otherView withAttribute:NSLayoutAttributeBottom];
}

+(NSLayoutConstraint *)heightConstraintFromView:(UIView *)view
                                          toView:(UIView *)otherView{
    return [AutoLayout genericConstraintFrom:view toView:otherView withAttribute:NSLayoutAttributeHeight];
}



+(NSArray *)constraintsWithVFLForViewDictionary:(NSDictionary *)viewDictionary
                           forMetricsDictionary:(NSDictionary *)metricsDictionary
                                    withOptions:(NSLayoutFormatOptions)options
                               withVisualFormat:(NSString *)visualFormat{
    NSArray *constraints = [[NSArray alloc]init];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                          options:options
                                                          metrics:metricsDictionary
                                                            views:viewDictionary];
    [NSLayoutConstraint activateConstraints:constraints];
    return constraints.copy;
}






















@end
