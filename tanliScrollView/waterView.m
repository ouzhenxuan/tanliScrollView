//
//  waterView.m
//  tanliScrollView
//
//  Created by ouzhenxuan on 15/12/9.
//  Copyright © 2015年 ouzhenxuan. All rights reserved.
//

#import "waterView.h"
static NSString * const kName = @"name";

static CGFloat const kRadius = 40;
static CGFloat const kLineWidth = 6;
static CGFloat const kStep1Duration = 1.0;
static CGFloat const kStep2Duration = 0.5;
static CGFloat const kStep3Duration = 0.15;
static CGFloat const kStep4Duration = 5.0;
static CGFloat const kVerticalMoveLayerHeight = 15;
static CGFloat const kVerticalThinLayerWidth = 3;
static CGFloat const kYScale = 0.8;
static CGFloat const kVerticalFatLayerWidth = 6;


#define caLayerWidth 1000


@interface waterView ()
{
    BOOL isPushed;

}

@end


@implementation waterView

- (instancetype)init{
//    self = [[NSBundle mainBundle] loadNibNamed:[self.class description] owner:self options:nil][0];
    if (self) {
        [self setupTheView];
        isPushed = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTheView];
        isPushed = NO;
        UIPanGestureRecognizer * panTheWater = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleThePanWater:)];
        [self addGestureRecognizer:panTheWater];
        
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - public
- (void)startAnimation {
    [self reset];
    [self doStep1];
}

- (void)reset {
    [self.arcWaterLayer removeFromSuperlayer];
}

- (void)setupTheView {
    
    self.arcWaterLayer = [waterLayer layer];
    self.arcWaterLayer.color = [UIColor blackColor];
    self.arcWaterLayer.lineWidth = 1.0;
    self.arcWaterLayer.layerHeight = caLayerWidth;
    self.arcWaterLayer.myViewY = 0.0;
    [self.layer addSublayer:self.arcWaterLayer];
    
    CGRect rect = CGRectMake(-100, (caLayerWidth - DEVICEH)/2, 200, DEVICEH);
    self.arcWaterLayer.bounds =rect;
//    self.arcWaterLayer.backgroundColor = [UIColor clearColor].CGColor;
    CGPoint point =  CGPointMake(100, CGRectGetMidY(self.bounds));
    self.arcWaterLayer.position = point;
    
//    self.arcWaterLayer.bounds = CGRectMake(-100, (DEVICEH - caLayerWidth)/2, 200, DEVICEH);
//    self.arcWaterLayer.position = CGPointMake(caLayerWidth/2, CGRectGetMidY(self.bounds));
    
    // animation
    self.arcWaterLayer.radian = 1; // end status
    [self.arcWaterLayer setNeedsDisplay];

}

// 第1阶段
- (void)doStep1 {
    
    self.arcWaterLayer = [waterLayer layer];
    self.arcWaterLayer.color = [UIColor blackColor];
    self.arcWaterLayer.lineWidth = 1.0;
    self.arcWaterLayer.layerHeight = caLayerWidth;
    [self.layer addSublayer:self.arcWaterLayer];
    
    CGRect rect = CGRectMake(-100, (caLayerWidth - DEVICEH)/2, 200, DEVICEH);
    self.arcWaterLayer.bounds =rect;
//    self.arcWaterLayer.backgroundColor = [UIColor clearColor].CGColor;
    CGPoint point =  CGPointMake(100, CGRectGetMidY(self.bounds));
    self.arcWaterLayer.position = point;

    
    // animation
    self.arcWaterLayer.radian = 1; // end status

    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"radian"];
    animation.duration = kStep1Duration;
    animation.fromValue = @0.5;
    animation.toValue = @1.0;
    animation.delegate = self;
    [animation setValue:@"step1" forKey:kName];
    [self.arcWaterLayer addAnimation:animation forKey:nil];
}


//拖动时calayer距离顶部的距离
- (void)panTheWaterView:(CGFloat)panX{
    self.arcWaterLayer.myViewY = -panX;
    [self.arcWaterLayer setNeedsDisplay];
}

//结束拖动时的动画
- (void)endToPanTheWaterView {
    CGFloat myY =  self.arcWaterLayer.myViewY;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"myViewY"];
    animation.duration = kStep1Duration;
    animation.fromValue = @(myY);
    animation.toValue = @0.0;
    animation.delegate = self;
    [animation setValue:@"endAnimation" forKey:kName];
    [self.arcWaterLayer addAnimation:animation forKey:nil];
    self.arcWaterLayer.myViewY = 0; // end status
}

- (void)handleThePanWater:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        isPushed = NO;
    }else if (sender.state == UIGestureRecognizerStateChanged){
        CGPoint panPoint = [sender translationInView:self];
        NSLog(@"%f",panPoint.x);
        if (fabs(panPoint.x)>=200.0) {
            return;
        }
        if (fabs(panPoint.x)>=100.0 && [self.delegate respondsToSelector:@selector(panTheWater:)]&&!isPushed) {
            [self.delegate panTheWater:panPoint.x];
            self.userInteractionEnabled = NO;
            isPushed = YES;
        }
        [self panTheWaterView:panPoint.x];
    }else if (sender.state == UIGestureRecognizerStateEnded){
        [self endToPanTheWaterView];
    }else if (sender.state == UIGestureRecognizerStateCancelled){
        [self endToPanTheWaterView];
    }

}


@end
