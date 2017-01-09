//
//  ZMSettingViewController.m
//  inke
//
//  Created by zm on 2016/12/28.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMSettingViewController.h"
#import "ZMClearCacheCell.h"
#import "ZMSetting.h"

@interface ZMSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *dataList;

@end

static NSString *const ZMClearCacheCellID = @"ClearCache";
@implementation ZMSettingViewController


- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}

- (void)initUI {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    self.tableView.tableHeaderView = headView; // 整个tableView的头部view
//    self.tableView.sectionHeaderHeight = 5; // 每个section的头部高度
//    self.tableView.sectionFooterHeight = 5; // 每个section的底部高度
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(SCREEN_WIDTH / 4, 20, SCREEN_WIDTH / 2, 20);
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setTitleColor:RGB(0, 216, 201) forState:UIControlStateNormal];
    
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 45, SCREEN_WIDTH / 3, 10)];
    versionLabel.text = @"Version 3.8.3";
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.textColor = [UIColor lightGrayColor];
    versionLabel.font = [UIFont systemFontOfSize:10];
    [footView addSubview:exitBtn];
    [footView addSubview:versionLabel];
    self.tableView.tableFooterView = footView;
    [self.view addSubview:self.tableView];
    self.title = @"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 注册自定义的Cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ZMClearCacheCellID];
}

- (void)loadData {
    ZMSetting *set1 = [[ZMSetting alloc]init];
    set1.title = @"账号与安全";
    set1.subTitle = @"";
    set1.vcName = @"";
    
    ZMSetting *set2 = [[ZMSetting alloc]init];
    set2.title = @"黑名单";
    set2.subTitle = @"";
    set2.vcName = @"";
    
    ZMSetting *set3 = [[ZMSetting alloc]init];
    set3.title = @"开播提醒";
    set3.subTitle = @"";
    set3.vcName = @"";
    
    ZMSetting *set4 = [[ZMSetting alloc]init];
    set4.title = @"未关注人私信";
    set4.subTitle = @"";
    set4.vcName = @"";
    
    ZMSetting *set5 = [[ZMSetting alloc]init];
    set5.title = @"清理缓存";
    set5.subTitle = @"";
    set5.vcName = @"";
    
    ZMSetting *set6 = [[ZMSetting alloc]init];
    set6.title = @"帮助和反馈";
    set6.subTitle = @"";
    set6.vcName = @"";
    
    ZMSetting *set7 = [[ZMSetting alloc]init];
    set7.title = @"关于我们";
    set7.subTitle = @"";
    set7.vcName = @"";
    
    ZMSetting *set8 = [[ZMSetting alloc]init];
    set8.title = @"网络诊断";
    set8.subTitle = @"";
    set8.vcName = @"";
    
    NSArray *arr1 = @[set1];
    NSArray *arr2 = @[set2, set3, set4];
    NSArray *arr3 = @[set5];
    NSArray *arr4 = @[set6, set7, set8];
    
    self.dataList = [@[arr1, arr2, arr3, arr4] mutableCopy];

}

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
    cell.textLabel.textColor = [UIColor lightGrayColor];
    if (indexPath.section == 1 && indexPath.row == 2) {
        UISwitch *switchView = [[UISwitch alloc]init];
        [switchView setOn:YES];
        cell.accessoryView = switchView;
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        return [[ZMClearCacheCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ZMClearCacheCellID];

    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (indexPath.section == 2 && indexPath.row == 0) {
//
//        [self clearCache:@""];
//    }
//    
//}



@end
