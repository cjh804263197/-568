//
//  CompanyDetailInfoViewController.m
//  Buy568
//
//  Created by echo23 on 15/9/28.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "CompanyDetailInfoViewController.h"
#import "Company.h"
#import "CompanyService.h"
#import "Product.h"
#import <MediaPlayer/MediaPlayer.h>
#import "User.h"
#import "WriteCommentViewController.h"
#import "AllCommentViewController.h"
#import "TipViewController.h"
#import "UserService.h"

@interface CompanyDetailInfoViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIPageControl *pageC;
@property (nonatomic,strong) Company *companyObjc;
@property (nonatomic,assign) int user_id;

@end

@implementation CompanyDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CompanyService *companyService = [[CompanyService alloc] init];
    [companyService getCompanyDetailInfo:self.company_id success:^(Company *company) {
        [self addScrollHeadView:company.company_imgs_new];
        self.title = company.company_name;
        self.companyObjc = company;
        [_tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}
//添加headView图片展示
-(void)addScrollHeadView:(NSArray *)imgArry{
    //创建一个View用来承载scrollview和pageView
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    //创建一个ScrollView
    UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    scrollV.delegate = self;//为scrollview添加代理
    scrollV.pagingEnabled = YES;//设置scrollview为整页滚动
    scrollV.showsHorizontalScrollIndicator = NO;//设置scrollview的水平滚动条消失
    scrollV.showsVerticalScrollIndicator = NO;//设置scrollview的垂直滚动条消失
    [scrollV setContentSize:CGSizeMake(imgArry.count*ScreenWidth, 200)];
    [headV addSubview:scrollV];
    for(int i = 0; i < imgArry.count; i++){
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, 200)];
        [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerURL,imgArry[i]]] placeholderImage:[UIImage imageNamed:@"grzx_topbg.png"]];
        imageV.tag = 30+i;
        [scrollV addSubview:imageV];
    }
    
    //在scrollView上添加一个蒙版
    UIView *mengV = [[UIView alloc] initWithFrame:CGRectMake(0, 150, ScreenWidth, 50)];
    mengV.backgroundColor = [UIColor lightGrayColor];
    mengV.alpha = 0.6;
    [headV addSubview:mengV];
    //添加UIPageControl
    _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(250, 10, 125, 30)];
    _pageC.currentPage = 0;//设置当前页数为0
    _pageC.numberOfPages = imgArry.count;//设置总页数
    [mengV addSubview:_pageC];
    
     _tableView.tableHeaderView = headV;

}

#pragma tableView-代理
//设置块数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
//设置块内行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 2;
    else if(section == 1)
        return 1;
    else
        return 4+self.companyObjc.company_pro.count;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell= nil;
    switch (indexPath.section) {
        case 0:
        {
            //商家信息title
            if(indexPath.row == 0){
                cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyInfoTitleCell" forIndexPath:indexPath];
                UILabel *numL = (UILabel *)[cell viewWithTag:100];
                numL.text = [NSString stringWithFormat:@"%d%@",self.companyObjc.company_hits,@"人浏览"];
            }else{//商家信息（包含店铺名字和店铺地址）
                cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyInfoCell" forIndexPath:indexPath];
                UILabel *nameL = (UILabel *)[cell viewWithTag:100];
                nameL.text = self.companyObjc.company_name;
                UILabel *addressL = (UILabel *)[cell viewWithTag:101];
                addressL.text = self.companyObjc.company_address;
               // return cell;
            }
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
            UILabel *phoneNumL = (UILabel *)[cell viewWithTag:100];
            phoneNumL.text = [NSString stringWithFormat:@"%@:%@",self.companyObjc.company_contact,self.companyObjc.company_tel];
            UIButton *callBtn = (UIButton *)[cell viewWithTag:101];
            [callBtn addTarget:self action:@selector(callContactBtnClick:) forControlEvents:UIControlEventTouchUpInside];
          //  return cell;
        }
            break;
        case 2:
        {
            if(indexPath.row == 0){
                cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyIntroductionTitleCell" forIndexPath:indexPath];
              //  return cell;
            }
            else if (indexPath.row == 1){
                cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyIntroductionCell" forIndexPath:indexPath];
                UILabel *introductL = (UILabel *)[cell viewWithTag:100];
                introductL.text = self.companyObjc.company_about;
              //  return cell;
            }else if (indexPath.row == 2){
                cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyVideoTitleCell" forIndexPath:indexPath];
                UIButton *videoBtn = (UIButton *)[cell viewWithTag:100];
                if([self.companyObjc.company_video isEqual:[NSNull null]]||[self.companyObjc.company_video isEqualToString:@""]||self.companyObjc.company_video == nil){
                    [videoBtn setTitle:@"无视频" forState:UIControlStateNormal];
                }else{
                    [videoBtn setTitle:@"视频" forState:UIControlStateNormal];
                    [videoBtn addTarget:self action:@selector(startVideoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                  //  return cell;
                }
            }else if (indexPath.row == 3){
                cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyProductTitleCell" forIndexPath:indexPath];
               // return cell;
            }else{
                cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyProductCell" forIndexPath:indexPath];
                UIImageView *imgV = (UIImageView *)[cell viewWithTag:100];
                UILabel *nameL = (UILabel *)[cell viewWithTag:101];
                UILabel *contentL = (UILabel *)[cell viewWithTag:102];
                UILabel *remarkL = (UILabel *)[cell viewWithTag:200];
                Product *pro = self.companyObjc.company_pro[indexPath.row-4];
                [imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerURL,pro.company_pro_imgsrc]] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
                nameL.text = pro.company_pro_title;
                contentL.text = pro.company_pro_content;

                remarkL.text = pro.company_pro_remarks;
              //  return cell;
            }
        }
            break;
        default:
            NSLog(@"tableview加载出错");
            return cell;
            break;
    }
    
    return cell;
}
//返回Cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0)
            return 40.0;
        else
            return 70.0;
    }else if (indexPath.section == 1){
        return 50.0;
    }else{
        if(indexPath.row == 0){
            return 40.0;
        }else if (indexPath.row == 1){
            CGFloat height = 19.0;
            height += [LZXHelper textHeightFromTextString:self.companyObjc.company_about width:359.0 fontSize:16.0];
            return height;
        }else if (indexPath.row == 2){
            return 40.0;
        }else if (indexPath.row == 3){
            return 40.0;
        }else{
            return 90.0;
        }
    }
}
//返回section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1||section == 2)
        return 10;
    else
        return 0;
}
#pragma scrollView-代理
//结束滚动触发的代理事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageC.currentPage = page;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma button-点击事件

