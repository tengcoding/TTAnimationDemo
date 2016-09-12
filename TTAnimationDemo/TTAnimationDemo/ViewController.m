//
//  ViewController.m
//  TTAnimationDemo
//
//  Created by 梁腾 on 16/9/7.
//  Copyright © 2016年 TT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *starImage;
@property (weak, nonatomic) IBOutlet UIView *graduallyView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self beginAnimations];
    [self frameAnimation];
    [self blockAnimation];
}


// 首尾式动画 渐变动画  适用于  大小/位置/颜色/透明度发生改变的时候  举例和transform使用
- (void)beginAnimations{
    //动画开始
    [UIView beginAnimations:nil context:nil];
    //设置动画时长
    [UIView setAnimationDuration:3.0f];
    //动画内容
    //在起始位置上，Y方向-100;
    _starImage.transform = CGAffineTransformMakeTranslation(0, -100);
    //在当前位置上，Y方向-100;
    _starImage.transform = CGAffineTransformTranslate(_starImage.transform, 0, -100);
    //旋转，在起始位置上，逆时针旋转45°
    _starImage.transform = CGAffineTransformMakeRotation(-M_PI_4);
    //缩放，在当前大小的基础上，x/y方向都拉伸1.5倍
    _starImage.transform = CGAffineTransformScale(_starImage.transform, 1.5, 1.5);
    //结束动画
    [UIView commitAnimations];
    
}

//序列帧动画
- (void)frameAnimation{
    void (^keyFrameBlock)() = ^(){
        // 创建颜色数组
        NSArray *arrayColors = @[[UIColor orangeColor],
                                 [UIColor yellowColor],
                                 [UIColor greenColor],
                                 [UIColor blueColor],
                                 [UIColor purpleColor],
                                 [UIColor redColor]];
        NSUInteger colorCount = [arrayColors count];
        // 循环添加关键帧
        for (NSUInteger i = 0; i < colorCount; i++) {
            [UIView addKeyframeWithRelativeStartTime:i / (CGFloat)colorCount
                                    relativeDuration:1 / (CGFloat)colorCount
                                          animations:^{
                                              [_graduallyView setBackgroundColor:arrayColors[i]];
                                          }];
        }
    };
    [UIView animateKeyframesWithDuration:4.0
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic | UIViewAnimationOptionCurveLinear
                              animations:keyFrameBlock
                              completion:^(BOOL finished) {
                                  // 动画完成后执行
                                  // code...
                              }];
}
//块动画  示例为ios7 广泛应用的Spring Animation
- (void)blockAnimation{
    [UIView animateWithDuration:4.0 delay:4.0 usingSpringWithDamping:0.2 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect imageFrame = self.starImage.bounds;
        imageFrame.size.width = 150;
        imageFrame.size.height = 150;
        self.starImage.bounds = imageFrame;
    } completion:^(BOOL finished) {
        [self.starImage setAlpha:1];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
