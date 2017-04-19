//
//  CaptureVideosViewController.m
//  非直播
//
//  Created by CF on 2017/4/17.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "CaptureVideosViewController.h"
@import Photos;
@import AVFoundation;

@interface CaptureVideosViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>

@property (nonatomic, strong)AVCaptureSession       *captureSession;
@property (nonatomic, strong)AVCaptureDeviceDiscoverySession    *captureDeviceDiscoverySession;
@property (nonatomic, strong)AVCaptureVideoPreviewLayer     *videoPreviewLayer;
@property (nonatomic, strong)AVCaptureDeviceInput       *videoDeviceInput;
@property (nonatomic, strong)AVCaptureConnection        *videoConnection;
@end

@implementation CaptureVideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"直播";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupCaptureSession];
    [self searchDevice];
    [self configureSession];
    [self addViewPreviewLayer];
    [self changeCameraButton];
    [self.captureSession startRunning];
}



- (void)addViewPreviewLayer {
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    previewLayer.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 49);
    self.videoPreviewLayer = previewLayer;
    [self.view.layer addSublayer:self.videoPreviewLayer];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusAndExposeTap:)];
    [self.view addGestureRecognizer:tapGes];
}

- (void)setupCaptureSession {
    self.captureSession = [[AVCaptureSession alloc] init];
}

// 搜索可用设备
- (void)searchDevice {
    NSArray<AVCaptureDeviceType> *deviceTypes = @[AVCaptureDeviceTypeBuiltInWideAngleCamera, AVCaptureDeviceTypeBuiltInDuoCamera];
    self.captureDeviceDiscoverySession = [AVCaptureDeviceDiscoverySession
                                          discoverySessionWithDeviceTypes:deviceTypes
                                                                mediaType:AVMediaTypeVideo
                                                                 position:AVCaptureDevicePositionUnspecified];
}

- (void)configureSession {
//    [self.captureSession beginConfiguration];
    
    [self inputAndOutDevice];
    
}



- (void)inputAndOutDevice {
    AVCaptureDevice *videoDevice = [self chooseCamera];
    
    // 添加视频设备
    NSError *error;
    AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice
                                                                                   error:&error];
    if (!videoDeviceInput) {
        NSLog(@"创建 videoDeviceInput 失败:%@", error);
//        [self.captureSession commitConfiguration];
    }
    
    if ([self.captureSession canAddInput:videoDeviceInput]) {
        [self.captureSession addInput:videoDeviceInput];
        self.videoDeviceInput = videoDeviceInput;
    } else {
        NSLog(@"未能添加视频输入设备到 session");
    }
    
    // 添加音频设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput *audioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:&error];
    if (!audioDevice) {
        NSLog(@"未能创建音频输入设备:%@", error);
    }
    
    if ([self.captureSession canAddInput:audioDeviceInput]) {
        [self.captureSession addInput:audioDeviceInput];
    } else {
        NSLog(@"未能添加音频输入设备到session");
    }
    
    // 视频输出
    AVCaptureVideoDataOutput *videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    dispatch_queue_t videoQueue = dispatch_queue_create("captureVideoQueue", DISPATCH_QUEUE_SERIAL);
    
    [videoDataOutput setSampleBufferDelegate:self queue:videoQueue];
    
    if ([self.captureSession canAddOutput:videoDataOutput]) {
        [self.captureSession addOutput:videoDataOutput];
    } else {
        NSLog(@"添加输出设别失败");
    }
    
    // 音频输出
    AVCaptureAudioDataOutput *audioDataOutput = [[AVCaptureAudioDataOutput alloc] init];
    dispatch_queue_t audioQueue = dispatch_queue_create("cateureAudioQueue", DISPATCH_QUEUE_SERIAL);
    
    [audioDataOutput setSampleBufferDelegate:self queue:audioQueue];
    
    if ([self.captureSession canAddOutput:audioDataOutput]) {
        [self.captureSession addOutput:audioDataOutput];
    }
    
    
    self.videoConnection = [videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
    
}


- (AVCaptureDevice *)chooseCamera {
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInDuoCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
    if (!videoDevice) {
        videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
        
        if (!videoDevice) {
            videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
        }
    }
    
    return videoDevice;
}

