//
//  SettingViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/13.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textF;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    switch (_row) {
        case 0:
        {
            if(self.user.user_name == nil||[self.user.user_name isEqualToString:@""])
                self.textF.placeholder = [NSString stringWithFormat:@"请输入%@",self.titleArry[_row]];
            else
                self.textF.text = self.user.user_name;
        }
            break;
        case 3:
        {
            if(self.user.user_phone == nil||[self.user.user_phone isEqualToString:@""])
                self.textF.placeholder = [NSString stringWithFormat:@"请输入%@",self.titleArry[_row]];
            else
                self.textF.text = self.user.user_phone;
        }
            break;
        case 4:
        {
            if(self.user.user_qq == nil||[self.user.user_qq isEqualToString:@""])
                self.textF.placeholder = [NSString stringWithFormat:@"请输入%@",self.titleArry[_row]];
            else
                self.textF.text = self.user.user_qq;
        }
            break;
        case 5:
        {
            if(self.user.user_address == nil||[self.user.user_address isEqualToString:@""])
                self.textF.placeholder = [NSString stringWithFormat:@"请输入%@",self.titleArry[_row]];
            else
                self.textF.text = self.user.user_address;
        }
            break;
        case 6:
        {
            if(self.user.user_mail == nil||[self.user.user_mail isEqualToString:@""])
                self.textF.placeholder = [NSString stringWithFormat:@"请输入%@",self.titleArry[_row]];
            else
                self.textF.text = self.user.user_mail;
        }
            break;
        case 7:
        {
            if(self.user.user_phone2 == nil||[self.user.user_phone2 isEqualToString:@""])
                self.textF.placeholder = [NSString stringWithFormat:@"请输入%@",self.titleArry[_row]];
            else
                self.textF.text = self.user.user_phone2;
        }
            break;
        case 8:
        {
            if(self.user.user_address2 == nil||[self.user.user_address2 isEqualToString:@""])
                self.textF.placeholder = [NSString stringWithFormat:@"请输入%@",self.titleArry[_row]];
            else
                self.textF.text = self.user.user_address2;
        }
            break;
        default:
            break;
    }
}
//确定修改按钮事件
- (IBAction)sureBtnClick:(UIButton *)sender {
    switch (_row) {
        case 0:
        {
                self.user.user_name = self.textF.text ;
        }
            break;
        case 3:
        {
                 self.user.user_phone = self.textF.text ;
        }
            break;
        case 4:
        {
                 self.user.user_qq = self.textF.text;
        }
            break;
        case 5:
        {
                 self.user.user_address = self.textF.text;
        }
            break;
        case 6:
        {
                 self.user.user_mail = self.textF.text;
        }
            break;
        case 7:
        {
                 self.user.user_phone2 = self.textF.text;
        }
            break;
        case 8:
        {
                 self.user.user_address2 = self.textF.text;
        }
            break;
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setting" object:self.user userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];

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
