//
//  MathsFun.m
//  CircleButton
//
//  Created by andy ai on 13-11-13.
//  Copyright (c) 2013年 andy ai. All rights reserved.
//

#import "MathsFun.h"

@implementation MathsFun

+(float)distanceFromPointX:(CGPoint)start distanceToPointY:(CGPoint)end{
    float distance;
    CGFloat xDist = (end.x - start.x);
    CGFloat yDist = (end.y - start.y);
    distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

@end
