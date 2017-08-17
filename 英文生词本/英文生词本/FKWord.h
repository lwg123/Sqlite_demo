//
//  FKWord.h
//  英文生词本
//
//  Created by weiguang on 2017/8/15.
//  Copyright © 2017年 weiguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKWord : NSObject

@property (nonatomic,assign) NSInteger word_id;
@property (nonatomic,copy) NSString *word;
@property (nonatomic,copy) NSString *detail;

- (instancetype)initWithId:(NSInteger)word_id word:(NSString *)word detail:(NSString *)detail;

@end
