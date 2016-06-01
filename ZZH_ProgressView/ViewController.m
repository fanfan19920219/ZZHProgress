//
//  ViewController.m
//  ZZH_ProgressView
//
//  Created by zhangzhihua on 15/12/22.
//  Copyright © 2015年 zhangzhihua. All rights reserved.
//

#import "ViewController.h"
#import "ZZHProgressView.h"

@interface ViewController ()
@property (nonatomic ,assign)CGFloat progress;
@property (nonatomic , strong)NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[ZZHProgressView shareInstance]showinView:self.navigationController.navigationBar withStyle:ProgressDownStyle];
    [[ZZHProgressView shareInstance]starProgressAnimation];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 100, 100);
    button.center = self.view.center;
    [button setTitle:@"End" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.titleLabel.text = @"End";
    button.titleLabel.textColor = [UIColor blueColor];
    [button addTarget:self action:@selector(reStar) forControlEvents:UIControlEventTouchUpInside];                              
    [self.view addSubview:button];
}
-(void)reStar{

    [[ZZHProgressView shareInstance]endProgressAnimation];
}
-(void)addprogress{
    _progress+=0.01;
    [[ZZHProgressView shareInstance]setProgress:_progress];
    (_progress >=1)? [_timer invalidate]:nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
