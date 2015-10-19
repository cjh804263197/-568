//
//  AlterPasswordViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/13.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "AlterPasswordViewController.h"
#import "UserService.h"

@interface AlterPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPW;
@property (weak, nonatomic) IBOutlet UITextField *NewPW;
@property (weak, nonatomic) IBOutlet UITextField *rNewPW;

@end

@implementation AlterPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//确定按钮事件
- (IBAction)sureBtnClick:(UIButton *)sender {
    if([_NewPW.text isEqualToString:_rNewPW.text]){
        UserService *userS = [[UserService alloc] init];
        [userS alterUserPassword:self.user.user_id OldPassword:_oldPW.text NewPassword:_NewPW.text RepartNewPassword:_rNewPW.text success:^(BOOL isSuccess, NSString *content) {
            if(isSuccess){
                NSLog(@"%@",content);
                [SVProgressHUD dismiss];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                NSLog(@"%@",content);
                [SVProgressHUD dismiss];
            }
        }];
    }else{
        NSLog(@"新密码输入不一致！");
    }
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