//拨打电话Button事件
-(void)callContactBtnClick:(UIButton *)button{
    //调用系统拨打电话事件
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"telprompt://",self.companyObjc.company_tel]]];
}

//播放视频button事件
-(void)startVideoBtnClick:(UIButton *)button{
    MPMoviePlayerViewController *moviePlayer =[[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.companyObjc.company_video]];
    [self presentMoviePlayerViewControllerAnimated:moviePlayer];
}

//发表评论Button事件
- (IBAction)editCommentBtnClick:(UIBarButtonItem *)sender {
    /*NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
   //从沙盒中取出存储的user对象,并进行解档操作
    User *user =  [NSKeyedUnarchiver unarchiveObjectWithData:[userD objectForKey:@"user"]];
    if(user == nil||user.isOnLine == 0)//如果取出的对象为空，或者取出的用户不在线
        [self performSegueWithIdentifier:@"GoToLoginID" sender:self];//跳转到登录界面
    else{//当前用户在线，可以发表评论
       // NSLog(@"当前用户在线，可以发表评论");
        self.user_id = user.user_id;
        [self performSegueWithIdentifier:@"GoToWriteComment" sender:self];
    }*/
    UserService *userS = [[UserService alloc] init];
    __weak typeof(self) MySelf = self;
    [userS currentUserIsLogin:^(BOOL isLogin, User *user) {
        if(isLogin){
            MySelf.user_id = user.user_id;
            [self performSegueWithIdentifier:@"GoToWriteComment" sender:self];
        }else{
            [self performSegueWithIdentifier:@"GoToLoginID" sender:self];//跳转到登录界面
        }
    }];
    
}

//查看所有评论Button事件
- (IBAction)lookAllCommentBtnClick:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"GoToAllComment" sender:self];
}

//分享当前店铺Button事件
- (IBAction)shareCommpanyBtnClick:(UIBarButtonItem *)sender {
}

//举报当前店铺Button事件
- (IBAction)reportCommpanyBtnClick:(UIBarButtonItem *)sender {
   /* NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    //从沙盒中取出存储的user对象,并进行解档操作
    User *user =  [NSKeyedUnarchiver unarchiveObjectWithData:[userD objectForKey:@"user"]];
    if(user == nil||user.isOnLine == 0)//如果取出的对象为空，或者取出的用户不在线
        [self performSegueWithIdentifier:@"GoToLoginID" sender:self];//跳转到登录界面
    else{//当前用户在线，可以发表评论
        // NSLog(@"当前用户在线，可以发表评论");
        self.user_id = user.user_id;
        [self performSegueWithIdentifier:@"GoToTip" sender:self];
    }*/
    UserService *userS = [[UserService alloc] init];
    __weak typeof(self) MySelf = self;
    [userS currentUserIsLogin:^(BOOL isLogin, User *user) {
        if(isLogin){
            MySelf.user_id = user.user_id;
            [self performSegueWithIdentifier:@"GoToTip" sender:self];
        }else{
            [self performSegueWithIdentifier:@"GoToLoginID" sender:self];//跳转到登录界面
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"GoToWriteComment"]){
        WriteCommentViewController *writeVC = segue.destinationViewController;
        writeVC.user_id = self.user_id;
        writeVC.company_id = self.company_id;
    }else if ([segue.identifier isEqualToString:@"GoToAllComment"]){
        AllCommentViewController *allVC = segue.destinationViewController;
        allVC.company_comment = self.companyObjc.company_comment;
    }else if([segue.identifier isEqualToString:@"GoToTip"]){
        TipViewController *tipVC = segue.destinationViewController;
        tipVC.user_id = self.user_id;
        tipVC.company_id = self.company_id;
    }
}


@end
