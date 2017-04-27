//
//  LiveListModel.h
//  非直播
//
//  Created by CF on 2017/4/27.
//  Copyright © 2017年 klone. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "CreatorModel.h"
#import "ExtraModel.h"

@interface LiveListModel : JSONModel

@property (nonatomic, strong)CreatorModel       *creator;
@property (nonatomic, assign)NSInteger          id;
@property (nonatomic, copy)NSString<Optional>   *name;
@property (nonatomic, copy)NSString             *city;
@property (nonatomic, copy)NSString             *share_addr;
@property (nonatomic, copy)NSString             *stream_addr;
@property (nonatomic, assign)NSInteger          version;
@property (nonatomic, assign)NSInteger          online_users;
@property (nonatomic, strong)ExtraModel         *extra;

@end
