//
//  WriteCommentViewController.m
//  Buy568
//  发表评论VC
//  Created by echo23 on 15/10/5.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "WriteCommentViewController.h"
#import "UserService.h"

@interface WriteCommentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textF;

@end

@implementation WriteCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//评论提交按钮事件
- (IBAction)sumbitCommentBtnClick:(UIBarButtonItem *)sender {
    UserService *userS = [[UserService alloc] init];
    [userS userWriteComment:self.user_id company_id:self.company_id comment_content:self.textF.text success:^(BOOL isSuccess) {
        if(isSuccess){
            NSLog(@"发表成功");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"发表失败");
        }
    }];
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
