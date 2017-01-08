//
//  ZMMainViewController.m
//  inke
//
//  Created by zm on 05/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import "ZMMainViewController.h"
#import "ZMMacros.h"
#import "ZMMainTopView.h"

@interface ZMMainViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;   // 注意设置分页、代理

@property (nonatomic, strong) NSArray *titleNames;
@property (nonatomic, strong) ZMMainTopView *topView;

@end


@implementation ZMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (ZMMainTopView *)topView {
    if (!_topView) {
        _topView = [[ZMMainTopView alloc]initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.titleNames tapView:^(NSInteger tag) {
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.contentScrollView.contentOffset.y);
            [self.contentScrollView setContentOffset:point animated:YES];
        }];

    }
    return _topView;
}

- (NSArray *)titleNames {
    if (!_titleNames) {
        _titleNames = @[@"关注", @"热门", @"附近"];
    }
    return _titleNames;
}

- (void)initUI {
    
    // 设置左右按钮
    [self setupNav];
    
    // 设置子视图控制器
    [self setupChildViewControllers];
}

- (void)setupNav {
    self.navigationItem.titleView = self.topView;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
}


- (void)setupChildViewControllers {
    NSArray *vcNames = @[@"ZMFocusViewController", @"ZMHotViewController", @"ZMNearViewController"];
    for (NSInteger i = 0; i < vcNames.count; i++) {
        NSString *vcName = vcNames[i];
        UIViewController *vc = [[NSClassFromString(vcName)alloc]init];
        vc.title = self.titleNames[i];
        [self addChildViewController:vc];
    }
    
    // 设置scrollView的contentSize
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.titleNames.count, 0);
    
    // 默认展示第二个页面
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

// 减速结束时调用加载子控制器view的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

// 动画结束调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger idx = offset / width;
    
    [self.topView scrolling:idx];
    UIViewController *vc = self.childViewControllers[idx];
    
    if ([vc isViewLoaded]) {
        return;
    }
    vc.view.frame = CGRectMake(offset, 0, width, height);
    
    // 将子视图的view加载到MainVC的scrollView上
    [scrollView addSubview:vc.view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
