//
//  RotateImageView.h
//  CircleButton
//
//  Created by andy ai on 13-11-13.
//  Copyright (c) 2013年 andy ai. All rights reserved.
//
typedef void (^RotateBtMouseReleaseBlock)(CGFloat percentage,BOOL isMoving);


#import <UIKit/UIKit.h>
@class CircleButtonSkinView;

@interface RotateImageView : UIImageView
{
   // CGFloat _rotation;
    CGFloat fireSumvalue;
    BOOL _isEanble;
}
@property (nonatomic, assign) CGFloat rotation;//极坐标的角度值。即逆时针旋转的角度

@property(nonatomic,assign) CGPoint indicatorPoint;
@property(nonatomic,assign) int indicatorRadius;
@property (nonatomic,retain)  UIImageView *indicator;
@property(nonatomic,retain) CircleButtonSkinView* skinView;
@property(nonatomic,assign) CGFloat minRotation;
@property(nonatomic,assign) CGFloat maxRotation;
@property(nonatomic,retain) UIImage* enableIndicatorIg;
@property(nonatomic,retain) UIImage* disableIndicatorIg;
@property(nonatomic,copy) RotateBtMouseReleaseBlock mouseReleaseBlock;
-(void) initViewL;
-(void) adJustIndicator:(CGFloat) angle;
-(void) setSkinViewImage:(UIImage*) image;
-(void) setBackgroundImage:(UIImage*) image;

@end
