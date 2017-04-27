//
//  LiveListResponseModel.m
//  非直播
//
//  Created by CF on 2017/4/27.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "LiveListResponseModel.h"

@implementation LiveListResponseModel

+ (LiveListResponseModel *)dicToModel:(id)data {
    NSError *error;
    LiveListResponseModel *responseModel = [[LiveListResponseModel alloc] initWithDictionary:data error:&error];
    if (error) {
        NSLog(@"responseModel error:%@", error);
    }
    return responseModel;
}

@end