- (void)changeCameraButton {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:but];
    but.frame = CGRectMake(20, 70, 70, 40);
    [but setTitle:@"切换相机" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(changeCamera:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeCamera:(UIButton *)sender {
    // 获取当前输入设备
    AVCaptureDevice *currentDevice = self.videoDeviceInput.device;
    // 获取摄像头方向
    AVCaptureDevicePosition currentPosition = currentDevice.position;
    
    [self preferredCameraPositionAndDeviceType:currentPosition changeDeviceTypeAndPosition:^(AVCaptureDevicePosition preferredPosition, AVCaptureDeviceType preferredDeviceType) {
        
    }];
    
    
}

- (void)preferredCameraPositionAndDeviceType:(AVCaptureDevicePosition)currentPosition changeDeviceTypeAndPosition:(void (^)(AVCaptureDevicePosition preferredPosition, AVCaptureDeviceType preferredDeviceType))chage {
    
    AVCaptureDevicePosition preferredPosition;
    AVCaptureDeviceType     preferredDeviceType;
    
    switch (currentPosition) {
        case AVCaptureDevicePositionUnspecified:
        case AVCaptureDevicePositionFront:
            preferredPosition = AVCaptureDevicePositionBack;
            preferredDeviceType = AVCaptureDeviceTypeBuiltInDuoCamera;
            break;
        case AVCaptureDevicePositionBack:
            preferredPosition = AVCaptureDevicePositionFront;
            preferredDeviceType = AVCaptureDeviceTypeBuiltInWideAngleCamera;
            break;
        default:
            break;
    }
    
    NSArray<AVCaptureDevice *> *devices = self.captureDeviceDiscoverySession.devices;
    AVCaptureDevice *newVideoDevice = nil;
    
    // 首选位置 和 设备类型
    for (AVCaptureDevice *device in devices) {
        if (device.position == preferredPosition && [device.deviceType isEqualToString:preferredDeviceType]) {
            newVideoDevice = device;
            break;
        }
    }
    
    // 仅查看首选位置
    if (!newVideoDevice) {
        for (AVCaptureDevice *device in devices) {
            if (device.position == preferredPosition) {
                newVideoDevice = device;
                break;
            }
        }
    }
    
    if (newVideoDevice) {
        AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:newVideoDevice error:nil];
        
        // 移除已存在的输入设备
        [self.captureSession removeInput:self.videoDeviceInput];
        
        if ([self.captureSession canAddInput:videoDeviceInput]) {
            // 聚焦
            [self.captureSession addInput:videoDeviceInput];
        } else {
            [self.captureSession addInput:self.videoDeviceInput];
        }
        
        self.videoDeviceInput = videoDeviceInput;
    }
    
    chage(preferredPosition, preferredDeviceType);
}

#pragma mark - delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    if (_videoConnection == connection) {
        NSLog(@"视频+++");
//        NSLog(@"port:%@", connection.inputPorts);
    } else {
        NSLog(@"音频---");
    }
    
}

#pragma mark - 聚焦手势
- (void)focusAndExposeTap:(UITapGestureRecognizer *)ges {
    
    CGPoint devicePoint = [self.videoPreviewLayer captureDevicePointOfInterestForPoint:[ges locationInView:ges.view]];
        [self focusWithMode:AVCaptureFocusModeAutoFocus
             exposeWithMode:AVCaptureExposureModeAutoExpose
              atDevicePoint:devicePoint
   monitorSubjectAreaChange:YES];
    
}

- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposeWithMode:(AVCaptureExposureMode)exposureMode atDevicePoint:(CGPoint)point monitorSubjectAreaChange:(BOOL)monitorSubjectAreaChange {
    
    AVCaptureDevice *device = self.videoDeviceInput.device;
    NSError *error = nil;
    if ([device lockForConfiguration:&error]) {
        
        if (device.isFocusPointOfInterestSupported && [device isFocusModeSupported:focusMode]) {
            device.focusPointOfInterest = point;
            device.focusMode = focusMode;
        }
        
        if (device.isExposurePointOfInterestSupported && [device isExposurePointOfInterestSupported]) {
            device.exposurePointOfInterest = point;
            device.exposureMode = exposureMode;
        }
        device.subjectAreaChangeMonitoringEnabled = monitorSubjectAreaChange;
        [device unlockForConfiguration];
        
    }
    
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
