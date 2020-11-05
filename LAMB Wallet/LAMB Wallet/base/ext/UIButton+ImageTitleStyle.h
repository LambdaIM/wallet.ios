//
//  UIButton+ImageTitleStyle.h
//
//  Created by 欧阳大哥 on 14-7-13.
//  QQ：156355113
//  Github:  https://github.com/youngsoft
//  Email:  obq0387_cn@sina.com
//
  
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleTop, //image在上，label在下
    ButtonEdgeInsetsStyleLeft, //image在左，label在右
    ButtonEdgeInsetsStyleBottom, //image在下，label在上
    ButtonEdgeInsetsStyleRight, //image在右，label在左
    ButtonEdgeInsetsStyleMind//image在中间, label 在中间
};

/** 针对同时设置了Image和Title的场景时UIButton中的图片和文字的关系 */
typedef NS_ENUM(NSInteger, ButtonImageTitleStyle ) {
    /// 图片在左，文字在右，整体居中。
    ButtonImageTitleStyleDefault = 0,
    /// 图片在左，文字在右，整体居中。
    ButtonImageTitleStyleLeft  = 0,
    /// 图片在右，文字在左，整体居中。
    ButtonImageTitleStyleRight     = 2,
    /// 图片在上，文字在下，整体居中。
    ButtonImageTitleStyleTop  = 3,
    /// 图片在下，文字在上，整体居中。
    ButtonImageTitleStyleBottom    = 4,
    /// 图片居中，文字在上距离按钮顶部。
    ButtonImageTitleStyleCenterTop = 5,
    /// 图片居中，文字在下距离按钮底部。
    ButtonImageTitleStyleCenterBottom = 6,
    /// 图片居中，文字在图片上面。
    ButtonImageTitleStyleCenterUp = 7,
    /// 图片居中，文字在图片下面。
    ButtonImageTitleStyleCenterDown = 8,
    /// 图片在右，文字在左，距离按钮两边边距
    ButtonImageTitleStyleRightLeft = 9,
    /// 图片在左，文字在右，距离按钮两边边距
    ButtonImageTitleStyleLeftRight = 10,
};
  
@interface UIButton (ImageTitleStyle)
  
/*
 注意: 如果按钮是约束布局，应该再约束设置之后再设置按钮内部布局
 
 调整按钮的文本和image的布局，前提是title和image同时存在才会调整。
 padding是调整布局时整个按钮和图文的间隔。
 */
-(void)setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding;
  

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end  
