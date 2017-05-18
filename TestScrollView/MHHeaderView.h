//
//  MHHeaderView.h
//  TestScrollView
//
//  Created by dyLiu on 2017/5/5.
//  Copyright © 2017年 dyLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHHeaderView;
@protocol MHHeaderViewDelegate <NSObject>

- (void)headerView:(MHHeaderView *)headerView clickWithIndex:(NSInteger)index;

@end

@interface MHHeaderView : UIView
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak)id<MHHeaderViewDelegate>delegate;
@property (nonatomic, copy)NSString *cityTitle;
@property (nonatomic, copy)NSString *dateTitle;

- (instancetype)initWithFrame:(CGRect)frame backGroundImage:(UIImage *)bgImage cityTitle:(NSString *)cityTitle dateTitle:(NSString *)dateTitle;
@end
