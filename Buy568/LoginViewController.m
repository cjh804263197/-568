//
//  LoginViewController.m
//  Buy568
//
//  Created by echo23 on 15/9/29.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "LoginViewController.h"
#import "UserService.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//登录按钮事件
- (IBAction)loginBtnClick:(UIButton *)sender {
    User *user = [[User alloc] init];
    user.user_phone = self.phoneTF.text;
    user.user_password = self.passwordTF.text;
    UserService *userS = [[UserService alloc] init];
    [userS userLoginCheck:user success:^(BOOL isSuccess, User *user) {
        NSLog(@"user == %@",user);
        if(isSuccess){//登录成功
            //将user对象转化为NSData类型
             NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
            //将当前用户粗存入本地
            NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
            [userD setObject:userData forKey:@"user"];
            [SVProgressHUD dismiss];
            NSLog(@"登陆成功");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD dismiss];
            NSLog(@"登录失败");
        }
    }];
}
//记住密码checkbox按钮事件
- (IBAction)remberPasswordBtnClick:(UIButton *)sender {
    if(sender.selected){
        sender.selected = NO;
    }else{
        sender.selected = YES;
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
