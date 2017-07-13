//
//  Model.m
//  NestTest
//
//  Created by zhouzheng on 2017/7/5.
//  Copyright © 2017年 zhouzheng. All rights reserved.
//

#import "Model.h"

static Model *model = nil;

@implementation Model

+ (Model *)defaultModel
{
    //GCD语法  Block块中的代码只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (model == nil) {
            model = [[self alloc] init];
        }
        
    });
    return model;
}


@end
