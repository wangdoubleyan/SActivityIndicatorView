//
//  SActivityView.h
//  SActivityIndicatorView
//
//  Created by cpzx4 on 16/3/3.
//  Copyright © 2016年 Sgabg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SActivityIndicatorViewDelegate;

@interface SActivityView : UIView
/** The number of circle indicators. */
@property (readwrite, nonatomic) NSUInteger numberOfCircles;

/** The spacing between circles. */
@property (readwrite, nonatomic) CGFloat internalSpacing;

/** The radius of each circle. */
@property (readwrite, nonatomic) CGFloat radius;

/** The base animation delay of each circle. */
@property (readwrite, nonatomic) CGFloat delay;

/** The base animation duration of each circle*/
@property (readwrite, nonatomic) CGFloat duration;

/** The assigned delegate */
@property (strong, nonatomic) id<SActivityIndicatorViewDelegate> delegate;


/**
 Starts the animation of the activity indicator.
 */
- (void)startAnimating;

/**
 Stops the animation of the acitivity indciator.
 */
- (void)stopAnimating;

@end

@protocol SActivityIndicatorViewDelegate <NSObject>

@optional

/**
 Gets the user-defined background color for a particular circle.
 @param activityIndicatorView The activityIndicatorView owning the circle.
 @param index The index of a particular circle.
 @return The background color of a particular circle.
 */
- (UIColor *)activityIndicatorView:(SActivityView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index;


@end
