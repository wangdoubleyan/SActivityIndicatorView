//
//  SActivityView.m
//  SActivityIndicatorView
//
//  Created by cpzx4 on 16/3/3.
//  Copyright © 2016年 Sgabg. All rights reserved.
//

#import "SActivityView.h"
#import <QuartzCore/QuartzCore.h>

@interface SActivityView ()
@property (strong, nonatomic) UIColor *defaultColor;
@property (readwrite, nonatomic) BOOL isAnimating;

/**
 Sets up default values
 */
- (void)setupDefaults;

/**
 Adds circles.
 */
- (void)addCircles;

/**
 Removes circles.
 */
- (void)removeCircles;

/**
 Adjusts self's frame.
 */
- (void)adjustFrame;

/**
 Creates the circle view.
 @param radius The radius of the circle.
 @param color The background color of the circle.
 @param positionX The x-position of the circle in the contentView.
 @return The circle view.
 */
- (UIView *)createCircleWithRadius:(CGFloat)radius color:(UIColor *)color positionX:(CGFloat)x;

/**
 Creates the animation of the circle.
 @param duration The duration of the animation.
 @param delay The delay of the animation
 @return The animation of the circle.
 */
- (CABasicAnimation *)createAnimationWithDuration:(CGFloat)duration delay:(CGFloat)delay;

@end


@implementation SActivityView
#pragma mark -
#pragma mark - Initializations

- (id)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

#pragma mark -
#pragma mark - Private Methods

- (void)setupDefaults {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.numberOfCircles = 5;
    self.internalSpacing = 5;
    self.radius = 10;
    self.delay = 0.2;
    self.duration = 0.8;
    self.defaultColor = [UIColor lightGrayColor];
}

- (UIView *)createCircleWithRadius:(CGFloat)radius
                             color:(UIColor *)color
                         positionX:(CGFloat)x {
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(x, 0, radius * 2, radius * 2)];
    circle.backgroundColor = color;
    circle.layer.cornerRadius = radius;
    circle.translatesAutoresizingMaskIntoConstraints = NO;
    return circle;
}

- (CABasicAnimation *)createAnimationWithDuration:(CGFloat)duration delay:(CGFloat)delay {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.delegate = self;
    anim.fromValue = [NSNumber numberWithFloat:0.0f];
    anim.toValue = [NSNumber numberWithFloat:1.0f];
    anim.autoreverses = YES;
    anim.duration = duration;
    anim.removedOnCompletion = NO;
    anim.beginTime = CACurrentMediaTime()+delay;
    anim.repeatCount = INFINITY;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return anim;
}

- (void)addCircles {
    for (NSUInteger i = 0; i < self.numberOfCircles; i++) {
        UIColor *color = nil;
        if (self.delegate && [self.delegate respondsToSelector:@selector(activityIndicatorView:circleBackgroundColorAtIndex:)]) {
            color = [self.delegate activityIndicatorView:self circleBackgroundColorAtIndex:i];
        }
        
        switch (i) {
            case 0:
                color=[UIColor colorWithRed:66/255.0 green:133/255.0 blue:244/255.0 alpha:1.0];
                
                break;
            case 1:
                color= [UIColor colorWithRed:234/255.0 green:67/255.0 blue:53/255.0 alpha:1.0];
                
                break;
            case 2:
                color= [UIColor colorWithRed:251/255.0 green:188/255.0 blue:5/255.0 alpha:1.0];
                
                break;
            case 3:
                color= [UIColor colorWithRed:52/255.0 green:168/255.0 blue:83/255.0 alpha:1.0];
                
                break;
                
            default:
                color= [UIColor colorWithRed:234/255.0 green:67/255.0 blue:53/255.0 alpha:1.0];
                break;
        }
        
        
        UIView *circle = [self createCircleWithRadius:self.radius
                                                color:(color == nil) ? self.defaultColor : color
                                            positionX:(i * ((2 * self.radius) + self.internalSpacing))];
        [circle setTransform:CGAffineTransformMakeScale(0, 0)];
        [circle.layer addAnimation:[self createAnimationWithDuration:self.duration delay:(i * self.delay)] forKey:@"scale"];
        [self addSubview:circle];
    }
}

- (void)removeCircles {
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

- (void)adjustFrame {
    CGRect frame = self.frame;
    frame.size.width = (self.numberOfCircles * ((2 * self.radius) + self.internalSpacing)) - self.internalSpacing;
    frame.size.height = self.radius * 2;
    self.frame = frame;
}

#pragma mark -
#pragma mark - Public Methods

- (void)startAnimating {
    if (!self.isAnimating) {
        [self addCircles];
        self.hidden = NO;
        self.isAnimating = YES;
    }
}

- (void)stopAnimating {
    if (self.isAnimating) {
        [self removeCircles];
        self.hidden = YES;
        self.isAnimating = NO;
    }
}

#pragma mark -
#pragma mark - Custom Setters and Getters

- (void)setNumberOfCircles:(NSUInteger)numberOfCircles {
    _numberOfCircles = numberOfCircles;
    [self adjustFrame];
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    [self adjustFrame];
}

- (void)setInternalSpacing:(CGFloat)internalSpacing {
    _internalSpacing = internalSpacing;
    [self adjustFrame];
}

@end
