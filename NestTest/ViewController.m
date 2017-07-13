//
//  ViewController.m
//  NestTest
//
//  Created by zhouzheng on 17/1/11.
//  Copyright © 2017年 zhouzheng. All rights reserved.
//

#import "ViewController.h"
#import "PrimaryTableViewCell.h"
#import "Model.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

static NSString *PrimaryTableViewCellID = @"PrimaryTableViewCellID";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
{
    UITableView *_tableView;
    UIImageView *_topView;
    Model *_model;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"cell嵌套滑动";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = YES;
    _tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[PrimaryTableViewCell class] forCellReuseIdentifier:PrimaryTableViewCellID];
    
    _topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -200, ScreenWidth, 200)];
    _topView.image = [UIImage imageNamed:@"gold_bg"];
    [_tableView addSubview:_topView];
//    _tableView.tableHeaderView = _topView;

    _model = [Model defaultModel];
    [_model addObserver:self forKeyPath:@"keyOffsetY" options:NSKeyValueObservingOptionNew context:@"offset"];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    NSString * str = (__bridge NSString *) context;
    CGFloat offsetY = [change[@"new"] floatValue];
    if ([str  isEqual: @"offset"]) {
        NSLog(@"##### %f #####",offsetY);
        if (offsetY >= -64) {//不拉伸136
            _tableView.scrollEnabled = NO;
        }else {
            _tableView.scrollEnabled = YES;
        }
        if(offsetY != _tableView.contentOffset.y) {
            _tableView.contentOffset = CGPointMake(0, offsetY);
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - ******** UITableViewDataSource, UITableViewDelegate ********
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"分类标签，左右滑动";
    [headerView addSubview:label];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenHeight-64-60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PrimaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PrimaryTableViewCellID];
    if (!cell) {
        cell = [[PrimaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PrimaryTableViewCellID];
    }
    
    cell.didEndDraggingBlock = ^(BOOL status) {
        if (status) {
            [UIView animateWithDuration:0.35 animations:^{
                
                _tableView.contentOffset = CGPointMake(0, -264);
                _topView.frame = CGRectMake(0, -200, ScreenWidth, 200);
                
            } completion:^(BOOL finished) {
                
            }];
        }
    };
    
    return cell;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"*** primary *** %.2f",offsetY);

    _model.keyOffsetY = offsetY;
    
//顶部需要拉伸效果，topView加到tableView.subView
    
    if (offsetY < -264) {
        _topView.frame = CGRectMake((ScreenWidth-(ScreenWidth*(-offsetY-64)/200))/2, offsetY+64, ScreenWidth*(-offsetY-64)/200, -offsetY-64);
    
    }else if (offsetY >= -264 && offsetY < 0) {
        _tableView.contentInset = UIEdgeInsetsMake(-offsetY, 0, 0, 0);
    
    }else {
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
 
//顶部不需要拉伸效果，topView加到tableView.tableHeaderView
//
//    if(scrollView.contentOffset.y < -64) {
//        scrollView.contentOffset = CGPointMake(0, -64);
//    }
    
    _model.keyOffsetY = _tableView.contentOffset.y;
    
}


-(void)dealloc {

    [_model removeObserver:self forKeyPath:@"keyOffsetY"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
