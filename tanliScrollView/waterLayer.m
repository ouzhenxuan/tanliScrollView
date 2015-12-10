//
//  waterView.m
//  tanliScrollView
//
//  Created by ouzhenxuan on 15/12/8.
//  Copyright © 2015年 ouzhenxuan. All rights reserved.
//

#import "waterLayer.h"

@implementation waterLayer
//@synthesize layerHeight;
@dynamic radian;
@dynamic color;
@dynamic lineWidth;
@dynamic layerHeight;
static float kLineWidth = 6;
+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"radian"]) {
        return YES;
    } else if ([key isEqualToString:@"color"]) {
        return YES;
    } else if ([key isEqualToString:@"lineWidth"]) {
        return YES;
    } else if ([key isEqualToString:@"myViewY"]){
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx {
    NSLog(@"%f",self.layerHeight);
    CGFloat radius = self.radian * self.layerHeight;
//    CGFloat y = self.layerHeight/2 * (1.0-self.radian);
    
    CGContextAddEllipseInRect(ctx,CGRectMake(-_myViewY/2, _myViewY/2, self.layerHeight + _myViewY, radius - _myViewY));//因为只要确定了矩形框，圆或者是椭圆就确定了。
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextSetStrokeColorWithColor(ctx, self.color.CGColor);
    CGContextStrokePath(ctx);
}


- (void)setMyViewY:(CGFloat)myViewY{
    _myViewY = myViewY;

}


@end
