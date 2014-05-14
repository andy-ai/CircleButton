//
//  MathsFun.h
//  CircleButton
//
//  Created by andy ai on 13-11-13.
//  Copyright (c) 2013年 andy ai. All rights reserved.
//

#import <Foundation/Foundation.h>
#define radiansToDegrees(x) (180.0 * x / M_PI)
#define degreesToRadians(x) (M_PI*(x)/180.0)

@interface MathsFun : NSObject
+(float)distanceFromPointX:(CGPoint)start distanceToPointY:(CGPoint)end;


@end
