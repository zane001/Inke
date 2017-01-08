//
//  ZMNearViewController.m
//  inke
//
//  Created by zm on 08/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMNearViewController.h"
#import "ZMLiveHandler.h"
#import "ZMNearLiveCell.h"
#import "ZMPlayerViewController.h"

static NSString *identifier = @"ZMNearLiveCell";
#define kMargin 5
#define kItemWidth 100

@interface ZMNearViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *dataList;

@end

@implementation ZMNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self loadData];

    
}

- (void)initUI {
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZMNearLiveCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZMNearLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.live = self.dataList[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger count = self.collectionView.width / kItemWidth;
    CGFloat extraWidth = (self.collectionView.width - kMargin * (count + 1)) / count;   // 计算每个item的宽度
    return CGSizeMake(extraWidth, extraWidth + 20);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ZMNearLiveCell *c = (ZMNearLiveCell *)cell; // 强制类型转换
    [c showAnimation];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    ZMLive *live = self.dataList[indexPath.row];
    ZMPlayerViewController *player = [[ZMPlayerViewController alloc]init];
    player.live = live;
    
    [self.navigationController pushViewController:player animated:YES];
}

- (void)loadData {
    
    [ZMLiveHandler executeGetNearLiveTaskWithSuccess:^(id obj) {
//        NSLog(@"%@", obj);
        self.dataList = obj;
        [self.collectionView reloadData]; // 刷新数据
    } failure:^(id obj) {
        NSLog(@"%@", obj);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
