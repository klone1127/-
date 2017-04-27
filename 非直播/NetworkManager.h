//
//  NetworkManager.h
//  非直播
//
//  Created by CF on 2017/4/27.
//  Copyright © 2017年 klone. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, Method) {
    POST,
    GET
};

typedef void(^SuccessBlock)(NSURLSessionDataTask * task, id data);

typedef void(^FailureBlock)(NSURLSessionDataTask * task, NSError * error);
typedef void(^DownloadProgress)(NSProgress * downloadProgress);

@interface NetworkManager : AFHTTPSessionManager

+ (instancetype)manager;

- (void)requestJSONWithMethod:(Method)method
                    URLString:(NSString *)url
                       params:(id)params
              downloadProgess:(DownloadProgress)progress
                      success:(SuccessBlock)success
                      failure:(FailureBlock)failure;

@end
