//
//  PersonalInfoSettingViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/12.
//  Copyright (c) 2015年 echo. All rights reserved.
//SettingCell

#import "PersonalInfoSettingViewController.h"
#import "UserService.h"
#import "SettingViewController.h"
#import "SelectBirthdayViewController.h"
#import "SelectGenderViewController.h"
#import "AlterPasswordViewController.h"

@interface PersonalInfoSettingViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArry;
@end

@implementation PersonalInfoSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleArry = @[@"用户名",@"性别",@"生日",@"手机号",@"QQ",@"地址",@"邮箱",@"备用号码",@"备用地址",@"修改密码",@"安全退出"];
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 69)];
    footerV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = footerV;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserObject:) name:@"setting" object:nil];
}
#pragma tableView-代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 9;
            break;
            
        default:
            return 2;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
    UILabel *titleL = (UILabel *)[cell viewWithTag:10];
    titleL.text = self.titleArry[indexPath.section*9+indexPath.row];
    UILabel *contentL = (UILabel *)[cell viewWithTag:11];
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
            {
                if(self.user.user_name == nil||[self.user.user_name isEqualToString:@""]){
                    contentL.text = [NSString stringWithFormat:@"请输入%@",self.titleArry[indexPath.section*9+indexPath.row]];
                }else{
                    contentL.text = self.user.user_name;
                }
            }
                break;
            case 1:
            {
                if(self.user.user_sex == nil||[self.user.user_sex isEqualToString:@""]){
                    contentL.text = [NSString stringWithFormat:@"请输入%@",self.titleArry[indexPath.section*9+indexPath.row]];
                }else{
                    contentL.text = self.user.user_sex;
                }
            }
                break;
            case 2:
            {
                if(self.user.user_birthday == nil||[self.user.user_birthday isEqualToString:@""]){
                    contentL.text = [NSString stringWithFormat:@"请输入%@",self.titleArry[indexPath.section*9+indexPath.row]];
                }else{
                    contentL.text = self.user.user_birthday;
                }
            }
                break;
            case 3:
            {
                if(self.user.user_phone == nil||[self.user.user_phone isEqualToString:@""]){
                    contentL.text = [NSString stringWithFormat:@"请输入%@",self.titleArry[indexPath.section*9+indexPath.row]];
                }else{
                    contentL.text = self.user.user_phone;
                }
            }
                break;
            case 4:
            {
                if(self.user.user_qq == nil||[self.user.user_qq isEqualToString:@""]){
                    contentL.text = [NSString stringWithFormat:@"请输入%@",self.titleArry[indexPath.section*9+indexPath.row]];
                }else{
                    contentL.text = self.user.user_qq;
                }
            }
                break;
            case 5:
            {
                if(self.user.user_address == nil||[self.user.user_address isEqualToString:@""]){
                    contentL.text = [NSString stringWithFormat:@"请输入%@",self.titleArry[indexPath.section*9+indexPath.row]];
                }else{
                    contentL.text = self.user.user_address;
                }
            }
                break;
            case 6:
            {
                if(self.user.user_mail == nil||[self.user.user_mail isEqualToString:@""]){
                    contentL.text = [NSString stringWithFormat:@"请输入%@",self.titleArry[indexPath.section*9+indexPath.row]];
                }else{
                    contentL.text = self.user.user_mail;
                }
            }
                break;
            case 7:
            {
                if(self.user.user_phone2 == nil||[self.user.user_phone2 isEqualToString:@""]){
                    contentL.text = [NSString stringWithFormat:@"请输入%@",self.titleArry[indexPath.section*9+indexPath.row]];
                }else{
                    contentL.text = self.user.user_phone2;
                }
            }
                break;
                
            default:
            {
                if(self.user.user_address2 == nil||[self.user.user_address2 isEqualToString:@""]){
                    contentL.text = [NSString stringWithFormat:@"请输入%@",self.titleArry[indexPath.section*9+indexPath.row]];
                }else{
                    contentL.text = self.user.user_address2;
                }
            }
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            {
                contentL.text = @"";
            }
                break;
                
            default:
            {
                contentL.text = @"";
            }
                break;
        }
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return [NSString stringWithFormat:@"你好，%@",self.user.user_name];
    else
        return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return 40;
    else
        return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1&&indexPath.row == 1){//退出登录
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定退出当前登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertV show];
    }else if (indexPath.section == 1&&indexPath.row == 0){//修改密码
        [self performSegueWithIdentifier:@"GoToAlterPassword" sender:self];
    }else if (indexPath.section == 0&&indexPath.row == 1){//修改性别
        SelectGenderViewController *selectVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectGenderViewController"];
        selectVC.user = self.user;
        selectVC.view.frame = CGRectMake(0, 64, ScreenWidth,ScreenHeight-64);
        [self addChildViewController:selectVC];
        [self.view addSubview:selectVC.view];
    }else if (indexPath.section == 0&&indexPath.row == 2){//修改生日
        SelectBirthdayViewController *selectVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectBirthdayViewController"];
        selectVC.user = self.user;
        selectVC.view.frame = CGRectMake(0, 64, ScreenWidth,ScreenHeight-64);
        [self addChildViewController:selectVC];
        [self.view addSubview:selectVC.view];
    }else{//修改剩下的属性
        [self performSegueWithIdentifier:@"SettingID" sender:self];
    }
}

#pragma alertView-代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        UserService *userS = [[UserService alloc] init];
        [userS exitCurrentUser];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//通知响应事件
-(void)updateUserObject:(NSNotification *)notification{
    self.user = [notification object];
    [self.tableView reloadData];
}
//保存个人资料修改按钮事件
- (IBAction)saveInfoBtnClick:(UIBarButtonItem *)sender {
    UserService *userS = [[UserService alloc] init];
    [userS alterUserInfo:self.user success:^(BOOL isSuccess, NSString *content, User *user) {
        if(isSuccess){
            NSLog(@"%@",content);
            self.user = user;
            [self.navigationController popViewControllerAnimated:YES];
            [SVProgressHUD dismiss];
        }else{
            NSLog(@"%@",content);
            [SVProgressHUD dismiss];
        }
    }];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"SettingID"]){
        SettingViewController *settingVC = segue.destinationViewController;
        settingVC.row = (int)[self.tableView indexPathForSelectedRow].row;
        settingVC.user = self.user;
        settingVC.titleArry = self.titleArry;
    }else if([segue.identifier isEqualToString:@"GoToAlterPassword"]){
        AlterPasswordViewController *alterVC = segue.destinationViewController;
        alterVC.user = self.user;
    }
    
}


@end
