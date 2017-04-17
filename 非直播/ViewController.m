//
//  ViewController.m
//  非直播
//
//  Created by CF on 2017/4/15.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "ViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
//    IJKFFMoviePlayerController *player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://pull6.a8.com/live/1492354691837132.flv"] withOptions:nil];
//    player.view.frame = [UIScreen mainScreen].bounds;
//    
//    [player prepareToPlay];
//    [self.view addSubview:player.view];
//    
//    [player play];
}

- (void)initCaptureVideo {
    AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
