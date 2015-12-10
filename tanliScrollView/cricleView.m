//
//  cricleView.m
//  tanliScrollView
//
//  Created by ouzhenxuan on 15/12/7.
//  Copyright © 2015年 ouzhenxuan. All rights reserved.
//

#import "cricleView.h"

#ifndef TransformRadian
#define TransformRadian(angle) (angle) *M_PI/180.0f
#endif

#define devWidth [UIScreen mainScreen].bounds.size.width
#define devHeight [UIScreen mainScreen].bounds.size.height

#define circleWidth 1000

@interface cricleView ()<UIGestureRecognizerDelegate>
{
    CGPoint _centreCircle;
    
    //圆的半径
    CGFloat radius;
    //圆心（在CircleView上的位置）
    CGPoint center;
    //平均角度
    CGFloat average_radina;
    //拖动的点
    CGPoint pointDrag;
}
@property CGAffineTransform startTransform;


@end

static float deltaAngle;

@implementation cricleView
@synthesize startTransform;
-(id)initWithWidth:(CGFloat)width numArray:(NSArray*)numArray leftHanded:(BOOL)leftHanded arcCenter:(CGPoint)theCenter radius:(double)theRadius {
    
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect screenRect = CGRectMake(100-circleWidth, -(circleWidth-devHeight)/2, circleWidth, circleWidth);
//        CGRect screenRect = CGRectMake(0, 0, circleWidth, circleWidth);
    self = [super initWithFrame:screenRect];
    if (self) {
        // Initialization code
        _centreCircle = CGPointMake(circleWidth/2, circleWidth/2);
        self.backgroundColor = [UIColor clearColor];
    }
    self.userInteractionEnabled = YES;
//    UIPanGestureRecognizer * pantheView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSinglePan:)];
//    [self addGestureRecognizer:pantheView];
    return self;
}


- (float) calculateDistanceFromCenter:(CGPoint)point {
    
    CGPoint center1 = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    float dx = point.x - center1.x;
    float dy = point.y - center1.y;
    return sqrt(dx*dx + dy*dy);
    
}


- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    float dx = touchPoint.x - self.center.x;
    float dy = touchPoint.y - self.center.y;
    deltaAngle = atan2(dy,dx);
    NSLog(@"before x:%f y :%f center :x:%f y:%f %f",touchPoint.x , touchPoint.y , self.center.x , self.center.y,deltaAngle);
    startTransform = self.transform;
}


- (void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    
    float dx = pt.x  - circleWidth/2;
    float dy = pt.y  - circleWidth/2;
    
    float ang = atan2(dy,dx);
    
    CGPoint lastPt=[touch previousLocationInView:self];
    
    float dx1 = lastPt.x  - circleWidth/2;
    float dy1 = lastPt.y  - circleWidth/2;
    
    float ang1 = atan2(dy1,dx1);
    
    float angleDifference = ang1 - ang;
    NSLog(@"after x:%f y :%f center :x: %f y: %f %f",pt.x , pt.y,self.center.x , self.center.y,  angleDifference);
    self.transform = CGAffineTransformRotate(self.transform, -angleDifference);
}


////手势操作
- (void)handleSinglePan:(id)sender{
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)sender;
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint touchPoint = [panGesture locationInView:self];
            
            float dx = touchPoint.x - circleWidth/2;
            float dy = touchPoint.y - circleWidth/2;
            deltaAngle = atan2(dy,dx);
            NSLog(@"before x:%f y :%f  %f",dx , dy , deltaAngle);
            startTransform = self.transform;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
            CGPoint pt = [panGesture locationInView:self];


            float dx = pt.x  - circleWidth/2;
            float dy = pt.y  - circleWidth/2;

            float ang = atan2(dy,dx);
        
            float angleDifference = deltaAngle - ang;
            NSLog(@"after x:%f y :%f  %f",dx , dy , angleDifference);
            self.transform = CGAffineTransformRotate(startTransform, -angleDifference);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
            
        default:
            break;
    }
}




