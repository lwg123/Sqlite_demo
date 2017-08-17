//
//  FKWord.m
//  英文生词本
//
//  Created by weiguang on 2017/8/15.
//  Copyright © 2017年 weiguang. All rights reserved.
//

#import "FKWord.h"

@implementation FKWord

- (instancetype)initWithId:(NSInteger)word_id word:(NSString *)word detail:(NSString *)detail{
    if (self = [super init]) {
        _word_id = word_id;
        _word = word;
        _detail = detail;
    }
    return self;
}

@end
