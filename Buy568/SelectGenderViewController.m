//
//  SelectGenderViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/13.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "SelectGenderViewController.h"

@interface SelectGenderViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *genderL;
@property (nonatomic,strong) NSArray *arry;
@property (nonatomic,strong) NSString *gender;
@end

@implementation SelectGenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arry = @[@"男",@"女"];
    self.genderL.text = self.user.user_sex;
    self.gender = self.user.user_sex;
}
- (IBAction)cancleBtnClick:(UIButton *)sender {
    [self.view removeFromSuperview];
}
- (IBAction)sureBtnClick:(UIButton *)sender {
    self.user.user_sex = self.gender;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setting" object:self.user userInfo:nil];
    [self.view removeFromSuperview];
}
#pragma pickerView-代理
//返回几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//返回每列有几行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.arry[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.gender = self.arry[row];
    self.genderL.text = self.gender;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view removeFromSuperview];
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
