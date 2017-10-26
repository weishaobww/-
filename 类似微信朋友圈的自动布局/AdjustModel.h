//
//  AdjustModel.h
//  类似微信朋友圈的自动布局
//
//  Created by csj on 2017/10/25.
//  Copyright © 2017年 csj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdjustModel : NSObject

@property (nonatomic,copy) NSString *content;    //内容
@property (nonatomic,copy) NSString *urlString;  //如果有多个图片，逗号相隔

@end
