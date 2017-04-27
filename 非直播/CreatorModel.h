//
//  CreatorModel.h
//  非直播
//
//  Created by CF on 2017/4/27.
//  Copyright © 2017年 klone. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CreatorModel : JSONModel

@property (nonatomic, assign)NSInteger      id;
@property (nonatomic, assign)NSInteger      level;
@property (nonatomic, assign)NSInteger      gender;
@property (nonatomic, copy)NSString         *nick;
@property (nonatomic, copy)NSString         *portrait;

@end
