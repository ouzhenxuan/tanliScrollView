//
//  waterView.h
//  tanliScrollView
//
//  Created by ouzhenxuan on 15/12/9.
//  Copyright © 2015年 ouzhenxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "waterLayer.h"


#define DEVICEW [UIScreen mainScreen].bounds.size.width
#define DEVICEH [UIScreen mainScreen].bounds.size.height



@protocol waterViewDelegate <NSObject>

@optional
- (void)panTheWater:(CGFloat)panX;
@end


@interface waterView : UIView
@property (nonatomic) waterLayer *arcWaterLayer;

@property (nonatomic,weak) id<waterViewDelegate> delegate;

- (void)startAnimation ;
@end
