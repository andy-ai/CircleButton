//
//  RotateImageView.m
//  CircleButton
//
//  Created by andy ai on 13-11-13.
//  Copyright (c) 2013年 andy ai. All rights reserved.
//

#import "RotateImageView.h"
#import "MathsFun.h"
#import "CircleButtonSkinView.h"
#import "AppDelegate.h"
// 判断touch落点的矫正范围
#define VALIDTOUCH_ADJUST_VALUE 20
// 判断滑动到最大最小的矫正范围
#define VALIDLIMIT_ADJUST_VALUE  0.101 
//#define radiansToDegrees(x) (180.0 * x / M_PI)
#define FIREMIN_DISTANCE  0.11


@implementation RotateImageView
@synthesize rotation;
@synthesize indicator;
@synthesize indicatorPoint;
@synthesize indicatorRadius;
@synthesize skinView;
@synthesize minRotation;
@synthesize maxRotation;
@synthesize enableIndicatorIg,disableIndicatorIg;
@synthesize mouseReleaseBlock;

-(void) initViewL
{

    CGRect rc = CGRectMake(0,0,CGRectGetWidth(self.bounds),CGRectGetHeight(self.bounds));

    CircleButtonSkinView* pView = [[CircleButtonSkinView alloc] initWithFrame:rc];

    pView.backgroundColor = [UIColor clearColor];
    [self addSubview:pView];
    self.skinView = pView;
    [pView release];
    
    

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isEanble = TRUE;
        [self initViewL];
    }
    return self;
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self setNeedsDisplay];
    //[self.skinView setNeedsDisplay];
    fireSumvalue = 0;
    [super touchesBegan:touches withEvent:event];
}

CGFloat angleBetweenPoints(CGPoint first, CGPoint second) {
    CGFloat height = second.y - first.y;
    CGFloat width = first.x - second.x;
    CGFloat rads = atan(height/width);
    return radiansToDegrees(rads);
    //degs = degrees(atan((top - bottom)/(right - left)))
}


-(Boolean) isValidPointForTouch:(CGPoint)point centerPoint:(CGPoint)centerPoint
{
    float distance = [MathsFun distanceFromPointX:point distanceToPointY:centerPoint];
    float radius = CGRectGetWidth([self bounds])/2;
    radius -= 10;
    float absValue = fabs(distance -radius);
    if(absValue > VALIDTOUCH_ADJUST_VALUE)
    {
       // NSLog(@" out circle absValue= %f ,distance = %f, radius = %f",absValue,distance,radius);
        return false;
    }
    //NSLog(@" 1111111111111111111111111111111111111 circle ");
    
    ///// 判断角度
    CGPoint srcPoint;
    srcPoint.x = 158;//根据极坐标计算得出
    srcPoint.y = 70;
    CGFloat curRotate = angleBetweenPoints(centerPoint, point);
    NSLog(@" curRotate = %f",curRotate);
    if(point.x >= centerPoint.x)
    {
        //float x_dis = point.x - centerPoint.x;
       // CGFloat rads = atan(height/width);
        //float curAngle = asinf(x_dis/radius);
    }
    else{
        
    }
    return true;
}


-(void) adJustIndicator:(CGFloat) angle 
{
    if(angle < minRotation)
        angle = minRotation;
    if(angle > maxRotation)
        angle = maxRotation;
    if(angle - minRotation <= VALIDLIMIT_ADJUST_VALUE)
        angle = minRotation;
    if(maxRotation - angle <= VALIDLIMIT_ADJUST_VALUE)
        angle = maxRotation;
    if(angle == self.minRotation && self.indicator.image != self.disableIndicatorIg)
    {
        indicator.image = self.disableIndicatorIg;
    }
    if(angle != self.minRotation && self.indicator.image == self.disableIndicatorIg)
        self.indicator.image = self.enableIndicatorIg;

    indicator.center = CGPointMake(indicatorRadius * cosf(angle) + CGRectGetMidX(self.bounds),
                                   indicatorRadius * sinf(angle) + CGRectGetMidY(self.bounds));
    //indicator.image.
    if(angle == self.minRotation)
    {
        self.skinView.endAngle = self.minRotation;
        self.skinView.startAngle = self.minRotation;
    }
    else
    {
       // self.skinView.endAngle = rotation;//modify 2014/2/27
        self.skinView.endAngle = angle;
        self.skinView.startAngle = self.minRotation;

    }
    [self.skinView setNeedsDisplay];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!_isEanble)
        return;
    // We can look at any touch object since we know we
    // have only 1. If there were more than 1 then
    // touchesBegan:withEvent: would have failed the recognizer.
    UITouch *touch = [touches anyObject];
    
    
    // To rotate with one finger, we simulate a second finger.
    // The second figure is on the opposite side of the virtual
    // circle that represents the rotation gesture.
    
    
    CGPoint center = CGPointMake(CGRectGetMidX([self bounds]), CGRectGetMidY([self bounds]));
    CGPoint currentTouchPoint = [touch locationInView:self];
    //
    // float centerPoint = [;
   // NSLog(@" curpoint.x = %f, curPoint.y = %f",currentTouchPoint.x,currentTouchPoint.y);
    
    /*if(![self isValidPointForTouch:currentTouchPoint centerPoint:center])
    {
        return;
    }*/
    //
    CGPoint previousTouchPoint = [touch previousLocationInView:self];
    
    CGFloat angleInRadians = atan2f(currentTouchPoint.y - center.y, currentTouchPoint.x - center.x) - atan2f(previousTouchPoint.y - center.y, previousTouchPoint.x - center.x);
    //add 调试突变
    if(fabsf(angleInRadians) >3)
        return;
    //
   // NSLog(@"rotaition = %f",angleInRadians);
    //_rotation += angleInRadians;
    //Check out of range
    CGFloat curRt = rotation + angleInRadians;
    
    

    if(curRt < minRotation || curRt > maxRotation)
        return;
    rotation = curRt;
    fireSumvalue += angleInRadians;
    //[self adJustIndicator:radiansToDegrees(_rotation)];
    
 
    [self adJustIndicator:rotation];
    /*self.skinView.endAngle = _rotation;
    self.skinView.startAngle = self.minRotation;
    [self.skinView setNeedsDisplay];*/
    if(fabsf(fireSumvalue) < FIREMIN_DISTANCE)
        return;
    else
        fireSumvalue = 0;
    if(mouseReleaseBlock)
    {
        CGFloat temp = self.rotation - self.minRotation;
        mouseReleaseBlock(temp/(self.maxRotation - self.minRotation),TRUE);

    }
    
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!_isEanble)
        return;
    assert(self.minRotation != self.maxRotation);
    fireSumvalue = 0;
    if(!mouseReleaseBlock)
        return;
    CGFloat temp = self.rotation - self.minRotation;
    if(temp  <= VALIDLIMIT_ADJUST_VALUE)
        mouseReleaseBlock(0,FALSE);
    else if(maxRotation - self.rotation <= VALIDLIMIT_ADJUST_VALUE)
    {
        mouseReleaseBlock(1.0,FALSE);
    }
    else
       mouseReleaseBlock(temp/(self.maxRotation - self.minRotation),FALSE);
    [super touchesEnded:touches withEvent:event];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@" touch canceld");
}

-(void) setBackgroundImage:(UIImage*) image
{
    self.image = image;
}
-(void) setSkinViewImage:(UIImage*) image
{
    [self.skinView initSkinImage:image];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [skinView release];
	[ indicator release];
    [disableIndicatorIg release];
    [enableIndicatorIg release];
    [mouseReleaseBlock release];
    [super dealloc];
}

@end
