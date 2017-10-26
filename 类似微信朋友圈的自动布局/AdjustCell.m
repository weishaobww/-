//
//  AdjustCell.m
//  类似微信朋友圈的自动布局
//
//  Created by csj on 2017/10/25.
//  Copyright © 2017年 csj. All rights reserved.
//

#import "AdjustCell.h"
#import "UIView+Category.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kWBCellPadding 5       // cell 内边距
#define kWBCellPaddingPic 5     // cell 多张图片中间留白

@implementation AdjustView
- (instancetype)initWithFrame:(CGRect)frame {

    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = 1;
    }
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor clearColor];
    self.exclusiveTouch = YES;
    
    
    _contentView = [UIView new];
    _contentView.width = kScreenWidth;
    _contentView.height = 1;
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    _textLabel = [UILabel new];
    _textLabel.left = 0;
    _textLabel.width = kScreenWidth;
    _textLabel.numberOfLines = 0;
    [_contentView addSubview:_textLabel];
    
    
    NSMutableArray * picViews = [NSMutableArray array];
    for (int i = 0 ; i < 9; i ++) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.size = CGSizeMake(100, 100);
        imageView.hidden = YES;
        
        [picViews addObject:imageView];
        [_contentView addSubview:imageView];
    }
    _picViews = picViews;
    
    return self;
    
}

- (void)setLayout:(AdjustLayout *)layout {

    _layout = layout;
    
    self.height = layout.height;
    _contentView.top = 0;
    _contentView.height = layout.height;;
    
    
    CGFloat top = 0;
    
    _textLabel.top = top;
    _textLabel.height = layout.textHeight;
    _textLabel.text = layout.adjustModel.content;
    
    
    //先把图片都隐藏了，防止复用的时候显示出错
    if (layout.picHeight == 0) {
        for (UIImageView *imageView in _picViews) {
            imageView.hidden = YES;
        }
    }
    
    
    top += layout.textHeight;
    
    NSString * urlString = layout.adjustModel.urlString;
    NSArray * picArr = [urlString componentsSeparatedByString:@","];
    if ([urlString length] <= 0) return;
    
    int picsCount = (int)picArr.count;
    for (int i = 0; i < 9 ; i ++) {
        UIView * imageView = _picViews[i];
        if (i >= picsCount) {
            imageView.hidden = YES;
        } else {
       
            CGFloat len1_3 = (kScreenWidth + kWBCellPaddingPic) / 3 - kWBCellPaddingPic;
            CGSize picSize = CGSizeMake(len1_3, len1_3);
            
            CGPoint origin = {0};
            switch (picsCount) {
                case 1: {
                    origin.x = kWBCellPadding;
                    origin.y = top;
                } break;
                case 4: {
                    origin.x = kWBCellPadding + (i % 2) * (picSize.width + kWBCellPaddingPic);
                    origin.y = top + (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                } break;
                default: {
                    origin.x = kWBCellPadding + (i % 3) * (picSize.width + kWBCellPaddingPic);
                    origin.y = top + (int)(i / 3) * (picSize.height + kWBCellPaddingPic);
                } break;
            }
            imageView.frame = (CGRect){.origin = origin, .size = picSize};
            imageView.hidden = NO;
            ((UIImageView *)imageView).image = [UIImage imageNamed:picArr[i]];
        }
    }
}

@end

@implementation AdjustCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _adjustView = [[AdjustView alloc]init];
        _adjustView.cell = self;
        [self.contentView addSubview:_adjustView];
    }
    
    return self;
}

- (void)prepareForReuse {
    // ignore
}

- (void)setLayout:(AdjustLayout *)layout {
    self.height = layout.height;
    self.contentView.height = layout.height;
    _adjustView.layout = layout;
    
}


@end

