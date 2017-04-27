//
//  LiveListResponseModel.h
//  非直播
//
//  Created by CF on 2017/4/27.
//  Copyright © 2017年 klone. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class LiveListModel;

@interface LiveListResponseModel : JSONModel

@property (nonatomic, assign)NSInteger                          dm_error;
@property (nonatomic, copy)NSString                             *error_msg;
@property (nonatomic, strong)NSArray <LiveListModel *>          *lives;
@property (nonatomic, assign)NSInteger                          expire_time;

+ (LiveListResponseModel *)dicToModel:(id)data;

@end
