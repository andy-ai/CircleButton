CircleButton
============

Circle button widget for IOS.  drag the slide , and displays the current progress

Use the following steps
1 add class CircleButtonSkinView,RotateImageView,MathsFun to the project.

2 sample code:

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
      
    };
