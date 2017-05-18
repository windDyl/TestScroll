//
//  MHHeaderView.m
//  TestScrollView
//
//  Created by dyLiu on 2017/5/5.
//  Copyright © 2017年 dyLiu. All rights reserved.
//

#import "MHHeaderView.h"
#import "UIImage+Gradient.h"

@interface MHHeaderView ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong)UIButton *cityButton;
@property (nonatomic, strong)UIButton *dateButton;

@end

@implementation MHHeaderView

- (instancetype)initWithFrame:(CGRect)frame backGroundImage:(UIImage *)bgImage cityTitle:(NSString *)cityTitle dateTitle:(NSString *)dateTitle {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _cityTitle = cityTitle;
        _dateTitle = dateTitle;
        //背景
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = bgImage;
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        //城市按钮
        _cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
         _cityButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _cityButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _cityButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        _cityButton.tag = 1;
        [_cityButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cityButton setTitle:cityTitle forState:UIControlStateNormal];
        
        //日期按钮
        _dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
         _dateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _dateButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _dateButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        _dateButton.tag = 2;
        [_dateButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_dateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_dateButton setTitle:dateTitle forState:UIControlStateNormal];
        
        [self addSubview:_backImageView];
        [self addSubview:_cityButton];
        [self addSubview:_dateButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _backImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _cityButton.frame = CGRectMake((self.frame.size.width - 345)/2.0, 64, 345, 36);
    _dateButton.frame = CGRectMake((self.frame.size.width - 345)/2.0, 109, 345, 36);
}

- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:@"cont"];
    self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height-20, 0, 0, 0);
    self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGPoint newOffset = [change[@"new"] CGPointValue];
    NSLog(@"====%f====", newOffset.y);
    [self updateSubViewsWithScrollOffset:newOffset];
}

- (void)updateSubViewsWithScrollOffset:(CGPoint)newOffset {
    CGFloat destinaOffset = -64;
    CGFloat startChangeOffset = -self.scrollView.contentInset.top;
    newOffset = CGPointMake(newOffset.x, newOffset.y<startChangeOffset?startChangeOffset:(newOffset.y>destinaOffset?destinaOffset:newOffset.y));
    
    CGFloat subviewOffset = self.frame.size.height - 40;//子视图偏移量 40
    CGFloat newY = -newOffset.y - self.scrollView.contentInset.top;
    CGFloat d = destinaOffset - startChangeOffset;
    CGFloat alpha = 1 - (newOffset.y - startChangeOffset)/d;
    
    self.dateButton.alpha = alpha;
    self.frame = CGRectMake(0, newY, self.frame.size.width, self.frame.size.height);

    //CGFloat offset = (subviewOffset-0.45*self.frame.size.height)*(1-alpha);
    CGFloat offset = 50*(1-alpha);
    NSLog(@"===%f===%f=====%f=====%f", alpha, newY, offset, offset-40);
    self.cityButton.frame = CGRectMake((self.frame.size.width - 345)/2.0, 64+offset, 345, 36);
    self.dateButton.frame = CGRectMake((self.frame.size.width - 345)/2.0, 109+offset, 345, 36);

}

- (void)buttonClick:(UIButton *)btn {
    NSLog(@"====== %zd ======", btn.tag);
    if (btn.tag == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.scrollView setContentOffset:CGPointMake(0, -self.scrollView.contentInset.top) animated:NO];
            self.cityButton.hidden = NO;
            self.cityButton.alpha = 1.0;
        }];
    } else {
        if ([self.delegate respondsToSelector:@selector(headerView:clickWithIndex:)]) {
            [self.delegate headerView:self clickWithIndex:btn.tag];
        }
    }
}

@end
