//
//  ZZHProgressView.h
//  ZZH_ProgressView
//
//  Created by zhangzhihua on 15/12/22.
//  Copyright © 2015年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ProgressStyle)
{
    ProgressUpStyle = 0,        //default, progress is on the down border of parent view
    ProgressDownStyle               //progress is on the up border of parent view
};


@interface ZZHProgressView : UIView

@property (nonatomic , assign)CGFloat progress; // 进度条的百分比

@property (nonatomic , strong)CAGradientLayer *gradLayer; // 颜色可变化的进度条

@property (nonatomic , strong)NSTimer *colorsTimer;        //控制进度条颜色变化的timer

@property (nonatomic , strong)UIView *backgroundView;


//Method
+ (ZZHProgressView*)shareInstance;

- (void)showinView:(UIView*)showView withStyle:(ProgressStyle)progressStyle;

-(void)setProgress:(CGFloat)progress;

-(void)starProgressAnimation;

-(void)endProgressAnimation;

@end
