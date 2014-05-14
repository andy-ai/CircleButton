//
//  CircleButtonSkinView.h
//  CircleButton
//
//CGContextAddArc  绘制的角度也是采用极坐标逆时针的角度
//  Created by andy ai on 13-11-14.
//  Copyright (c) 2013年 andy ai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleButtonSkinView : UIView
{
    UIImageView* skinImageView;
    UIImage*  skinImage;
}
@property (nonatomic,assign) CGFloat startAngle;
@property (nonatomic,assign) CGFloat endAngle;

-(void) initSkinImage:(UIImage*) imageParam;
@end
