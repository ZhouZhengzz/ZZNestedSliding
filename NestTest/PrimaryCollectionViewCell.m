//
//  PrimaryCollectionViewCell.m
//  NestTest
//
//  Created by zhouzheng on 17/1/11.
//  Copyright © 2017年 zhouzheng. All rights reserved.
//

#import "PrimaryCollectionViewCell.h"
#import "SecondLevelTableViewCell.h"
#import "Model.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
static NSString *SecondLevelTableViewCellID = @"SecondLevelTableViewCellID";

@interface PrimaryCollectionViewCell() <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    Model *_model;
}
@end

@implementation PrimaryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:_tableView];
        
        [_tableView registerClass:[SecondLevelTableViewCell class] forCellReuseIdentifier:SecondLevelTableViewCellID];
        
        _model = [Model defaultModel];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SecondLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SecondLevelTableViewCellID];
    if (!cell) {
        cell = [[SecondLevelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SecondLevelTableViewCellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd类,第%zd行",self.indexPath,indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"*** secondlevel *** %.2f",offsetY);

    CGFloat yy = _model.keyOffsetY;
    
//顶部需要拉伸效果，topView加到tableView.subView
    
    if (offsetY > 0) {
        yy = yy + offsetY;
        if (yy < -64) {
            scrollView.contentOffset = CGPointMake(0, 0);
        }else {
            yy = -64;
        }
    }
    
    if (offsetY < 0) {
        yy = yy + offsetY*0.65;
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    
//顶部没有拉伸效果，topView直接加到tableView.tableHeaderView
//
//    //136 = 200 - 64
//    if(yy < 136) {
//        yy = yy + scrollView.contentOffset.y;
//        scrollView.contentOffset = CGPointMake(0, 0);
//    
//    }
//    else if(scrollView.contentOffset.y < 0) {
//        
//        if(yy > -64) {
//            yy = yy + scrollView.contentOffset.y;
//        }
//        scrollView.contentOffset = CGPointMake(0, 0);
//    }
//    
//    if(yy < -64) {
//        yy = -64;
//    }
//        
//    if(yy > 136) {
//        yy = 136;
//    }

    _model.keyOffsetY = yy;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (_model.keyOffsetY < -264) {
        if (self.didEndDraggingBlock) {
            _didEndDraggingBlock(YES);
        }
    }
}


- (void)setScrolltotop:(BOOL)scrolltotop {
    _scrolltotop = scrolltotop;
    if (scrolltotop) {
        [_tableView scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, 1) animated:NO];
    }
    [_tableView reloadData];
}

@end
