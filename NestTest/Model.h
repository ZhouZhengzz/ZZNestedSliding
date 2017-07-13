//
//  Model.h
//  NestTest
//
//  Created by zhouzheng on 2017/7/5.
//  Copyright © 2017年 zhouzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Model : NSObject

@property (nonatomic, assign) CGFloat keyOffsetY;

+ (Model *)defaultModel;

@end
