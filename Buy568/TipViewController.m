//
//  TipViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/5.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "TipViewController.h"
#import "UserService.h"

@interface TipViewController ()
@property (nonatomic,strong) NSArray *tipArry;
@property (nonatomic,strong) NSString *tip;
@property (weak, nonatomic) IBOutlet UIButton *btn1;//默认将卖假货的btn设置为selected状态
@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.btn1.selected = YES;
    self.tip = @"卖假货";
    self.tipArry = @[@"卖假货",@"卖过期货",@"服务态度不好",@"宰客"];
}
//checkbox按钮选中事件
- (IBAction)checkboxTipBtnClick:(UIButton *)sender {
    for(int i = 10;i < 14; i++){
        if(sender.tag == i){
            sender.selected = YES;
        }else{
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            btn.selected = NO;
        }
    }
    self.tip = self.tipArry[sender.tag-10];
}
//提交按钮选中事件
- (IBAction)sumbitBtnClick:(UIButton *)sender {
    UserService *userS = [[UserService alloc] init];
    [userS userTipCompany:self.user_id company_id:self.company_id report_content:self.tip success:^(BOOL isSuccess, NSString *content) {
        if(isSuccess){
            NSLog(@"%@",content);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"%@",content);
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
