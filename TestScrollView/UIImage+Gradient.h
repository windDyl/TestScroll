//
//  UIImage+Gradient.h
//  TestScrollView
//
//  Created by dyLiu on 2017/5/5.
//  Copyright © 2017年 dyLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};
@interface UIImage (Gradient)
+ (UIImage *)dy_gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;
+ (UIColor *)dy_colorWithHexRGB:(NSInteger)rgb A:(CGFloat)alpha;
@end
