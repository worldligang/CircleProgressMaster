//
//  Created by Ash Li on 15/3/31.
//  Copyright (c) 2015年 Ash Li. All rights reserved.
//

#import "XYCameraSettingsCircleProgressView.h"
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define LEFT_FLAG 0
#define RIGHT_FLAG 1
const CGFloat DefaultProgressBarWidth = 5.0f;

// Animation Constants
const CGFloat AnimationChangeTimeStep = 0.01f;

@implementation XYCameraSettingsCircleProgressView
{
    NSTimer *_leftTimer;
    NSTimer *_rightTimer;
}

- (void)setLeftProgress:(CGFloat)leftProgress animated:(BOOL)animated
{
    if (_leftProgress >= 0.95) {
        _leftProgress = 0.95;
    }
    if (leftProgress >= 0.95) {
        leftProgress = 0.95;
    }
    if (_leftProgress == leftProgress)
    {
        return;
    }
    
    [_leftTimer invalidate];
    _leftTimer = nil;
    
    if (animated)
    {
        [self animateProgressBarLeft:leftProgress];
    }
    else
    {
        _leftProgress = leftProgress;
        [self setNeedsDisplay];
    }}

- (void)setRightProgress:(CGFloat)rightProgress animated:(BOOL)animated
{
    if (_rightProgress >= 0.95) {
        _rightProgress = 0.95;
    }
    if (rightProgress >= 0.95) {
        rightProgress = 0.95;
    }
    if (_rightProgress == rightProgress)
    {
        return;
    }
    
    [_rightTimer invalidate];
    _rightTimer = nil;
    
    if (animated)
    {
        [self animateProgressBarRight:rightProgress];
    }
    else
    {
        _rightProgress = rightProgress;
        [self setNeedsDisplay];
    }
}

