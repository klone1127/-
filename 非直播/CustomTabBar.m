//
//  CustomTabBar.m
//  非直播
//
//  Created by jgrm on 2017/4/21.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "CustomTabBar.h"
#import "UIView+Frame.h"

#define kSelectedNum    1   // 调整此按钮的位置
#define kMiddleBtnY     -5
#define kMiddleViewY    10
#define kMiddleViewW    70

@implementation CustomTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (UIView *)middleView {
    if (!_middleView) {
        UIView *middleView = [[UIView alloc] init];
        [self addSubview:middleView];
        _middleView = middleView;
    }
    return _middleView;
}

- (void)setUpInit {
    self.middleView.frame = CGRectMake(0, 0, kMiddleViewW, kMiddleViewW);
    self.middleView.backgroundColor = [UIColor clearColor];
    
    [self initMiddleButton];
    
}

- (void)initMiddleButton {
    UIButton *middleBtn = [UIButton new];
    middleBtn.frame = self.middleView.frame;
    middleBtn.layer.cornerRadius = middleBtn.width * 0.5;
    middleBtn.layer.masksToBounds = YES;
    middleBtn.backgroundColor = [UIColor whiteColor];
    
    [middleBtn setBackgroundImage:[UIImage imageNamed:@"圆点"] forState:UIControlStateNormal];
    [self.middleView addSubview:middleBtn];
    [middleBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.middleButton = middleBtn;
}

- (void)btnClick:(UIButton *)sender
{
    NSLog(@"点击按钮");
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.items.count;
    
    NSInteger index = 0;
    
    CGFloat width = self.width / (count + 1);
    CGFloat height = self.height;
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == kSelectedNum) index++;
            CGFloat x = index * width;
            CGFloat y = kMiddleBtnY;
            subView.frame = CGRectMake(x, y, width, height);
            index++;
        }
    }
    
    self.middleView.centerX = self.width * 0.5;
    self.middleView.y = self.height - self.middleView.height - kMiddleViewY;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGPoint middlePoint = [self convertPoint:point toView:self.middleView];
    CGPoint center = CGPointMake(self.middleView.width * 0.5, self.middleView.height * 0.5);
    CGFloat distance = sqrt(pow(middlePoint.x - center.x, 2) + pow(middlePoint.y - center.y, 2));
    
    if (distance > self.middleButton.width * 0.5 && middlePoint.y < self.middleView.height - self.height) {
        return NO;
    }
    return YES;
}

@end
