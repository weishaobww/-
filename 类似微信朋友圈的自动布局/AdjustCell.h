//
//  AdjustCell.h
//  类似微信朋友圈的自动布局
//
//  Created by csj on 2017/10/25.
//  Copyright © 2017年 csj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AdjustLayout.h"

@class AdjustCell;

@interface AdjustView : UIView
@property (nonatomic, strong) UIView  *contentView;             // 容器
@property (nonatomic, strong) UILabel *textLabel;               // 文本
@property (nonatomic, strong) NSArray<UIView *> *picViews;      // 图片

@property (nonatomic, strong) AdjustLayout *layout;
@property (nonatomic, weak) AdjustCell *cell;


@end


@interface AdjustCell : UITableViewCell

@property (nonatomic,strong) AdjustView *adjustView;
- (void)setLayout:(AdjustLayout *)layout;

@end
