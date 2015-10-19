//
//  SelectBirthdayViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/13.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "SelectBirthdayViewController.h"

@interface SelectBirthdayViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@end

@implementation SelectBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //先将之前的用户生日设为datepicker的默认值
    self.timeL.text = self.user.user_birthday;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:self.user.user_birthday];
    [self.datePicker setDate:date];
    //为datepicker设置一个值改变监听，实时改变timel的值
    
    [self.datePicker addTarget:self action:@selector(datePickerValueChange:) forControlEvents:UIControlEventValueChanged];
    //在当前View上添加一个手势
   // UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    //[self.view addGestureRecognizer:tap];
}
//datepicker值改变事件
-(void)datePickerValueChange:(UIDatePicker *)picker{
    NSDateFormatter *dateFormmater=[[NSDateFormatter alloc] init];
    [dateFormmater setDateFormat:@"yyyy-MM-dd"];//设置显示时间格式
    NSString *s=[dateFormmater stringFromDate:picker.date];//date转换为字符串
    self.timeL.text = s;
}
//取消按钮
- (IBAction)cancleBtnClick:(UIButton *)sender {
    [self.view removeFromSuperview];
}
//确定按钮
- (IBAction)sureBtnClick:(UIButton *)sender {
    self.user.user_birthday = self.timeL.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setting" object:self.user userInfo:nil];
    [self.view removeFromSuperview];
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
