//
//  ZMHotViewController.m
//  inke
//
//  Created by zm on 08/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMHotViewController.h"
#import "ZMLiveHandler.h"
#import "ZMLiveCell.h"
#import "ZMPlayerViewController.h"
#import "MJRefresh.h"

static NSString *identifier = @"ZMLiveCell";

@interface ZMHotViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *datalist;

@end

@implementation ZMHotViewController

- (NSMutableArray *)datalist {
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self.tableView.mj_header beginRefreshing];
}

- (void)initUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"ZMLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone]; // 取消分隔线
//    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    [self prepareRefresh];

}

// navigationBar、tabBar上滑隐藏、下滑显示
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    if (velocity.y > 0) {
//        self.navigationController.navigationBarHidden = YES;
//        self.tabBarController.tabBar.hidden = YES;
//    } else {
//        self.navigationController.navigationBarHidden = NO;
//        self.tabBarController.tabBar.hidden = NO;
//    }
//}

int lastPosition;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;  // 只能处理拖动，不能处理滑动
    // 获取拖拽的速度，向下拖动 y > 0，向上拖动 y < 0
//    CGFloat velocity = [pan velocityInView:scrollView].y;
    int currentPosition = scrollView.contentOffset.y;
    if (currentPosition - lastPosition > 200) {     // 数值小的话，可能下拉刷新会隐藏NavigationBar
        lastPosition = currentPosition;
        // 向上，隐藏导航栏，带动画显得不那么生硬
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.tabBarController.tabBar.hidden = YES;
    } else if (lastPosition - currentPosition > 200) {
        lastPosition = currentPosition;
        // 向下，显示导航栏
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)prepareRefresh {
    NSMutableArray *headerImages = [NSMutableArray array];
    for (int i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"img%d",i]];
        [headerImages addObject:image];
    }

    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //下拉刷新要做的操作
        [self loadData];
    }];
    gifHeader.stateLabel.hidden = YES;
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [gifHeader setImages:@[headerImages[0]] forState:MJRefreshStateIdle];
    [gifHeader setImages:headerImages forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = gifHeader;
    
}

- (void)loadData {
    [ZMLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        [self.tableView.mj_header endRefreshing];
        [self.datalist removeAllObjects];   // 先清空原来数据
        // 写成 addObject 报错
        [self.datalist addObjectsFromArray:obj];
        [self.tableView reloadData];
    } failure:^(id obj) {
        NSLog(@"%@", obj);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datalist.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70 + SCREEN_WIDTH;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.live = self.datalist[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZMLive *live = self.datalist[indexPath.row];
    
    ZMPlayerViewController *playerVC = [[ZMPlayerViewController alloc]init];
    playerVC.live = live;
    
    [self.navigationController pushViewController:playerVC animated:YES];
//    [self presentViewController:player animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
