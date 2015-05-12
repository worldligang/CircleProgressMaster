//
//  ViewController.m
//  CircleProgressMaster
//
//  Created by ligang on 15/5/12.
//  Copyright (c) 2015年 ligang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initCircleProcessView];
    
    [self performSelector:@selector(test) withObject:self afterDelay:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test
{
    [_circleProgressView setLeftProgressBarProgressColor:[UIColor colorWithRed:0.000 green:0.824 blue:0.675 alpha:1]];
    [_circleProgressView setLeftProgress:90/100.0 animated:YES];
    [_circleProgressView setRightProgressBarProgressColor:[UIColor colorWithRed:0.200 green:0.824 blue:0.375 alpha:1]];
    [_circleProgressView setRightProgress:90/100.0 animated:YES];
}

-(void)initCircleProcessView
{
    _circleProgressView = [[XYCameraSettingsCircleProgressView alloc] initWithFrame:CGRectMake(0, 0, 0.6*self.view.frame.size.height, 0.6*self.view.frame.size.height)];
    _circleProgressView.center = CGPointMake(self.view.frame.size.width/2, (self.view.frame.size.height-1)/2);
    _circleProgressView.backgroundColor = [UIColor clearColor];
    [_circleProgressView setProgressBarWidth:0.08*self.view.frame.size.height];
    [_circleProgressView setLeftProgressBarProgressColor:[UIColor colorWithRed:0.000 green:0.824 blue:0.675 alpha:1] andRight:[UIColor colorWithRed:0.314 green:0.522 blue:0.980 alpha:1]];
    [_circleProgressView setLeftProgressBarTrackColor:[UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1] andRight:[UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1]];
    [self.view addSubview:_circleProgressView];
}

@end
