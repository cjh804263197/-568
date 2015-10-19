//
//  FindPasswordViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/5.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "FindPasswordViewController.h"

@interface FindPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *identificationCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *getIdentificationCodeBtn;

@end

@implementation FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //将获取验证码按钮添加边框以及设置圆角
    self.getIdentificationCodeBtn.layer.borderWidth = 1.0;
    self.getIdentificationCodeBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.getIdentificationCodeBtn.layer.cornerRadius = 5.0;
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
