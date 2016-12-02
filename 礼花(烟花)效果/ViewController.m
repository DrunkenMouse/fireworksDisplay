//
//  ViewController.m
//  礼花(烟花)效果
//
//  Created by 王奥东 on 16/12/1.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    //底部生成，向上移动
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = self.view.layer.bounds;
    //设置发射的位置
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    //以发射点为中心
    fireworksEmitter.emitterSize = CGSizeMake(viewBounds.size.width/2.0, 0.0);
    //发射模式
    fireworksEmitter.emitterMode  = kCAEmitterLayerOutline;
    //发射形状
    fireworksEmitter.emitterShape = kCAEmitterLayerLine;
    //渲染模式
    fireworksEmitter.renderMode   = kCAEmitterLayerAdditive;
    //用于初始化随机函数的种子
    fireworksEmitter.seed = (arc4random()%100)+1;
    
    // 迅速增加
    CAEmitterCell *rocket = [CAEmitterCell emitterCell];
    //粒子参数的速度乘数因子
    rocket.birthRate = 1.0;
    //周围发射角度
    rocket.emissionRange = 0.25 * M_PI;
    //速度
    rocket.velocity = 380;
    //速度范围
    rocket.velocityRange = 100;
    //y方向的加速度分量
    rocket.yAcceleration = 75;
    
    rocket.lifetime = 1.02;
    //粒子要展示的图片
    rocket.contents = (id)[[UIImage imageNamed:@"1"] CGImage];
    //缩放比例
    rocket.scale = 0.2;
    //粒子颜色
    rocket.color = [[UIColor redColor] CGColor];
    //一个粒子的绿颜色能改变的范围
    rocket.greenRange = 1.0;
    //一个粒子的红颜色能改变的范围
    rocket.redRange = 1.0;
    //一个粒子蓝颜色能改变的范围
    rocket.blueRange = 1.0;
    //粒子旋转角度范围
    rocket.spinRange = M_PI;
    
    //爆裂对象不能被看到，但会产生火花
    //我们在这里改变颜色，因为火花继承了它的价值
    CAEmitterCell * burst = [CAEmitterCell emitterCell];
    //粒子参数的速度乘数因子
    burst.birthRate = 1.0;
    //速度
    burst.velocity = 0;
    burst.scale = 2.5;
    //粒子红色在生命周期内的改变速度
    burst.redSpeed = -1.5;
    burst.blueSpeed = +1.5;
    //粒子绿色在生命周期内的改变速度
    burst.greenSpeed = 1.0;
    burst.lifetime = 0.35;
    
    //最后是火花飞舞
    CAEmitterCell *spark = [CAEmitterCell emitterCell];
    spark.birthRate = 400;
    spark.velocity = 125; //速度
    spark.emissionRange = 2 * M_PI;
    spark.yAcceleration = 75;
    spark.lifetime = 3; //生命周期范围
    //粒子内容
    spark.contents = (id)[[UIImage imageNamed:@"2"] CGImage];
    spark.scaleSpeed = -0.2;
    spark.greenSpeed = -0.1;
    spark.redSpeed = 0.4;
    spark.blueSpeed = -0.1;
    //粒子透明度在生命周期内的改变速度
    spark.alphaSpeed = -0.25;
    spark.spin = 2*M_PI;
    spark.spinRange = 2*M_PI;
    
    //一起投掷
    fireworksEmitter.emitterCells = [NSArray arrayWithObject:rocket];
    //投掷包含爆炸
    rocket.emitterCells = [NSArray arrayWithObject:burst];
    //爆炸包含火花
    burst.emitterCells = [NSArray arrayWithObject:spark];
   
   [self.view.layer addSublayer:fireworksEmitter];
    
}

@end