#pragma mark - 画好布局
//画圆，画东西
- (void)drawRect:(CGRect)rect{
    
    
    
    
//    float r =98.0f;
    float r =circleWidth/2.0f;
    
    float spaceToCircle =2.0f;
    
    float heightOfHour =15.0f;
    
    float heightOfMinute =7.0f;
    
    float angleOfHour =30.0f;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(c,CGRectMake(0, 0, circleWidth, circleWidth));//因为只要确定了矩形框，圆或者是椭圆就确定了。
    CGContextClip(c);
    
    
    UIColor *_fillColor =[UIColor colorWithRed:17/255.0 green:25/255.0 blue:68/255.0 alpha:0.8];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddArc(path, NULL, _centreCircle.x, _centreCircle.y, r, 0, 2*M_PI, false);
    
    
    
    CGContextSetStrokeColorWithColor(c, [[UIColor colorWithWhite:0.8f alpha:1.0] CGColor]);
    CGContextSetFillColorWithColor(c, [_fillColor CGColor]);
    
    CGContextAddPath(c, path);
    CGContextDrawPath(c, kCGPathFillStroke);
    
    //
    CGContextSetStrokeColorWithColor(c, [[UIColor colorWithWhite:1.0f alpha:1.0] CGColor]);
    CGContextSetLineWidth(c, 2.0f);
    
    CGContextScaleCTM(c, 1, -1);
    CGContextTranslateCTM(c, 0, -rect.size.height);
    
    for (int i=0; i<12; i++) {
        
        float radian =TransformRadian(angleOfHour *i);
        
        //字体大小
        float fontSize =20.0f;
        
        //t 为数字与刻度之间的间隔
        float t =14.0f;
        
        CGPoint p1 =CGPointMake(_centreCircle.x +(r -spaceToCircle)*sinf(radian), _centreCircle.y +(r -spaceToCircle) *cosf(radian));
        
        CGPoint p2 =CGPointMake(_centreCircle.x +(r -spaceToCircle -heightOfHour)*sinf(radian), _centreCircle.y +(r -spaceToCircle -heightOfHour) *cosf(radian));
        
        CGPoint p3 =CGPointMake(_centreCircle.x +(r -spaceToCircle -heightOfHour -t)*sinf(radian), _centreCircle.y +(r -spaceToCircle -heightOfHour -t) *cosf(radian));
        
        CGContextMoveToPoint(c, p1.x, p1.y);
        CGContextAddLineToPoint(c, p2.x, p2.y);
        
        CGContextSaveGState(c);
        
        [[UIColor whiteColor] set];
        
        NSString *strAngle =[NSString stringWithFormat:@"%d",(i ==0)?12:i];
        
        CGPoint p4 =CGPointMake(p3.x -[strAngle length] *fontSize/4, p3.y -fontSize/3);
        
        CGContextSelectFont(c, "Helvetica", fontSize, kCGEncodingMacRoman);
        CGContextSetTextDrawingMode(c, kCGTextFill);
        
        CGContextShowTextAtPoint(c, p4.x, p4.y, [strAngle UTF8String], [strAngle length]);
        
        CGContextRestoreGState(c);
    }
    
    float angleOfMinute =6.0f;
    
    for (int i=0; i<60; i++) {
        
        float radian =TransformRadian(angleOfMinute *i);
        
        CGPoint p1 =CGPointMake(_centreCircle.x +(r -spaceToCircle)*sinf(radian), _centreCircle.y -(r -spaceToCircle) *cosf(radian));
        
        CGPoint p2 =CGPointMake(_centreCircle.x +(r -spaceToCircle -heightOfMinute)*sinf(radian), _centreCircle.y -(r -spaceToCircle -heightOfMinute) *cosf(radian));
        
        CGContextMoveToPoint(c, p1.x, p1.y);
        CGContextAddLineToPoint(c, p2.x, p2.y);
        
    }
    
    CGContextDrawPath(c, kCGPathFillStroke);
    
    CGPathRelease(path);
}





@end
