//
//  NetworkManager+LiveList.m
//  非直播
//
//  Created by CF on 2017/4/27.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "NetworkManager+LiveList.h"
#import "LiveListResponseModel.h"

#define kURLString    @"http://116.211.167.106/api/live/aggregation"

@implementation NetworkManager (LiveList)

- (void)requestLiveListWithUid:(NSInteger)userUid interest:(NSInteger)interestId success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSNumber *uid = @(userUid);
    NSNumber *interest = @(interestId);
    [self requestJSONWithMethod:GET
                      URLString:kURLString
                         params:NSDictionaryOfVariableBindings(uid, interest)
                downloadProgess:^(NSProgress *downloadProgress) {
                    NSLog(@"完成进度:%.2f%%", downloadProgress.fractionCompleted);
                }
                        success:^(NSURLSessionDataTask *task, id data) {

                            success(task, [LiveListResponseModel dicToModel:data]);
                        }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            failure(task, error);
                        }];
}




@end
