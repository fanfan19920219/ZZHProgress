//
//  ZZHProgressView.m
//  ZZH_ProgressView
//
//  Created by zhangzhihua on 15/12/22.
//  Copyright © 2015年 zhangzhihua. All rights reserved.
//

#import "ZZHProgressView.h"
@interface ZZHProgressView()
{
    CGFloat fromCenter_x;
    CGFloat toCenter_x;
    
    CGFloat fromWidth;
    CGFloat toWidth;
    CGFloat animationDuration;
}
@end

@implementation ZZHProgressView

+(ZZHProgressView*)shareInstance{
    static ZZHProgressView *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instance == nil){
            instance = [[ZZHProgressView alloc]init];
        }
    });return instance;
}

-(void)showinView:(UIView*)showView withStyle:(ProgressStyle)progressStyle{
    self.backgroundView = showView;
    self.frame = CGRectMake(0, showView.frame.size.height - 2, showView.frame.size.width, 2);
    [self create_cagradLayer];
    [self setProgress:0];
    [showView addSubview:self];
}

-(void)create_cagradLayer{
    if (self.gradLayer == nil) {
        self.gradLayer = [CAGradientLayer layer];
        self.gradLayer.frame = self.bounds;
    }
    self.gradLayer.startPoint = CGPointMake(0, 0.5);
    self.gradLayer.endPoint = CGPointMake(1.0, 0.5);
    NSMutableArray *colors = [NSMutableArray array];
    for (NSInteger deg = 0; deg <= 360; deg += 5) {
        
        UIColor *color;
        color = [UIColor colorWithHue:1.0 * deg / 360.0
                           saturation:1.0
                           brightness:1.0
                                alpha:1.0];
        [colors addObject:(id)[color CGColor]];
    }
    self.gradLayer.colors = colors;
    [self.layer addSublayer:self.gradLayer];
    self.colorsTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(changeCalayerColors) userInfo:nil repeats:YES];
    //开启分线程
    [[NSRunLoop currentRunLoop]addTimer:self.colorsTimer forMode:NSDefaultRunLoopMode];
}

-(void)changeCalayerColors{
    NSMutableArray *colors = [[NSMutableArray alloc]initWithArray:self.gradLayer.colors];
    UIColor *color = [colors lastObject];
    [colors removeLastObject];
    if(color){
        [colors insertObject:color atIndex:0];
    }
    self.gradLayer.colors = colors;
}

-(void)setProgress:(CGFloat)progress{
//    self.progress = progress;
    CGFloat progresslength = self.backgroundView.frame.size.width * progress;
    CGRect rect = self.gradLayer.frame;
    rect.size.width = progresslength;
    self.gradLayer.frame = rect;
}
-(void)starProgressAnimation{
    //if(!self.hidden){self.hidden = !self.hidden;}
    fromCenter_x = 0;
    toCenter_x = self.backgroundView.center.x*0.8;
    fromWidth = 0;
    toWidth =self.backgroundView.frame.size.width*0.8;
    animationDuration = 0.8;
    [self progressAnimation];
}
-(void)endProgressAnimation{
    fromCenter_x = 0.8*self.backgroundView.center.x;
    toCenter_x = self.backgroundView.center.x;
    fromWidth = self.backgroundView.frame.size.width*0.8;
    toWidth =self.backgroundView.frame.size.width;
    animationDuration = 0.3;
    [self progressAnimation];
}
-(void)progressAnimation{
    //创建动画组
    CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = self;
    
    //改变大小
    CABasicAnimation* basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"bounds";
    basicAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, fromWidth, 2)];
    basicAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, toWidth, 2)];
    
    //改变中心
    CABasicAnimation* basicAnimationCenter = [CABasicAnimation animation];
    basicAnimationCenter.keyPath = @"position.x";
    basicAnimationCenter.fromValue = [NSNumber numberWithFloat:fromCenter_x];
    basicAnimationCenter.toValue = [NSNumber numberWithFloat:toCenter_x];
    
    animationGroup.animations =@[basicAnimation,basicAnimationCenter];
    animationGroup.duration = animationDuration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    [self.gradLayer addAnimation:animationGroup forKey:@"basicAnimation"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if(toWidth ==self.backgroundView.frame.size.width){
        NSLog(@"动画结束");
        [self removeFromSuperview];
    }
}


@end
