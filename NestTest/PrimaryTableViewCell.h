//
//  PrimaryTableViewCell.h
//  NestTest
//
//  Created by zhouzheng on 17/1/11.
//  Copyright © 2017年 zhouzheng. All rights reserved.
//最外层tableView的cell

#import <UIKit/UIKit.h>

typedef void(^DidEndDraggingBlock)(BOOL status);

@interface PrimaryTableViewCell : UITableViewCell

@property (nonatomic, copy) DidEndDraggingBlock didEndDraggingBlock;

@end
