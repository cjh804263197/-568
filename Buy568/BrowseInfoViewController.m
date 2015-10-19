//
//  BrowseInfoViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/16.
//  Copyright (c) 2015年 echo. All rights reserved.
//browseGoToRelease

#import "BrowseInfoViewController.h"
#import "Info.h"
#import "InfoService.h"
#import "ReleaseHomeInfoViewController.h"

@interface BrowseInfoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) InfoService *infoS;
@property (nonatomic,strong) NSArray *releaseArry;
@end

@implementation BrowseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _infoS = [[InfoService alloc] init];
    _releaseArry = [NSArray array];
    __weak typeof(self) MySelf = self;
    [_infoS getMyReleaseInfoList:self.user_id success:^(NSArray *releaseInfoArry) {
        MySelf.releaseArry = releaseInfoArry;
        [MySelf.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    self.tableView.tableFooterView = [[UIView alloc] init];
}
#pragma tableView-代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.releaseArry.count+3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
            UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
            UILabel *titleL = (UILabel *)[cell viewWithTag:11];
            
            imageV.image = [UIImage imageNamed:@"flxx_fangchan.png"];
            titleL.text = @"免费发布房产信息";
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
            UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
            UILabel *titleL = (UILabel *)[cell viewWithTag:11];
            
            imageV.image = [UIImage imageNamed:@"flxx_zhaopin.png"];
            titleL.text = @"免费发布招聘信息";
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
        }
            break;
            
        default:
        {
            Info *info = _releaseArry[indexPath.row - 3];
            cell = [tableView dequeueReusableCellWithIdentifier:@"lastCell" forIndexPath:indexPath];
            
            UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
            UILabel *titleL = (UILabel *)[cell viewWithTag:11];
            UILabel *contactL = (UILabel *)[cell viewWithTag:12];
            UILabel *priceL = (UILabel *)[cell viewWithTag:13];
            UIButton *canleReleaseBtn = (UIButton *)[cell viewWithTag:14];
            UILabel *timeL = (UILabel *)[cell viewWithTag:15];
            
            [imageV sd_setImageWithURL:[NSURL URLWithString:info.info_imgs] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
            
            titleL.text = info.info_title;
            
            contactL.text = info.info_contact;
            
            priceL.text = [NSString stringWithFormat:@"¥%0.1lf",info.info_money];
            
            timeL.text = info.info_edittime;
            
            canleReleaseBtn.layer.borderColor = [UIColor blueColor].CGColor;
            canleReleaseBtn.layer.borderWidth = 1.0;
            [canleReleaseBtn addTarget:self action:@selector(cancleReleaseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0||indexPath.row == 1){
        return 50;
    }else if (indexPath.row == 2){
        return 44;
    }else{
        return 100;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0||indexPath.row == 1){
        [self performSegueWithIdentifier:@"browseGoToRelease" sender:self];
    }
}
#pragma button-点击事件
-(void)cancleReleaseBtnClick:(UIButton *)button{
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    Info *info = self.releaseArry[index.row-3];
    __weak typeof(self) MySelf = self;
    [_infoS deleteMyRelease:info.info_id success:^(BOOL isSuccess, NSString *content) {
        if(isSuccess){
            NSLog(@"%@",content);
            [MySelf.infoS getMyReleaseInfoList:MySelf.user_id success:^(NSArray *releaseInfoArry) {
                MySelf.releaseArry = releaseInfoArry;
                [MySelf.tableView reloadData];
                [SVProgressHUD dismiss];
            }];
        }else{
            NSLog(@"%@",content);
        }
    }];
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
    if([segue.identifier isEqualToString:@"browseGoToRelease"]){
        ReleaseHomeInfoViewController *releaseVC = segue.destinationViewController;
        releaseVC.selected = (int)[self.tableView indexPathForSelectedRow].row;
    }
}


@end
