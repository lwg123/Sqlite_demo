//
//  ViewController.m
//  英文生词本
//
//  Created by weiguang on 2017/8/15.
//  Copyright © 2017年 weiguang. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
#import "FKWord.h"
#import "FKTableViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *wordField;
@property (weak, nonatomic) IBOutlet UITextField *detailField;
@property (weak, nonatomic) IBOutlet UITextField *keyField;
@property (weak, nonatomic) IBOutlet UITextView *displayText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)addWord {
    NSString *word = self.wordField.text;
    NSString *detail = self.detailField.text;
    
    if (word != nil && word.length>0 && detail != nil && detail.length>0) {
        sqlite3 *database;
        //新建和打开数据库
        sqlite3_open([[self dbPath] UTF8String], &database);
        // 定义执行建表SQL语句
        char *errMsg;
        const char *creatSQL = "create table if not exists word_inf(id integer primary key autoincrement,word text,detail text)";
        int result = sqlite3_exec(database, creatSQL, NULL, NULL, &errMsg);
        if (result == SQLITE_OK) {
            const char *insertSQL = "insert into word_inf values(null,?,?)";
            sqlite3_stmt *stmt;
            //预编译SQL语句，stmt变量保存了预编译结果的指针
            int insertReasult = sqlite3_prepare_v2(database, insertSQL, -1, &stmt, NULL);
            //如果预编译成功
            if (insertReasult == SQLITE_OK) {
                // 为第一个？占位符绑定参数
                sqlite3_bind_text(stmt, 1, [word UTF8String], -1, NULL);
                // 为第二个？占位符绑定参数
                sqlite3_bind_text(stmt, 2, [detail UTF8String], -1, NULL);
                // 执行SQL语句
                sqlite3_step(stmt);
                self.wordField.text = @"";
                self.detailField.text = @"";
            }
            sqlite3_finalize(stmt);
        }
        //关闭数据库
        sqlite3_close(database);
        
    }
}

- (NSString *)dbPath{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [filePath stringByAppendingPathComponent:@"myWords.db"];
}

- (IBAction)finishEdit:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *key = self.keyField.text;
    if (key != nil && key.length > 0) {
        sqlite3 *database;
        sqlite3_open([[self dbPath] UTF8String], &database);
        const char *selectSQL = "select * from word_inf where word like ?";
        sqlite3_stmt *stmt;
        //
        int queryReasult = sqlite3_prepare_v2(database, selectSQL, -1, &stmt, NULL);
        NSMutableArray *result = [NSMutableArray array];
        if (queryReasult == SQLITE_OK) {
            // 为第一个？占位符绑定参数
            sqlite3_bind_text(stmt, 1, [[NSString stringWithFormat:@"%%%@%%",key] UTF8String], -1, NULL);
            // 采用循环多次执行sqlite3_step()函数，并从中取出查询结果
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                // 分别获取当前行的不同列的查询数据
                int word_id = sqlite3_column_int(stmt, 0);
                char *word = (char *)sqlite3_column_text(stmt, 1);
                char *detail = (char *)sqlite3_column_text(stmt, 2);
                FKWord *fkWord = [[FKWord alloc] initWithId:word_id word:[NSString stringWithUTF8String:word] detail:[NSString stringWithUTF8String:detail]];
                [result addObject:fkWord];
            }
        }
        
        //关闭数据库
        sqlite3_close(database);
        FKTableViewController *vc = (FKTableViewController *)segue.destinationViewController;
        // 将查询结果传给FKResultViewController对象显示
        vc.wordArray = result;
    }

}




@end
