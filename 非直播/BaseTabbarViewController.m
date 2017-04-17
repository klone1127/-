//
//  BaseTabbarViewController.m
//  非直播
//
//  Created by CF on 2017/4/17.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "CaptureVideosNavigationController.h"
#import "VideosNavigationController.h"

#import "VideosViewController.h"
#import "CaptureVideosViewController.h"

@interface BaseTabbarViewController ()

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewControllers = [self setupVC];
    
}

- (NSArray <UINavigationController *> *)setupVC {
    VideosViewController *videosVC = [[VideosViewController alloc] init];
    VideosNavigationController *videosNV = [[VideosNavigationController alloc] initWithRootViewController:videosVC];
    
    CaptureVideosViewController *captureVideosVC = [[CaptureVideosViewController alloc] init];
    CaptureVideosNavigationController *captureVideosNV = [[CaptureVideosNavigationController alloc] initWithRootViewController:captureVideosVC];
    return @[captureVideosNV, videosNV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
