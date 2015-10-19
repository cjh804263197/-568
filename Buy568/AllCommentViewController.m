//
//  AllCommentViewController.m
//  Buy568
//  查看所有评论VC
//  Created by echo23 on 15/10/5.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "AllCommentViewController.h"

@interface AllCommentViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AllCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma tableView-代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.company_comment.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    UILabel *user_name_L = (UILabel *)[cell viewWithTag:10];
    UILabel *time_L = (UILabel *)[cell viewWithTag:11];
    UILabel *content_L = (UILabel *)[cell viewWithTag:12];
    Comment *comment = self.company_comment[indexPath.row];
    user_name_L.text = comment.user_name;
    time_L.text = comment.comment_addtime;
    content_L.text = comment.comment_content;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat text_height = 45;
    Comment *comment = self.company_comment[indexPath.row];
    text_height += [LZXHelper textHeightFromTextString:comment.comment_content width:359.0 fontSize:16.0];
    return text_height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
