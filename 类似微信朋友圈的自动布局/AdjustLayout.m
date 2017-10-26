//
//  AdjustLayout.m
//  类似微信朋友圈的自动布局
//
//  Created by csj on 2017/10/25.
//  Copyright © 2017年 csj. All rights reserved.
//

#import "AdjustLayout.h"


@implementation AdjustLayout

- (instancetype)initWithAdjustModel:(AdjustModel *)adjustModel {

    if (!adjustModel) return nil;
    self = [super init];
    
    _adjustModel = adjustModel;
    
    [self layout];
    
    return self;
}


//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        [self layout];
//    }
//    return self;
//}

- (void)layout {
    [self _layout];
}

- (void)_layout {

    _textHeight = 0;
    _picHeight = 0;
    
    //布局文本
    [self _layoutContent];
    
    //布局图片
    [self _layoutPics];
    
    // 计算高度
    _height = 0;
    _height += _textHeight;
    _height += _picHeight;
    
    //底部
    _height += 30;
}

//布局图片
- (void)_layoutPics {

    _picHeight = 0;
    if ([_adjustModel.urlString length] <= 0) return;
    
    NSArray * picArr = [_adjustModel.urlString componentsSeparatedByString:@","];
    CGFloat screenWidth = [[UIScreen mainScreen]bounds].size.width;
    CGFloat picPadding = 5;
    CGFloat len1_3 = (screenWidth + picPadding)/3 - picPadding;

    CGFloat picHeight = 0;
    switch (picArr.count) {
        case 1:case 2:case 3:{
            picHeight = len1_3;
        }break;
        case 4:case 5:case 6:{
            picHeight = len1_3 * 2 + picPadding;
        }break;
        default: { //7,8,9
            picHeight = len1_3 * 3 + picPadding * 2;
        }break;
    }
    
    _picHeight = picHeight;
}

//布局文本
- (void)_layoutContent {

    _textHeight = 0;
    if ([_adjustModel.content length] <= 0) return;
    
    CGFloat width = [[UIScreen mainScreen]bounds].size.width;
    CGFloat height = [_adjustModel.content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size.height;
    _textHeight = height;
    
}


@end
