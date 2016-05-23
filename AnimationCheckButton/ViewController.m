//
//  ViewController.m
//  AnimationCheckButton
//
//  Created by zhanming on 16/5/23.
//  Copyright © 2016年 zhanming. All rights reserved.
//

#import "ViewController.h"
#import "checkButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    checkButton *button=[checkButton new];
    button.frame=CGRectMake(0, 0, 130, 50);
    button.center=self.view.center;
    [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
