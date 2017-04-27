//
//  NetworkManager.m
//  非直播
//
//  Created by CF on 2017/4/27.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (instancetype)manager {
    static NetworkManager *networkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[self alloc] init];
        [networkManager config];
    });
    return networkManager;
}

- (void)config {
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/json",
                                                         @"text/javascript",
                                                         @"text/html", @"text/plain", nil];
}

- (void)requestJSONWithMethod:(Method)method URLString:(NSString *)url params:(id)params downloadProgess:(DownloadProgress)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    switch (method) {
        case GET:
        {
            [self GET:url
           parameters:params
             progress:^(NSProgress * _Nonnull downloadProgress) {
                 progress(downloadProgress);
             }
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  success(task, responseObject);
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  failure(task, error);
              }];
        }
            break;
        case POST:
        {
            [self POST:url
            parameters:params
              progress:^(NSProgress * _Nonnull uploadProgress) {
                  progress(uploadProgress);
              }
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   success(task, responseObject);
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   failure(task, error);
               }];
        }
            break;
        default:
            break;
    }
}

@end
