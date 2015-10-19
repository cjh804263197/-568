//
//  MyCenterViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/12.
//  Copyright (c) 2015年 echo. All rights reserved.
//GoToApplyCompany

#import "MyCenterViewController.h"
#import "UserService.h"
#import "PersonalInfoSettingViewController.h"
#import "MyOrderViewController.h"
#import "MyCollectionViewController.h"
#import "MyCartViewController.h"
#import "BrowseInfoViewController.h"

@interface MyCenterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *imgArry;
@property (nonatomic,strong) NSArray *titleArry;
@property (nonatomic,strong) UserService *userS;
@end

@implementation MyCenterViewController
-(void)viewWillAppear:(BOOL)animated{
    [self addTableviewHeaderView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imgArry = @[@"grzx_icon1.png",@"grzx_icon5.png",@"grzx_icon6.png",@"grzx_icon3.png",@"icon_shoucang.png",@"grzx_icon4.png"];
    self.titleArry = @[@"订单管理",@"我的账单",@"我的购物车",@"我的店铺",@"我的收藏",@"浏览信息"];
    self.userS = [[UserService alloc] init];
    [self addTableviewHeaderView];
    [self addTableViewFooterView];
}
//添加tableview的headview
-(void)addTableviewHeaderView{
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    headV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grzx_topbg.png"]];
    //判断当前是否有用户登录
    [self.userS currentUserIsLogin:^(BOOL isLogin, User *user) {
        if(isLogin){
            UILabel *helloL = [[UILabel alloc] initWithFrame:CGRectMake(18, 17, 45, 21)];
            helloL.font = [UIFont systemFontOfSize:15.0];
            helloL.text = @"您好，";
            
            UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(71, 17, 180, 21)];
            nameL.font = [UIFont systemFontOfSize:15.0];
            nameL.text = user.user_name;
            
            UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            infoBtn.frame = CGRectMake(259, 18, 108, 20);
            [infoBtn setTitle:@"个人资料" forState:UIControlStateNormal];
            [infoBtn setBackgroundColor:[UIColor blackColor]];
            [infoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            infoBtn.alpha  = 0.3;
            [infoBtn addTarget:self action:@selector(infoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            infoBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
            infoBtn.layer.cornerRadius = 5.0;
            
            UILabel *cridetL = [[UILabel alloc] initWithFrame:CGRectMake(18, 59, 75, 21)];
            cridetL.font = [UIFont systemFontOfSize:15.0];
            cridetL.text = @"累计积分：";
            
            UILabel *getCL = [[UILabel alloc] initWithFrame:CGRectMake(101, 59, 150, 21)];
            getCL.font = [UIFont systemFontOfSize:15.0];
            getCL.text = user.user_integral;
            
            UIButton *integralBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            integralBtn.frame = CGRectMake(259, 60, 108, 20);
            [integralBtn setTitle:@"等级说明" forState:UIControlStateNormal];
            [integralBtn setBackgroundColor:[UIColor blackColor]];
            [integralBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            integralBtn.alpha  = 0.3;
            [integralBtn addTarget:self action:@selector(integralBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            integralBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
            integralBtn.layer.cornerRadius = 5.0;
            
            [headV addSubview:helloL];
            [headV addSubview:nameL];
            [headV addSubview:infoBtn];
            [headV addSubview:cridetL];
            [headV addSubview:getCL];
            [headV addSubview:integralBtn];
            
        }else{
            UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            loginBtn.frame = CGRectMake(135, 30, 100, 30);
            [loginBtn setBackgroundColor:[UIColor blackColor]];
            [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
            [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            loginBtn.alpha = 0.3;
            UILabel *tipL = [[UILabel alloc] initWithFrame:CGRectMake(90, 70, 200, 21)];
            tipL.font = [UIFont systemFontOfSize:16.0];
            tipL.textColor = [UIColor whiteColor];
            tipL.textAlignment = NSTextAlignmentCenter;
            tipL.text = @"您还没有登录~~";
            [headV addSubview:loginBtn];
            [headV addSubview:tipL];
        }
        
    }];
    self.tableView.tableHeaderView = headV;
}
//添加tableview的footerView
-(void)addTableViewFooterView{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    footerV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton *telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    telBtn.frame = CGRectMake(8, 20, 359, 40);
    [telBtn setImage:[UIImage imageNamed:@"flxx_tel.png"] forState:UIControlStateNormal];
    [telBtn setTitle:@"客服电话" forState:UIControlStateNormal];
    [telBtn setBackgroundColor:[UIColor orangeColor]];
    telBtn.layer.cornerRadius = 5.0;
    telBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [telBtn addTarget:self action:@selector(telBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerV addSubview:telBtn];
    self.tableView.tableFooterView = footerV;
    
}
#pragma tableView-代理
//块数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//块内行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
//返回Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalCell" forIndexPath:indexPath];
    UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
    UILabel *titleL = (UILabel *)[cell viewWithTag:11];
    imageV.image = [UIImage imageNamed:self.imgArry[indexPath.section*3+indexPath.row]];
    titleL.text = self.titleArry[indexPath.section*3+indexPath.row];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"订单管理";
            break;
            
        default:
            return @"其他";
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                [_userS currentUserIsLogin:^(BOOL isLogin, User *user) {
                    if(isLogin){
                        [self performSegueWithIdentifier:@"GoToMyOrder" sender:self];
                    }else{
                        [self performSegueWithIdentifier:@"PersonalInfoGoToLogin" sender:self];
                    }
                }];
            }
                break;
            case 1:
            {
                
            }
                break;
            default:
            {
                [_userS currentUserIsLogin:^(BOOL isLogin, User *user) {
                    if(isLogin){
                        [self performSegueWithIdentifier:@"GoToCart" sender:self];
                    }else{
                        [self performSegueWithIdentifier:@"PersonalInfoGoToLogin" sender:self];
                    }
                }];
            }
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            {
                [_userS currentUserIsLogin:^(BOOL isLogin, User *user) {
                    if(isLogin){
                        [self performSegueWithIdentifier:@"GoToApplyCompany" sender:self];
                    }else{
                        [self performSegueWithIdentifier:@"PersonalInfoGoToLogin" sender:self];
                    }
                }];
            }
                break;
            case 1:
            {
                [_userS currentUserIsLogin:^(BOOL isLogin, User *user) {
                    if(isLogin){
                        [self performSegueWithIdentifier:@"GoToCollection" sender:self];
                    }else{
                        [self performSegueWithIdentifier:@"PersonalInfoGoToLogin" sender:self];
                    }
                }];
            }
                break;
            default:
            {
                [_userS currentUserIsLogin:^(BOOL isLogin, User *user) {
                    if(isLogin){
                        [self performSegueWithIdentifier:@"GoToBroweInfo" sender:self];
                    }else{
                        [self performSegueWithIdentifier:@"PersonalInfoGoToLogin" sender:self];
                    }
                }];
            }
                break;
        }
    }
}
#pragma button-点击事件
//登录按钮事件
-(void)loginBtnClick:(UIButton *)button{
    [self performSegueWithIdentifier:@"PersonalInfoGoToLogin" sender:self];
}
//查看个人资料按钮事件
-(void)infoBtnClick:(UIButton *)button{
    [self performSegueWithIdentifier:@"GoToSetting" sender:self];
}
//等级说明查看事件
-(void)integralBtnClick:(UIButton *)button{
    
}
//客服电话按钮事件
-(void)telBtnClick:(UIButton *)button{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"GoToSetting"]){
        PersonalInfoSettingViewController *personalVC = segue.destinationViewController;
        [self.userS currentUserIsLogin:^(BOOL isLogin, User *user) {
            personalVC.user = user;
        }];
    }else if ([segue.identifier isEqualToString:@"GoToMyOrder"]){
        MyOrderViewController *orderVC = segue.destinationViewController;
        [self.userS currentUserIsLogin:^(BOOL isLogin, User *user) {
            orderVC.user_id = user.user_id;
        }];
    }else if ([segue.identifier isEqualToString:@"GoToCollection"]){
        MyCollectionViewController *collectionVC = segue.destinationViewController;
        [self.userS currentUserIsLogin:^(BOOL isLogin, User *user) {
            collectionVC.user_id = user.user_id;
        }];
    }else if ([segue.identifier isEqualToString:@"GoToCart"]){
        MyCartViewController *cartVC = segue.destinationViewController;
        [self.userS currentUserIsLogin:^(BOOL isLogin, User *user) {
            cartVC.user_id = user.user_id;
        }];
    }else if ([segue.identifier isEqualToString:@"GoToBroweInfo"]){
        BrowseInfoViewController *browseVC = segue.destinationViewController;
        [self.userS currentUserIsLogin:^(BOOL isLogin, User *user) {
            browseVC.user_id = user.user_id;
        }];
    }
}


@end
