//
//  checkButton.m
//  AnimationCheckButton
//
//  Created by zhanming on 16/5/23.
//  Copyright © 2016年 zhanming. All rights reserved.
//

#import "checkButton.h"

static CGSize ZMButtonSize() {
    return CGSizeMake(100, 100);
}

@interface checkButton()

@property(nonatomic,assign,getter=isAnimationimg)BOOL animationimg;

@end

@implementation checkButton


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}


-(void)setUp{
    
    
    
    self.animationimg=NO;
    
    self.backgroundColor=[UIColor colorWithRed:0.98f green:0.81f blue:0.84f alpha:1.00f];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tapGes];
    
    
}

-(void)tapped:(UITapGestureRecognizer*)tap
{
    
    if(self.isAnimationimg) return;
    
    
    /**
       我们知道，使用 CAAnimation 如果不做额外的操作，动画会在结束之后返回到初始状态。或许你会这么设置：
      
       radiusAnimation.fillMode = kCAFillModeForwards;
       radiusAnimation.removedOnCompletion = NO;`
     
       但这不是正确的方式。正确的做法可以参考 WWDC 2011 中的 session 421 - Core Animation Essentials。
       Session 中推荐的做法是先显式地改变  Model Layer 的对应属性，再应用动画。这样一来，我们甚至省去了 toValue。
       因为 cornerRadius 也是  Animatable 的，所以可以作为 KeyPath 进行动画。首先显式地设定属性的终止状态，为进度条高度的 1/2 :ZMButtonSize().height/2. 设置好起始状态。
     */
    
    
    
    self.layer.cornerRadius=ZMButtonSize().height/2;
    CABasicAnimation *cornerRadiusAnimation=[CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadiusAnimation.delegate=self;
    
    cornerRadiusAnimation.duration=0.2;
    cornerRadiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    cornerRadiusAnimation.fromValue=@(self.frame.size.height/2);
    
    [self.layer addAnimation:cornerRadiusAnimation forKey:@"cornerRadiusAnimation"];
    
    
}

-(void)animationDidStart:(CAAnimation *)anim
{
    
    if([[self.layer animationForKey:@"cornerRadiusAnimation"] isEqual:anim])
    {
        
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.bounds = CGRectMake(0, 0, ZMButtonSize().height, ZMButtonSize().height);
            self.backgroundColor=[UIColor colorWithRed:1.00f green:0.80f blue:0.56f alpha:1.00f];
        } completion:^(BOOL finished) {
            [self.layer removeAllAnimations];
            
            [self checkAnimation];
            
        }];

    }
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if([[self.layer animationForKey:@"checkAnimation"] isEqual:anim])
    {
        self.animationimg=NO;
    }
}

-(void)checkAnimation
{
    
    CAShapeLayer *shape=[CAShapeLayer layer];
    
    
    UIBezierPath *bezierPath=[UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(self.frame.size.width/4, self.frame.size.height/2)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/4*3)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width/4*3, self.frame.size.height/3)];
    
    
    
    //UIBezierPath只是告诉路径给CAShapeLayer，具体这个shpe什么样子由CAShapeLayer来决定
    //所以一些属于lineWidth，fillColor是在shpe上设置的，在UIBezierPath上设置无效
    
    shape.lineWidth=17;
    shape.fillColor=[UIColor clearColor].CGColor;
    shape.strokeColor=[UIColor colorWithRed:0.76f green:0.89f blue:0.89f alpha:1.00f].CGColor;
    shape.lineCap = kCALineCapRound;
    shape.lineJoin = kCALineJoinRound;
    
    /**
     lineCap
     
     kCALineCapButt: 默认格式，不附加任何形状;
     kCALineCapRound: 在线段头尾添加半径为线段 lineWidth 一半的半圆；
     kCALineCapSquare: 在线段头尾添加半径为线段 lineWidth 一半的矩形”
     
    */
    
    
    shape.path=bezierPath.CGPath;
    [self.layer addSublayer:shape];
    
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = 0.5f;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    checkAnimation.delegate = self;
    [shape addAnimation:checkAnimation forKey:@"checkAnimation"];
    

    
    
}


-(void)layoutSubviews
{
    self.layer.cornerRadius=self.frame.size.height/2;
}


@end
