//
//  LiveShowViewController.m
//  非直播
//
//  Created by CF on 2017/4/28.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "LiveShowViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface LiveShowViewController ()
@property (nonatomic, strong)IJKFFMoviePlayerController *player;
@property (nonatomic, strong)UIButton                   *dismissButton;
@end

@implementation LiveShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showFromURL:self.liveURL];
    [self setupDismissButton];
}

- (void)showFromURL:(NSString *)url {
        self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url] withOptions:nil];
        self.player.view.frame = [UIScreen mainScreen].bounds;
    
        [self.player prepareToPlay];
        [self.view addSubview:self.player.view];
    
        [self.player play];
}

- (void)setupDismissButton {
    self.dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    CGFloat h = 40;
    CGFloat w = h;
    CGFloat x = [UIScreen mainScreen].bounds.size.width - 40;
    CGFloat y = [UIScreen mainScreen].bounds.size.height - 40;
    self.dismissButton.frame = CGRectMake(x, y, w, h);
    [self.view addSubview:self.dismissButton];
    [self.dismissButton setImage:[UIImage imageNamed:@"叉"] forState:UIControlStateNormal];
    
    [self.dismissButton addTarget:self action:@selector(dismissHandle) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismissHandle {
    __weak typeof(self)weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.player stop];
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
