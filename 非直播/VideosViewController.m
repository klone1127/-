//
//  VideosViewController.m
//  非直播
//
//  Created by CF on 2017/4/17.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "VideosViewController.h"
#import "NetworkManager+LiveList.h"

@interface VideosViewController ()

@end

@implementation VideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"直播";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NetworkManager manager] requestLiveListWithUid:133825214
                                            interest:1
                                             success:^(NSURLSessionDataTask *task, id data) {
                                                 
                                             }
                                             failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                 
                                             }];
    
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
