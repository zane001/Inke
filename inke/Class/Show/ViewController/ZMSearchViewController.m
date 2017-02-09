//
//  ZMSearchViewController.m
//  inke
//
//  Created by zm on 2017/1/14.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "ZMSearchViewController.h"
#import "ZMBaseNavViewController.h"
#import "ZMGoodVoiceCell.h"
#import "ZMTodayRecommendCell.h"
#import "ZMLiveHandler.h"

@interface ZMSearchViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *liveNodes;
@property (nonatomic, strong)NSMutableArray *userNodes;

@end

static NSString *goodVoiceCell = @"ZMGoodVoiceCell";
static NSString *recommendCell = @"ZMRecommendCell";

@implementation ZMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}

- (NSMutableArray *)liveNodes {
    if (!_liveNodes) {
        _liveNodes = [NSMutableArray array];
    }
    return _liveNodes;
}


- (NSMutableArray *)userNodes {
    if (!_userNodes) {
        _userNodes = [NSMutableArray array];
    }
    return _userNodes;
}

- (void)initUI {
    // 初始化tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];

    // 注册自定义ZMGoodVoiceCell
    [self.tableView registerClass:[ZMGoodVoiceCell class] forCellReuseIdentifier:goodVoiceCell];
    [self.tableView registerClass:[ZMTodayRecommendCell class] forCellReuseIdentifier:recommendCell];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView *searchTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 70, 50)];
    searchBar.placeholder = @"请输入昵称/映客号";
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [searchTitleView addSubview:searchBar];
    
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setTitle:@"取消" forState:UIControlStateNormal];
    dismissBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 40, 50);
    [dismissBtn addTarget:self action:@selector(closeSearch) forControlEvents:UIControlEventTouchUpInside];
    [searchTitleView addSubview:dismissBtn];
    
    self.navigationItem.titleView = searchTitleView;
}

- (void)loadData {
    [ZMLiveHandler executeGetRecommendTaskWithSuccess:^(id obj) {

        [self.liveNodes removeAllObjects];   // 先清空原来数据
        // 写成 addObject 报错

        [self.liveNodes addObjectsFromArray:obj];
        [self.tableView reloadData];
    } failure:^(id obj) {
        NSLog(@"%@", obj);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section != 3) {
        // 如果带参数forIndexPath，不必判断cell是否为空，因为如果为空，那么系统会根据前面注册的cell类型自动创建一个新的cell
        ZMGoodVoiceCell *goodVoice = [tableView dequeueReusableCellWithIdentifier:goodVoiceCell forIndexPath:indexPath];

        switch (indexPath.section) {

            case 0:
                goodVoice.titleLabel.text = @"好声音";
                break;
            case 1:
                goodVoice.titleLabel.text = @"小清新";
                break;
            case 2:
                goodVoice.titleLabel.text = @"搞笑达人";
                break;
            default:
                break;
        }
        
        return goodVoice;
    } else {
        ZMTodayRecommendCell *recommend = [tableView dequeueReusableCellWithIdentifier:recommendCell forIndexPath:indexPath];

        return recommend;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 3) {
        return (SCREEN_WIDTH - 40) / 3 + 40;
    } else {
        return 100;
    }
}


- (void)closeSearch {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
