//
//  CaptureVideosNavigationController.m
//  非直播
//
//  Created by CF on 2017/4/17.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "CaptureVideosNavigationController.h"
#import "CaptureVideosViewController.h"

@interface CaptureVideosNavigationController ()

@end

@implementation CaptureVideosNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CaptureVideosViewController *vc = [[CaptureVideosViewController alloc] init];
    [self setViewControllers:@[vc]];

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
