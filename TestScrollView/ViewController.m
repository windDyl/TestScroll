//
//  ViewController.m
//  TestScrollView
//
//  Created by dyLiu on 2017/5/5.
//  Copyright © 2017年 dyLiu. All rights reserved.
//

#import "ViewController.h"
#import "MHHeaderView.h"
#import "UIImage+Gradient.h"

static CGFloat const kWindowHeight = 156.0f;
static NSString * const kCellIdentify = @"cell";


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, MHHeaderViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
     
    

    UIColor *topleftColor = [UIImage dy_colorWithHexRGB:0xe23b3b A:1.0];
    UIColor *bottomrightColor = [UIImage dy_colorWithHexRGB:0xb62626 A:1.0];
    
    UIImage *bgImg = [UIImage dy_gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeLeftToRight imgSize:CGSizeMake(CGRectGetWidth(self.view.frame), kWindowHeight)];
    
    MHHeaderView *header = [[MHHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kWindowHeight) backGroundImage:bgImg cityTitle:@"北京" dateTitle:@"5月9-10 共1晚"];
    header.delegate = self;
    header.scrollView = self.tableView;
    [self.view addSubview:header];
    
}

#pragma mark - getter and setter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentify];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark- MHHeaderViewDelegate

- (void)headerView:(MHHeaderView *)headerView clickWithIndex:(NSInteger)index {
    if (index == 1) {
        NSLog(@"修改城市");
    } else if (index == 2) {
        NSLog(@"修改日期");
    }
}

#pragma mark- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"test %ld",(long)indexPath.row];
    return cell;
}

#pragma mark- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
