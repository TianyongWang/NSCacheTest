//
//  ViewController.m
//  NSCacheTest
//
//  Created by 王天永 on 2017/7/28.
//  Copyright © 2017年 王天永. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
//#ifndef __OPTIMIZE__
//#define OPEN_MEMORY_WARNING_TEST YES //打开内存警告测试开关
//#endif

static NSInteger i;
@interface ViewController ()<NSCacheDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, strong) UITableView *tableview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    i = 1;
    self.cache = [[NSCache alloc]init];
    self.cache.countLimit = 10;
//    self.cache.totalCostLimit = 10;
    self.cache.delegate = self;
    
//    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
//    self.tableview.delegate = self;
//    self.tableview.dataSource = self;
//    [self.view addSubview:self.tableview];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1000;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseId"];
//    [cell addSubview:imageview];
//    [imageview setImage:[UIImage imageNamed:@"IMG_2068.JPG"]];
//    return cell;
//}

- (void)imageButtonClick:(UIButton *)btn {
//    UIImage *image = [UIImage imageNamed:@"IMG_2068.JPG"];
    for (int j = 0; j<i*10000; j++) {
        [self.cache setObject:@(i) forKey:[NSString stringWithFormat:@"%d",j]];
        NSLog(@"添加了- key:%d,%@",j,[self.cache objectForKey:[NSString stringWithFormat:@"%d",j]]);
        if (j == 8888) {
            [self didReceiveMemoryWarning];
        }
    }
    
    i++;
}


- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    
    NSLog(@"删除了willEvictObject-%@",obj);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.cache removeAllObjects];
    NSLog(@"内存警告");
}


//- (void)simulateMemoryWarning
//{
//    if (OPEN_MEMORY_WARNING_TEST == NO) {
//        return;
//    }
////    [[UIApplication sharedApplication] warni];
//}

@end
