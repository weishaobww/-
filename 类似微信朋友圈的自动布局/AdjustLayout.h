//
//  AdjustLayout.h
//  类似微信朋友圈的自动布局
//
//  Created by csj on 2017/10/25.
//  Copyright © 2017年 csj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AdjustModel.h"

@interface AdjustLayout : NSObject

- (instancetype)initWithAdjustModel:(AdjustModel *)adjustModel;

//计算布局
- (void)layout;

@property (nonatomic, strong) AdjustModel *adjustModel;


// 文本
@property (nonatomic, assign) CGFloat textHeight; //文本高度

// 图片
@property (nonatomic, assign) CGFloat picHeight; //图片高度，0为没图片

// 总高度
@property (nonatomic, assign) CGFloat height;

@end
