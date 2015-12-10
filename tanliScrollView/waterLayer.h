//
//  waterView.h
//  tanliScrollView
//
//  Created by ouzhenxuan on 15/12/8.
//  Copyright © 2015年 ouzhenxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface waterLayer : CALayer
@property (nonatomic,assign) CGFloat radian;    //弧度。
@property (nonatomic) UIColor *color;           //颜色
@property (nonatomic) CGFloat layerHeight;    //layer的高度
@property (nonatomic) CGFloat lineWidth;        //边框宽度
@property (nonatomic) CGFloat myViewY ;          //y值
@end
