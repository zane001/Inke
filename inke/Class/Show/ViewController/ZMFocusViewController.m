//
//  ZMFocusViewController.m
//  inke
//
//  Created by zm on 08/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMFocusViewController.h"
#import "ZMLiveCell.h"
#import "ZMPlayerViewController.h"


static NSString *identifier = @"focus";
@interface ZMFocusViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *datalist;

@end

@implementation ZMFocusViewController

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
    
}


- (void)loadData {

    ZMLive *live = [[ZMLive alloc]init];
    ZMCreator *creator = [[ZMCreator alloc]init];
    live.creator = creator;

    live.city = @"北京";
    live.onlineUsers = 100;
    live.streamAddr = Live_ZM;
    creator.nick = @"猛哥";
    creator.portrait = @"focusMe";

    [self.datalist addObject:live];
    [self.tableView reloadData];

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

}


@end
