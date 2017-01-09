//
//  ZMClearCacheCell.m
//  inke
//
//  Created by zm on 2017/1/9.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "ZMClearCacheCell.h"
#import "SDImageCache.h"

@implementation ZMClearCacheCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = @"清除缓存";
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.detailTextLabel.text = @"";
    }
    
    CGFloat folderSize = [self folderSizeAtPath:@""];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.detailTextLabel.text = [NSString stringWithFormat:@"%.2f M", folderSize];
        [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clearCache)]];
        
    });
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

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
-(void)clearCache {
    
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
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
        self.detailTextLabel.text = @"0 K";
    }];
}


@end
