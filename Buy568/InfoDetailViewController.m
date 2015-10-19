//
//  InfoDetailViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/10.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "InfoDetailViewController.h"
#import "InfoService.h"

@interface InfoDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) InfoService *infoS;
@property (nonatomic,strong) Info *info;
@property (nonatomic,strong) UIPageControl *pageC;
@property (weak, nonatomic) IBOutlet UILabel *contactL;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@end

@implementation InfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.infoS = [[InfoService alloc] init];
    __weak typeof(self) MySelf = self;
    [self.infoS getInfoDetail:self.info_id success:^(Info *info) {
        MySelf.info = info;
        MySelf.contactL.text = info.info_contact;
        MySelf.phoneL.text = info.info_tel;
        [MySelf addScrollHeadView:info.info_imgs_new];
        [MySelf.tableView reloadData];
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
        [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgArry[i]]] placeholderImage:[UIImage imageNamed:@"grzx_topbg.png"]];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
            
        default:
        {
            if(self.selected == 0){
                return 3;
            }else{
                return 4;
            }
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if(self.selected == 0){
        switch (indexPath.section) {
            case 0:
            {
                if(indexPath.row == 0){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoTitleCell" forIndexPath:indexPath];
                    UILabel *titleL = (UILabel *)[cell viewWithTag:10];
                    UILabel *hitsL = (UILabel *)[cell viewWithTag:11];
                    
                    titleL.text = self.info.info_title;
                    
                    hitsL.text = [NSString stringWithFormat:@"%d人浏览",self.info.info_hits];
                }else{
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoMoneyCell" forIndexPath:indexPath];
                    UILabel *priceL = (UILabel *)[cell viewWithTag:10];
                    UILabel *timeL = (UILabel *)[cell viewWithTag:11];
                    
                    priceL.text = self.info.info_home_price;
                    NSString *timeStr = [[self.info.info_addtime componentsSeparatedByString:@" "] firstObject];
                    timeL.text = timeStr;
                }
            }
                break;
                
            default:
            {
                if(indexPath.row == 0){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoAddressCell" forIndexPath:indexPath];
                    UILabel *addressL = (UILabel *)[cell viewWithTag:10];
                    
                    addressL.text = self.info.info_home_address;
                }else if (indexPath.row == 1){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoConditionCell" forIndexPath:indexPath];
                    for(int i = 10;i < self.info.info_home_config_new.count+10;i++){
                        UIButton *btn = (UIButton *)[cell viewWithTag:i];
                        [btn setTitle:self.info.info_home_config_new[i-10] forState:UIControlStateNormal];
                        btn.hidden = NO;
                    }
                }else{
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoIntroductCell" forIndexPath:indexPath];
                    UILabel *introL = (UILabel *)[cell viewWithTag:11];
                    
                    introL.text = self.info.info_home_explain;
                }
            }
                break;
        }

    }else{
        
        switch (indexPath.section) {
            case 0:
            {
                if(indexPath.row == 0){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoTitleCell" forIndexPath:indexPath];
                    UILabel *titleL = (UILabel *)[cell viewWithTag:10];
                    UILabel *hitsL = (UILabel *)[cell viewWithTag:11];
                    
                    titleL.text = self.info.info_title;
                    
                    hitsL.text = [NSString stringWithFormat:@"%d人浏览",self.info.info_hits];
                }else{
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoMoneyCell" forIndexPath:indexPath];
                    UILabel *priceL = (UILabel *)[cell viewWithTag:10];
                    UILabel *timeL = (UILabel *)[cell viewWithTag:11];
                    
                    priceL.text = self.info.info_job_salary;
                    NSString *timeStr = [[self.info.info_addtime componentsSeparatedByString:@" "] firstObject];
                    timeL.text = timeStr;
                }
            }
                break;
                
            default:
            {
                if(indexPath.row == 0){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoAddressCell" forIndexPath:indexPath];
                    UILabel *addressL = (UILabel *)[cell viewWithTag:10];
                    
                    addressL.text = self.info.info_job_position;
                }else if (indexPath.row == 1){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoDetailCell" forIndexPath:indexPath];
                    UILabel *nameL = (UILabel *)[cell viewWithTag:10];
                    UILabel *numL = (UILabel *)[cell viewWithTag:11];
                    UILabel *requreL = (UILabel *)[cell viewWithTag:12];
                    
                    nameL.text = self.info.info_job_companyname;
                    
                    numL.text = [NSString stringWithFormat:@"%@人",self.info.info_job_number];
                    
                    requreL.text = self.info.info_job_requirement;
                }else if (indexPath.row == 2){
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoConditionCell" forIndexPath:indexPath];
                    for(int i = 10;i < self.info.info_job_weal_new.count+10;i++){
                        UIButton *btn = (UIButton *)[cell viewWithTag:i];
                        [btn setTitle:self.info.info_job_weal_new[i-10] forState:UIControlStateNormal];
                        btn.hidden = NO;
                    }
                }else{
                    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoIntroductCell" forIndexPath:indexPath];
                    UILabel *introTitleL = (UILabel *)[cell viewWithTag:10];
                    UILabel *introL = (UILabel *)[cell viewWithTag:11];
                    introTitleL.text = @"公司介绍";
                    introL.text = self.info.info_job_companyintro;
                }
            }
                break;
        }

        
    }
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selected == 0){
        switch (indexPath.section) {
            case 0:
            {
                if(indexPath.row == 0){
                    return 44;
                }else{
                    return 44;
                }
            }
                break;
                
            default:
            {
                if(indexPath.row == 0){
                    CGFloat height = 23.0;
                    height += [LZXHelper textHeightFromTextString:self.info.info_home_address width:295.0 fontSize:16.0];
                    return height;
                }else if (indexPath.row == 1){
                    return 92;
                }else{
                    CGFloat height = 47.0;
                    
                    height += [LZXHelper textHeightFromTextString:self.info.info_home_explain width:349.0 fontSize:16.0];
                    return height;
                }
            }
                break;
        }
    }else{
        switch (indexPath.section) {
            case 0:
            {
                if(indexPath.row == 0){
                    return 44;
                }else{
                    return 44;
                }
            }
                break;
                
            default:
            {
                if(indexPath.row == 0){
                    CGFloat height = 23.0;
                    height += [LZXHelper textHeightFromTextString:self.info.info_job_position width:295.0 fontSize:16.0];
                    return height;
                }else if (indexPath.row == 1){
                    return 95;
                }else if (indexPath.row == 2){
                    return 92;
                }else{
                    CGFloat height = 47.0;
                    height += [LZXHelper textHeightFromTextString:self.info.info_job_companyintro width:349.0 fontSize:16.0];
                    return height;
                }
            }
                break;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0;
            break;
            
        default:
             return 10;
            break;
    }
   
}
#pragma button-点击事件
//电话
- (IBAction)callPhoneBtnClick:(UIButton *)sender {
    
}
//短信
- (IBAction)messageBtnClick:(UIButton *)sender {
    
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
