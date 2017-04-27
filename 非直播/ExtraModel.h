//
//  ExtraModel.h
//  非直播
//
//  Created by CF on 2017/4/27.
//  Copyright © 2017年 klone. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class ExtraLabelModel;

@protocol ExtraLabelModel;

@interface ExtraModel : JSONModel

@property (nonatomic, copy)NSString <Optional>                          *cover;
@property (nonatomic, strong)NSArray <ExtraLabelModel,Optional>         *label;

@end
