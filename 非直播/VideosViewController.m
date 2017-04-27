//
//  VideosViewController.m
//  非直播
//
//  Created by CF on 2017/4/17.
//  Copyright © 2017年 klone. All rights reserved.
//

#import "VideosViewController.h"
#import "NetworkManager+LiveList.h"
#import "LiveCollectionViewCell.h"
#import "LiveListResponseModel.h"
#import "LiveShowViewController.h"
#import "LiveListModel.h"

#define kLiveCollectionViewCellID       @"LiveCollectionViewCell"

@interface VideosViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView   *liveColliectionView;
@property (nonatomic, strong)NSMutableArray     *liveDataSource;

@end

@implementation VideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"直播";
    self.view.backgroundColor = [UIColor whiteColor];
    self.liveDataSource = [NSMutableArray arrayWithCapacity:0];
    [self getDataWithUid:133825214 interest:1];
    [self setupColliectionView];
}

- (void)setupColliectionView {
    
    self.liveColliectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self setupCollectionViewFlowLayout]];
    self.liveColliectionView.backgroundColor = [UIColor whiteColor];
    
    self.liveColliectionView.delegate  =self;
    self.liveColliectionView.dataSource = self;
    [self.view addSubview:self.liveColliectionView];
    
    [self.liveColliectionView registerNib:[UINib nibWithNibName:@"LiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kLiveCollectionViewCellID];
}

- (UICollectionViewFlowLayout *)setupCollectionViewFlowLayout {
    UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width + 50);
    collectionLayout.minimumLineSpacing = 0;
    collectionLayout.minimumInteritemSpacing = 0;
    collectionLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    return collectionLayout;
}

#pragma mark - Delegate & DataSourceDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.liveDataSource.count;    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LiveListModel *model = self.liveDataSource[indexPath.row];
    LiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLiveCollectionViewCellID forIndexPath:indexPath];
    if (!cell) {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"LiveCollectionViewCell" owner:nil options:nil];
        cell = [cellArray firstObject];
    }
    
    [cell configCellWithModel:model];
    NSLog(@"model:%@", model);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"index:%ld", indexPath.section);
    
    LiveListModel *model = self.liveDataSource[indexPath.row];
    
    LiveShowViewController *liveShowVC = [[LiveShowViewController alloc] init];
    liveShowVC.liveURL = model.stream_addr;
    [self presentViewController:liveShowVC animated:YES completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
    [UIView animateWithDuration:0.7 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    
}

- (void)getDataWithUid:(NSInteger)uid interest:(NSInteger)interest {
    __weak typeof(self)weakSelf = self;
    [[NetworkManager manager] requestLiveListWithUid:uid
                                            interest:interest
                                             success:^(NSURLSessionDataTask *task, id data) {
                                                 __strong typeof(weakSelf)strongSelf = weakSelf;
                                                 LiveListResponseModel *listModel = data;
                                                 [strongSelf.liveDataSource addObjectsFromArray:listModel.lives];
//                                                 NSLog(@"data:%@", data);
                                                 [strongSelf.liveColliectionView reloadData];
                                             }
                                             failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                 NSLog(@"error:%@", error);
                                             }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
