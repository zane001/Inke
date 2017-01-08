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
    [self loadData];
}

- (void)initUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"ZMLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone]; // 取消分隔线
//    self.tableView.backgroundColor = [UIColor lightGrayColor];
}

// navigationBar、tabBar上滑隐藏、下滑显示
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (velocity.y > 0) {
        self.navigationController.navigationBarHidden = YES;
        self.tabBarController.tabBar.hidden = YES;
    } else {
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
    }
}


- (void)loadData {
    [ZMLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
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