- (void)setLeftProgress:(CGFloat)leftProgress rightProgress:(CGFloat)rightProgress animated:(BOOL)animated
{
    if (_rightProgress == rightProgress && _leftProgress == leftProgress)
    {
        return;
    }
    
    [_leftTimer invalidate];
    [_rightTimer invalidate];
    _leftTimer = nil;
    _rightTimer = nil;
    
    if (animated)
    {
        [self animateProgressBarLeft:leftProgress right:rightProgress];
    }
    else
    {
        _leftProgress = leftProgress;
        _rightProgress = rightProgress;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGPoint innerCenter = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    CGFloat radius = MIN(innerCenter.x, innerCenter.y);
    //为了保证圆头显示不重叠 此处是一个坑 慎踩!!!!
    if (_leftProgress >= 0.95) {
        _leftProgress = 0.95;
    }
    if (_rightProgress >= 0.95) {
        _rightProgress = 0.95;
    }
    CGFloat leftProgressAngle = (_leftProgress * 180) + 90;
    CGFloat rightProgressAngle = 90-_rightProgress * 180;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    [self drawProgressBar:context leftProgressAngle:leftProgressAngle rightProgressAngle:rightProgressAngle center:innerCenter radius:radius];
}

- (void)setProgressBarWidth:(CGFloat)progressBarWidth
{
    _progressBarWidth = progressBarWidth;
    [self setNeedsDisplay];
}

- (void)setLeftProgressBarProgressColor:(UIColor *)leftProgressBarProgressColor
{
    _leftProgressBarProgressColor = leftProgressBarProgressColor;
    [self setNeedsDisplay];
}

- (void)setRightProgressBarProgressColor:(UIColor *)rightProgressBarProgressColor
{
    _rightProgressBarProgressColor = rightProgressBarProgressColor;
    [self setNeedsDisplay];
}

- (void)setLeftProgressBarProgressColor:(UIColor *)leftProgressBarProgressColor andRight:(UIColor *)rightProgressBarProgressColor
{
    _leftProgressBarProgressColor = leftProgressBarProgressColor;
    _rightProgressBarProgressColor = rightProgressBarProgressColor;
    [self setNeedsDisplay];
}

- (void)setLeftProgressBarTrackColor:(UIColor *)leftProgressBarTrackColor andRight:(UIColor *)rightProgressBarTrackColor
{
    _leftProgressBarTrackColor = leftProgressBarTrackColor;
    _rightProgressBarTrackColor = rightProgressBarTrackColor;
    [self setNeedsDisplay];
}



- (CGFloat)progressBarWidthForDrawing
{
    return (_progressBarWidth > 0 ? _progressBarWidth : DefaultProgressBarWidth);
}

- (void)drawProgressBar:(CGContextRef)context leftProgressAngle:(CGFloat)leftProgressAngle rightProgressAngle:(CGFloat)rightProgressAngle center:(CGPoint)center radius:(CGFloat)radius
{
    CGFloat barWidth = self.progressBarWidthForDrawing;
    if (barWidth > radius) {
        barWidth = radius;
    }
    CGPoint currentPoint;
    //right half
    CGContextSetFillColorWithColor(context,_rightProgressBarTrackColor!=nil?_rightProgressBarTrackColor.CGColor:[UIColor blueColor].CGColor);
    CGContextBeginPath(context);
    CGContextAddArc(context, center.x, center.y, radius, DEGREES_TO_RADIANS(rightProgressAngle), DEGREES_TO_RADIANS(-90), 1);
    CGContextAddArc(context, center.x, center.y, radius - barWidth, DEGREES_TO_RADIANS(-90), DEGREES_TO_RADIANS(rightProgressAngle), 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    CGContextSetFillColorWithColor(context,_rightProgressBarProgressColor!=nil?_rightProgressBarProgressColor.CGColor:[UIColor redColor].CGColor);
    CGContextBeginPath(context);
    CGContextAddArc(context, center.x, center.y, radius, DEGREES_TO_RADIANS(90), DEGREES_TO_RADIANS(rightProgressAngle), 1);
    if (_rightProgress!=1 && _rightProgress!=0) {
        currentPoint=CGContextGetPathCurrentPoint(context);
        CGContextAddArc(context, (radius-barWidth/2)/radius*currentPoint.x+barWidth/2, (radius-barWidth/2)/radius*currentPoint.y+barWidth/2, barWidth/2,DEGREES_TO_RADIANS(0),DEGREES_TO_RADIANS(-360),1);
    }
    CGContextAddArc(context, center.x, center.y, radius - barWidth, DEGREES_TO_RADIANS(rightProgressAngle), DEGREES_TO_RADIANS(90), 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    //left half
    CGContextSetFillColorWithColor(context,_leftProgressBarTrackColor!=nil?_leftProgressBarTrackColor.CGColor:[UIColor blueColor].CGColor);
    CGContextBeginPath(context);
    CGContextAddArc(context, center.x, center.y, radius, DEGREES_TO_RADIANS(leftProgressAngle), DEGREES_TO_RADIANS(270), 0);
    CGContextAddArc(context, center.x, center.y, radius - barWidth, DEGREES_TO_RADIANS(270), DEGREES_TO_RADIANS(leftProgressAngle), 1);
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    CGContextSetFillColorWithColor(context,_leftProgressBarProgressColor!=nil?_leftProgressBarProgressColor.CGColor:[UIColor redColor].CGColor);
    CGContextBeginPath(context);
    CGContextAddArc(context, center.x, center.y, radius, DEGREES_TO_RADIANS(90), DEGREES_TO_RADIANS(leftProgressAngle), 0);
    if (_leftProgress!=1 && _leftProgress!=0) {
        currentPoint=CGContextGetPathCurrentPoint(context);
        CGContextAddArc(context, (radius-barWidth/2)/radius*currentPoint.x+barWidth/2, (radius-barWidth/2)/radius*currentPoint.y+barWidth/2, barWidth/2,DEGREES_TO_RADIANS(-270),DEGREES_TO_RADIANS(90),0);
    }
    CGContextAddArc(context, center.x, center.y, radius - barWidth, DEGREES_TO_RADIANS(leftProgressAngle), DEGREES_TO_RADIANS(90), 1);
    CGContextClosePath(context);
    CGContextFillPath(context);
}

#pragma Animation
- (void)animateProgressBarLeft:(CGFloat)leftProgress
{
    _leftProgressStep = leftProgress * AnimationChangeTimeStep;
    _leftEndProgress = leftProgress;
    _leftProgress = 0;
    _leftTimer = [NSTimer scheduledTimerWithTimeInterval:AnimationChangeTimeStep target:self selector:@selector(updateProgressBarForAnimation:) userInfo:[[NSNumber alloc] initWithFloat:LEFT_FLAG] repeats:YES];
}

- (void)animateProgressBarRight:(CGFloat)rightProgress
{
    _rightProgressStep = rightProgress * AnimationChangeTimeStep;
    _rightEndProgress = rightProgress;
    _rightProgress = 0;
    _rightTimer = [NSTimer scheduledTimerWithTimeInterval:AnimationChangeTimeStep target:self selector:@selector(updateProgressBarForAnimation:) userInfo:[[NSNumber alloc] initWithFloat:RIGHT_FLAG] repeats:YES];
}

- (void)animateProgressBarLeft:(CGFloat)leftProgress right:(CGFloat)rightProgress
{
    _leftProgressStep = leftProgress * AnimationChangeTimeStep;
    _rightProgressStep = rightProgress * AnimationChangeTimeStep;
    _leftEndProgress = leftProgress;
    _rightEndProgress = rightProgress;
    _leftProgress = 0;
    _rightProgress = 0;
    _leftTimer = [NSTimer scheduledTimerWithTimeInterval:AnimationChangeTimeStep target:self selector:@selector(updateProgressBarForAnimation:) userInfo:[[NSNumber alloc] initWithFloat:LEFT_FLAG] repeats:YES];
    _rightTimer = [NSTimer scheduledTimerWithTimeInterval:AnimationChangeTimeStep target:self selector:@selector(updateProgressBarForAnimation:) userInfo:[[NSNumber alloc] initWithFloat:RIGHT_FLAG] repeats:YES];
}

- (void)updateProgressBarForAnimation:(id)timer
{
    int flag = ((NSNumber*)[timer userInfo]).intValue;
    if (flag==LEFT_FLAG)
    {
        _leftProgress += _leftProgressStep;
        if (_leftProgress >= _leftEndProgress)
        {
            [(NSTimer*)timer invalidate];
            timer = nil;
            _leftProgress = _leftEndProgress;
        }
    }
    else
    {
        _rightProgress += _rightProgressStep;
        if (_rightProgress >= _rightEndProgress) {
            [(NSTimer*)timer invalidate];
            timer = nil;
            _rightProgress = _rightEndProgress;
        }
    }
    [self setNeedsDisplay];
}

@end
