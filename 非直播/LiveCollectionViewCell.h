//
//  LiveCollectionViewCell.h
//  非直播
//
//  Created by CF on 2017/4/27.
//  Copyright © 2017年 klone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LiveListModel;

@interface LiveCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *funsNumberLabel;

@property (weak, nonatomic) IBOutlet UIImageView *liveImageView;

- (void)configCellWithModel:(LiveListModel *)model;
@end
