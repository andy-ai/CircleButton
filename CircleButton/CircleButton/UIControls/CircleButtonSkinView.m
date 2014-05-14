//
//  CircleButtonSkinView.m
//  CircleButton
//
//  Created by andy ai on 13-11-14.
//  Copyright (c) 2013年 andy ai. All rights reserved.
//

#import "CircleButtonSkinView.h"

@implementation CircleButtonSkinView
@synthesize startAngle;
@synthesize endAngle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
         skinImage = nil;
        skinImageView = nil;
    }
    return self;
}

-(void) initSkinImage:(UIImage*) imageParam
{
    skinImage = imageParam;
    [skinImage retain];
    [skinImageView release];
    skinImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:skinImageView];

}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(void) drawRectWithStoke
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 0.0/255.0,6.0/255.0,255/255.0,1);
    
    
    //设置画笔线条粗细
    CGContextSetLineWidth(context, 2);
    
    
    
    //扇形参数
    // double radius= CGRectGetWidth([self bounds])/2 - 2;//2012/12/13
    double radius= CGRectGetWidth([self bounds])/2 - 6;
    
    int startX= self.frame.size.width/2;//圆心x坐标
    int startY= self.frame.size.height/2;//圆心y坐标
    
    int clockwise=0;//0=逆时针,1=顺时针
    //CGContextAddArc(context, startX, startY, radius, 60* M_PI / 180, 120 * M_PI / 180, clockwise);
    CGContextAddArc(context, startX, startY, radius, startAngle, endAngle, clockwise);
    
    // CGContextClosePath(context);
    
    //CGContextSetShadow(context,CGSizeMake(-20, 0),0.5);
    
    CGContextDrawPath(context, kCGPathStroke);
    //CGContextStrokePath(context);

}

-(void) drawRectWithImage
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef context = CGBitmapContextCreate(NULL, self.bounds.size.width, self.bounds.size.height,
                                                 8, 4 * self.bounds.size.width, colorSpace, 1);//kCGBitmapAlphaInfoMask
    
    
    double radius= CGRectGetWidth([self bounds])/2 - 6;
    
    int startX= self.frame.size.width/2;//圆心x坐标
    int startY= self.frame.size.height/2;//圆心y坐标
    int clockwise=1;//0=逆时针,1=顺时针
   
    CGContextAddArc(context, startX, startY, radius, -startAngle, -endAngle,clockwise);
    CGContextAddArc(context, startX, startY, 0, 0, 0, clockwise);
    CGContextClosePath(context);
    CGContextClip(context);
    
    
    
    CGContextDrawImage(context, self.bounds, skinImage.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    //CGContextRelease(context);
    //CGColorSpaceRelease(colorSpace);

    UIImage *newImage = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    [skinImageView setImage:newImage];
    

}
- (void)drawRect:(CGRect)rect
{
    if(nil != skinImage)
        [self drawRectWithImage];
    else
        [self drawRectWithStoke];
    // Drawing code
  
    
    
   // CGPoint newP = CGPointMake(radius * cosf(endAngle) + CGRectGetMidX(self.bounds), radius * sinf(endAngle) + CGRectGetMidY(self.bounds));
    
   // [[UIImage imageNamed:@"circle_point"] drawAtPoint:newP];
    
    //CGContextDrawImage  使用Quartz内以左下角为(0,0)点的坐标系  所以需要使用CGContextTranslateCTM函数和
    //CGContextScaleCTM函数把以左下角为0点的坐标系转化成左上角形式的坐标系。
    
    /*
     //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
     CGContextTranslateCTM(gc, 0, height);
     CGContextScaleCTM(gc, 1, -1);
     CGContextDrawImage(gc, CGRectMake(0, 0, width, height), [srcImg CGImage]);
     */

}

-(void) dealloc
{
    [skinImage release];
    [skinImageView release];
    [super dealloc];
}

@end
