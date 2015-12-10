//
//  ViewController.m
//  tanliScrollView
//
//  Created by ouzhenxuan on 15/12/4.
//  Copyright © 2015年 ouzhenxuan. All rights reserved.
//

#import "ViewController.h"
#import "cricleView.h"
#import "waterView.h"
#import "twoViewController.h"
#define DEVICEW [UIScreen mainScreen].bounds.size.width
#define DEVICEH [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UIScrollViewDelegate,waterViewDelegate>
{
    UIView * slideView;
    CGFloat beferoOffsetY;
    waterView * wView;
}

@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    wView.userInteractionEnabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    cricleView * cView = [[cricleView alloc] initWithWidth:100 numArray:@[@(12),@(7)] leftHanded:YES arcCenter:CGPointMake(0, 300) radius:200];
    [self.view addSubview:cView];
    
    
    wView = [[waterView alloc] initWithFrame:CGRectMake(0, 0, 200, DEVICEH )];
//    wView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:wView];
    wView.center = CGPointMake(DEVICEW-100, DEVICEH/2);
    wView.delegate = self;
    
}

- (void)panTheWater:(CGFloat)panX{
    twoViewController * twoVc = [[twoViewController alloc] init];
    wView.userInteractionEnabled = NO;
    [self.navigationController pushViewController:twoVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
