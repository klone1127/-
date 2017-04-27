//
//  NetworkManager+LiveList.h
//  非直播
//
//  Created by CF on 2017/4/27.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager (LiveList)


/**
 直播列表

 @param userUid
 @param interestId
 @param success
 @param failure 
 */
- (void)requestLiveListWithUid:(NSInteger)userUid interest:(NSInteger)interestId success:(SuccessBlock)success failure:(FailureBlock)failure;

@end
