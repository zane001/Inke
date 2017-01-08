//
//  ZMSettingViewController.m
//  inke
//
//  Created by zm on 2016/12/28.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZMSettingViewController.h"
#import "SDImageCache.h"
#import "ZMSetting.h"

@interface ZMSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *dataList;

@end

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
        UILabel *cacheSizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, cell.height)];
        cacheSizeLabel.textAlignment = NSTextAlignmentRight;
        CGFloat cacheSize = [self folderSizeAtPath:@""];
        cacheSizeLabel.text = [NSString stringWithFormat:@"%g M", cacheSize];
        cacheSizeLabel.textColor = [UIColor lightGrayColor];
        cell.accessoryView = cacheSizeLabel;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self clearCache:@""];
    
}

-(long long)fileSizeAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]) {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size;
    }
    return 0;
}

-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    cachePath = [cachePath stringByAppendingPathComponent:path];
    long long folderSize = 0;
    if ([fileManager fileExistsAtPath:cachePath])
    {
        NSArray *childerFiles = [fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles)
        {
            NSString *fileAbsolutePath = [cachePath stringByAppendingPathComponent:fileName];
            long long size = [self fileSizeAtPath:fileAbsolutePath];
            folderSize += size;
//            NSLog(@"fileAbsolutePath=%@", fileAbsolutePath);
            
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize];
//        NSLog(@"folderSize %f", folderSize/1024.0/1024.0);
        return folderSize/1024.0/1024.0;
    }
    return 0;
}

//同样也是利用NSFileManager API进行文件操作，SDWebImage框架自己实现了清理缓存操作，我们可以直接调用。
-(void)clearCache:(NSString *)path{
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    cachePath=[cachePath stringByAppendingPathComponent:path];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cachePath]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *fileAbsolutePath = [cachePath stringByAppendingPathComponent:fileName];
            NSLog(@"fileAbsolutePath=%@",fileAbsolutePath);
            [fileManager removeItemAtPath:fileAbsolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
    }];
}


@end
