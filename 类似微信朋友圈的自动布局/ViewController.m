//
//  ViewController.m
//  类似微信朋友圈的自动布局
//
//  Created by csj on 2017/10/25.
//  Copyright © 2017年 csj. All rights reserved.
//

#import "ViewController.h"
#import "AdjustModel.h"
#import "AdjustCell.h"
#import "AdjustLayout.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation ViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"自动布局";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray * titles = @[@"一张图片，，，，，，，，，，我是回复就打回房间爱回家",
                             @"两张图片，，，，，，，，，，好的发挥看看很费劲卡的合肥的恢复好的健康教案和附近的建安费回房间的卡号发",
                             @"没有图片的",
                             @"三张图片，，，，花费巨大环境法",
                             @"四张图片，，，，几号的发货价",
                             @"",
                             @"六张图片，，，，，剪发打火机",
                             @"七张图片，，，，，凤凰卡号反馈哈客服很快回家爱德华房间卡凤凰卡的话费卡好久恒大金服回家啊发哈肯德基发哈科技活动空间哈",
                             @"八张图片，，，，回家回复回复回复哈哈发货",
                             @"九张图片，，，，返回回复回复哈哈发货"];
        NSArray * urls = @[@"1.jpeg",
                           @"4.jpeg,5.jpeg",
                           @"",
                           @"4.jpeg,5.jpeg,6.jpeg",
                           @"1.jpeg,2.jpeg,3.jpeg,4.jpeg,",
                           @"1.jpeg,6.jpeg,7.jpeg,8.jpeg,9.jpeg",
                           @"1.jpeg,6.jpeg,7.jpeg,8.jpeg,9.jpeg,8.jpeg",
                           @"2.jpeg,3.jpeg,5.jpeg,6.jpeg,7.jpeg,8.jpeg,9.jpeg",
                           @"7.jpeg,6.jpeg,7.jpeg,8.jpeg,9.jpeg,1.jpeg,2.jpeg,3.jpeg",
                           @"1.jpeg,2.jpeg,3.jpeg,4.jpeg,5.jpeg,6.jpeg,7.jpeg,8.jpeg,9.jpeg",
                           ];
        
        
        for (int i = 0; i < titles.count; i ++) {
            
            AdjustModel * model = [self setContent:titles[i] urlString:urls[i]];
            AdjustLayout *layout = [[AdjustLayout alloc] initWithAdjustModel:model];
            [self.dataArray addObject:layout];
        }
        
        [self.dataArray addObjectsFromArray:self.dataArray];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    });
}


#pragma mark -- UITableViewDelegate --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cell";
    AdjustCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[AdjustCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//        cell.delegate = self;
    }
    [cell setLayout:self.dataArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%f",((AdjustLayout *)self.dataArray[indexPath.row]).height);
    return ((AdjustLayout *)self.dataArray[indexPath.row]).height;
}



- (AdjustModel *)setContent:(NSString *)content urlString:(NSString *)urlString {

    AdjustModel * model = [[AdjustModel alloc]init];
    model.content = content;
    model.urlString = urlString;
    return model;
}


@end
