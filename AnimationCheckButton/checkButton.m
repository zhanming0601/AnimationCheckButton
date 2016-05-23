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
    
    //NSLog(@"%@",[self.layer animationForKey:@"cornerRadiusAnimation"]);
    
    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.bounds = CGRectMake(0, 0, ZMButtonSize().height, ZMButtonSize().height);
        self.backgroundColor=[UIColor colorWithRed:1.00f green:0.80f blue:0.56f alpha:1.00f];
    } completion:^(BOOL finished) {
        [self.layer removeAllAnimations];
        
        [self checkAnimation];
      
    }];

}
-(void)checkAnimation
{
    
    CAShapeLayer *shape=[CAShapeLayer layer];
    
    
    UIBezierPath *bezierPath=[UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(self.frame.size.width/4, self.frame.size.height/2)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/4*3)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width/4*3, self.frame.size.height/3)];
    
    
    
    
    shape.path=bezierPath.CGPath;
    shape.lineWidth=17;
    shape.fillColor=[UIColor clearColor].CGColor;
    
    shape.strokeColor=[UIColor colorWithRed:0.76f green:0.89f blue:0.89f alpha:1.00f].CGColor;
    shape.lineCap = kCALineCapRound;
    shape.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:shape];
    
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = 0.5f;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    //checkAnimation.delegate = self;
    [shape addAnimation:checkAnimation forKey:@"checkAnimation"];
    

    
    
}


-(void)layoutSubviews
{
    self.layer.cornerRadius=self.frame.size.height/2;
}


@end
