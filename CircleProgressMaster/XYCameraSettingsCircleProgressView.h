//
//  Created by Ash Li on 15/3/31.
//  Copyright (c) 2015年 Ash Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCameraSettingsCircleProgressView : UIView

@property (nonatomic) CGFloat leftProgress;
@property (nonatomic) CGFloat rightProgress;
@property (nonatomic) CGFloat progressBarWidth;

@property (nonatomic) UIColor *leftProgressBarProgressColor;
@property (nonatomic) UIColor *rightProgressBarProgressColor;

@property (nonatomic) UIColor *leftProgressBarTrackColor;
@property (nonatomic) UIColor *rightProgressBarTrackColor;

@property (nonatomic) CGFloat leftProgressStep;
@property (nonatomic) CGFloat rightProgressStep;
@property (nonatomic) CGFloat leftEndProgress;
@property (nonatomic) CGFloat rightEndProgress;

- (void)setLeftProgress:(CGFloat)leftProgress animated:(BOOL)animated;
- (void)setRightProgress:(CGFloat)rightProgress animated:(BOOL)animated;
- (void)setLeftProgress:(CGFloat)leftProgress rightProgress:(CGFloat)rightProgress animated:(BOOL)animated;
- (void)setProgressBarWidth:(CGFloat)progressBarWidth;
- (void)setLeftProgressBarProgressColor:(UIColor *)leftProgressBarProgressColor andRight:(UIColor *)rightProgressBarProgressColor;
- (void)setLeftProgressBarTrackColor:(UIColor *)leftProgressBarTrackColor andRight:(UIColor *)rightProgressBarTrackColor;
@end
