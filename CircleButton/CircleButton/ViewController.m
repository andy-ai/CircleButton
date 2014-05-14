//
//  ViewController.m
//  CircleButton
//
//  Created by andy ai on 14-5-13.
//  Copyright (c) 2014年 andy. All rights reserved.
//

#import "ViewController.h"
#import "RotateImageView.h"
#import "MathsFun.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect rc = CGRectMake(60, 50, 200, 200);
    rtImageView = [[RotateImageView alloc] initWithFrame:rc];
    [rtImageView setUserInteractionEnabled:YES];
    rtImageView.indicatorRadius =  200 ;
    rtImageView.minRotation = degreesToRadians(90);
    rtImageView.maxRotation = degreesToRadians(450);
    rtImageView.rotation =degreesToRadians(90);
    
    [rtImageView setBackgroundImage:[UIImage imageNamed:@"back"]];
    [rtImageView setSkinViewImage:[UIImage imageNamed:@"skin"]];
    [self.view addSubview:rtImageView];
    
    rc.origin.y +=  200;
    numberLabel = [[UILabel alloc] initWithFrame:rc];
    numberLabel.text = @"percent";
    numberLabel.textAlignment = NSTextAlignmentCenter;
    rtImageView.mouseReleaseBlock = ^(CGFloat percentage,BOOL isMoving)
    {
        NSString* str = [NSString stringWithFormat:@"%.2f",percentage];
        numberLabel.text = str;
    };
    [self.view addSubview:numberLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [rtImageView release];
    [numberLabel release];
    [super dealloc];
}
@end
