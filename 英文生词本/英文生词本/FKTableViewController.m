//
//  FKTableViewController.m
//  英文生词本
//
//  Created by weiguang on 2017/8/15.
//  Copyright © 2017年 weiguang. All rights reserved.
//

#import "FKTableViewController.h"
#import "FKWord.h"

@interface FKTableViewController ()


@end

@implementation FKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.wordArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    FKWord *wordObj = self.wordArray[indexPath.row];
    UILabel *wordLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *detailLabel = (UILabel *)[cell viewWithTag:2];
    wordLabel.text = wordObj.word;
    detailLabel.text = wordObj.detail;
    
    return cell;
}


@end
