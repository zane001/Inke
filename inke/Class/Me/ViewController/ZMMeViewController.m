//
//  ZMMeViewController.m
//  inke
//
//  Created by zm on 2016/12/22.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMMeViewController.h"
#import "ZMMeInfoView.h"
#import "ZMSetting.h"
#import "ZMSettingViewController.h"

@interface ZMMeViewController ()

@property (nonatomic, copy)NSMutableArray *dataList;
@property (nonatomic, strong)ZMMeInfoView *infoView;

@end

@implementation ZMMeViewController

- (NSArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

// 懒加载
- (ZMMeInfoView *)infoView {
    if (!_infoView) {
        _infoView = [ZMMeInfoView loadInfoView];

    }
    return _infoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self loadData];
}

- (void)initUI {

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = 60;
    self.tableView.sectionFooterHeight = 5;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
//    self.tableView.tableFooterView = [[UIView alloc]init];  // 如果是plain样式，需要去除tableView下面多余的线

}

- (void)loadData {
    ZMSetting *set1 = [[ZMSetting alloc]init];
    set1.title = @"映客贡献榜";
    set1.subTitle = @"";
    set1.vcName = @"ZMContributionViewController";
    
    ZMSetting *set2 = [[ZMSetting alloc]init];
    set2.title = @"收益";
    set2.subTitle = @"0 映票";
    set2.vcName = @"ZMIncomeViewController";
    
    ZMSetting *set3 = [[ZMSetting alloc]init];
    set3.title = @"账户";
    set3.subTitle = @"0 钻石";
    set3.vcName = @"ZMAccountViewController";
    
    ZMSetting *set4 = [[ZMSetting alloc]init];
    set4.title = @"等级";
    set4.subTitle = @"3 级";
    set4.vcName = @"ZMRankViewController";
    
    ZMSetting *set5 = [[ZMSetting alloc]init];
    set5.title = @"实名认证";
    set5.subTitle = @"";
    set5.vcName = @"";
    
    ZMSetting *set6 = [[ZMSetting alloc]init];
    set6.title = @"设置";
    set6.subTitle = @"";
    set6.vcName = @"ZMSettingViewController";
    
    NSArray *arr1 = @[set1, set2, set3];
    NSArray *arr2 = @[set4, set5];
    NSArray *arr3 = @[set6];
    
    self.dataList = [@[arr1, arr2, arr3] mutableCopy];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *arr = self.dataList[section];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZMSetting *set = self.dataList[indexPath.section][indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text = set.title;
    cell.detailTextLabel.text = set.subTitle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {

        return self.infoView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return SCREEN_HEIGHT / 2;
    }
    return 5; // 如果一个view的height为0 就看不到了
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZMSetting *set = self.dataList[indexPath.section][indexPath.row];
    if ([set.title isEqual: @"设置"]) {
        ZMSettingViewController *setVC = [[ZMSettingViewController alloc]init];
        // 设置的是下一级页面上的BarButtonItem
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationController pushViewController:setVC animated:YES];

    }
}


@end
