//
//  LiveCollectionViewCell.m
//  非直播
//
//  Created by CF on 2017/4/27.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "LiveCollectionViewCell.h"
#import "LiveListModel.h"
#import "CreatorModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation LiveCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCellWithModel:(LiveListModel *)model {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.creator.portrait]];
    NSString *showName;
    if ((model.name == nil || [model.name isEqualToString:@""])) {
        showName = model.creator.nick;
    } else {
        showName = model.name;
    }
    self.titleLabel.text =  showName;
    self.funsNumberLabel.text = [NSString stringWithFormat:@"%ld 观看", model.online_users];
    [self.liveImageView sd_setImageWithURL:[NSURL URLWithString:model.creator.portrait]];
}

@end
