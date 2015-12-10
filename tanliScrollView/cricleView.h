//
//  cricleView.h
//  tanliScrollView
//
//  Created by ouzhenxuan on 15/12/7.
//  Copyright © 2015年 ouzhenxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cricleView : UIView

-(id)initWithWidth:(CGFloat)width numArray:(NSArray*)numArray leftHanded:(BOOL)leftHanded arcCenter:(CGPoint)theCenter radius:(double)theRadius ;

@end
