//
//  FindMainViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/9.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "FindMainViewController.h"
#import "InfoService.h"
#import "Info.h"
#import "smallInfoType.h"
#import "InfoType.h"
#import "InfoDetailViewController.h"
#import "ReleaseHomeInfoViewController.h"
#import "InfoTypeScrollViewController.h"

@interface FindMainViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *infoTypeArry;
@property (nonatomic,assign) int selected;
@property (nonatomic,strong) NSArray *imgArry;
@property (nonatomic,assign) int info_id;
@property (weak, nonatomic) IBOutlet UIButton *releaseBtn;
@end

@implementation FindMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imgArry= @[@"flxx_fangchan.png",@"flxx_zhaopin.png"];
    self.selected = 0;
    InfoService *infoS = [[InfoService alloc] init];
    __weak typeof(self) MySelf = self;
    [infoS getTypeInfo:2 success:^(NSArray *infoTypeArry) {
        MySelf.infoTypeArry = infoTypeArry;
        [MySelf.collectionView reloadData];
        [SVProgressHUD dismiss];
    }];
    [self addNavigationBar];
}
//设置首页NavigationBar
-(void)addNavigationBar{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 30);
    [btn setImage:[UIImage imageNamed:@"downArrow.png"] forState:UIControlStateNormal];
    [btn setTitle:@"淮滨县" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 20);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *city_bar_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *scan_bar_btn = [[UIBarButtonItem alloc] init];
    scan_bar_btn.image = [UIImage imageNamed:@"saoyisao.png"];
    scan_bar_btn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = scan_bar_btn;
    self.navigationItem.leftBarButtonItem = city_bar_btn;
    
}
#pragma collectionView-代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    InfoType *infoT = self.infoTypeArry[self.selected];
    if(infoT.selectedCount>0&&infoT.selectedCount%2==0){
        return 3;
    }else{
        return 2;
    }
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    InfoType *infoT = self.infoTypeArry[self.selected];
    if(infoT.selectedCount>0&&infoT.selectedCount%2==0){
        switch (section) {
            case 0:
            {
                return self.infoTypeArry.count;
            }
                break;
            case 1:
            {
                InfoType *infoType = self.infoTypeArry[self.selected];
                return infoType.small_infp_type.count;
            }
                break;
            default:
            {
                InfoType *infoType = self.infoTypeArry[self.selected];
                return infoType.listinfo.count;
            }
                break;
        }
    }else{
        switch (section) {
            case 0:
            {
                return self.infoTypeArry.count;
            }
                break;
            default:
            {
                InfoType *infoType = self.infoTypeArry[self.selected];
                return infoType.listinfo.count;
            }
                break;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = nil;
    InfoType *infoT = self.infoTypeArry[self.selected];
    if(infoT.selectedCount > 0 && infoT.selectedCount%2 == 0){
        switch (indexPath.section) {
            case 0:
            {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FirstTypeCell" forIndexPath:indexPath];
                UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
                UILabel *titlL = (UILabel *)[cell viewWithTag:11];
                UIImageView *line = (UIImageView *)[cell viewWithTag:12];
                if(indexPath.row == self.selected){
                    imageV.image = [UIImage imageNamed:self.imgArry[indexPath.row]];
                    line.hidden = NO;
                }
                InfoType *infoType = self.infoTypeArry[indexPath.row];
                titlL.text = infoType.info_type_name;
            }
                break;
            case 1:
            {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"secondTypeCell" forIndexPath:indexPath];
                InfoType *infoType = self.infoTypeArry[self.selected];
                smallInfoType *smallInfoType = infoType.small_infp_type[indexPath.row];
                UILabel *titlL = (UILabel *)[cell viewWithTag:10];
                titlL.text = smallInfoType.info_type_name;
            }
                break;
            default:
            {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HouseOrWorkCell" forIndexPath:indexPath];
                InfoType *infoType = self.infoTypeArry[self.selected];
                Info *info = infoType.listinfo[indexPath.row];
                UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
                UILabel *titlL = (UILabel *)[cell viewWithTag:11];
                UILabel *addressL = (UILabel *)[cell viewWithTag:12];
                UILabel *priceL = (UILabel *)[cell viewWithTag:13];
                UILabel *timeL = (UILabel *)[cell viewWithTag:14];
                
                [imageV sd_setImageWithURL:[NSURL URLWithString:info.info_imgs] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
                titlL.text = info.info_title;
                addressL.text = info.info_address;
                
                priceL.text = [NSString stringWithFormat:@"¥%0.0lf",info.info_money];
                NSString *timeStr = [[info.info_addtime componentsSeparatedByString:@" "] firstObject];
                timeL.text = timeStr;
            }
                break;
        }
    }else{
        switch (indexPath.section) {
            case 0:
            {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FirstTypeCell" forIndexPath:indexPath];
                UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
                UILabel *titlL = (UILabel *)[cell viewWithTag:11];
                UIImageView *line = (UIImageView *)[cell viewWithTag:12];
                if(indexPath.row == 0)
                    imageV.image = [UIImage imageNamed:@"flxx_fangchan_normal.png"];
                else
                    imageV.image = [UIImage imageNamed:@"flxx_zhaopin_normal.png"];
                InfoType *infoType = self.infoTypeArry[indexPath.row];
                titlL.text = infoType.info_type_name;
                line.hidden = YES;
            }
                break;
                
            default:
            {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HouseOrWorkCell" forIndexPath:indexPath];
                InfoType *infoType = self.infoTypeArry[self.selected];
                Info *info = infoType.listinfo[indexPath.row];
                UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
                UILabel *titlL = (UILabel *)[cell viewWithTag:11];
                UILabel *addressL = (UILabel *)[cell viewWithTag:12];
                UILabel *priceL = (UILabel *)[cell viewWithTag:13];
                UILabel *timeL = (UILabel *)[cell viewWithTag:14];
                
                [imageV sd_setImageWithURL:[NSURL URLWithString:info.info_imgs] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
                titlL.text = info.info_title;
                addressL.text = info.info_address;
                
                priceL.text = [NSString stringWithFormat:@"¥%0.0lf",info.info_money];
                NSString *timeStr = [[info.info_addtime componentsSeparatedByString:@" "] firstObject];
                timeL.text = timeStr;
            }
                break;
        }
    }
    
    
        return cell;
}
//cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    InfoType *infoT = self.infoTypeArry[self.selected];
    if(infoT.selectedCount>0&&infoT.selectedCount%2==0){
        switch (indexPath.section) {
            case 0:
            {
                //若果所点击的Cell与前一个所点击的Cell不同，就把前一个所点击的InfoType对象中的selectedCount设置为0，如果相同，就在现有的基础上进行++
                if(self.selected != (int)indexPath.row){
                    InfoType *infoT = self.infoTypeArry[self.selected];
                    infoT.selectedCount = 0;
                    self.selected = (int)indexPath.row;
                    
                }
                InfoType *infoT = self.infoTypeArry[self.selected];
                infoT.selectedCount++;
                [collectionView reloadData];
            }
                break;
            case 1:
            {
                [self performSegueWithIdentifier:@"GoToTypeScroll" sender:self];
            }
                break;
            default:
            {
                InfoType *infoType = self.infoTypeArry[self.selected];
                Info *info = infoType.listinfo[indexPath.row];
                self.info_id = info.info_id;
                [self performSegueWithIdentifier:@"GoToInfoDetail" sender:self];
            }
                break;
        }
    }else{
        switch (indexPath.section) {
            case 0:
            {
                //若果所点击的Cell与前一个所点击的Cell不同，就把前一个所点击的InfoType对象中的selectedCount设置为0，如果相同，就在现有的基础上进行++
                if(self.selected != (int)indexPath.row){
                    InfoType *infoT = self.infoTypeArry[self.selected];
                    infoT.selectedCount = 0;
                    self.selected = (int)indexPath.row;
                    if(self.selected == 0){
                        [self.releaseBtn setTitle:@"免费发布房产信息" forState:UIControlStateNormal];
                    }else{
                        [self.releaseBtn setTitle:@"免费发布招聘信息" forState:UIControlStateNormal];
                    }
                }
                InfoType *infoT = self.infoTypeArry[self.selected];
                infoT.selectedCount++;
                [collectionView reloadData];
            }
                break;
            default:
            {
                InfoType *infoType = self.infoTypeArry[self.selected];
                Info *info = infoType.listinfo[indexPath.row];
                self.info_id = info.info_id;
                [self performSegueWithIdentifier:@"GoToInfoDetail" sender:self];
            }
                break;
        }
    }
    
}
//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    InfoType *infoT = self.infoTypeArry[self.selected];
    if(infoT.selectedCount>0&&infoT.selectedCount%2==0){
        switch (indexPath.section) {
            case 0:
            {
                return CGSizeMake(187, 80);
            }
                break;
            case 1:
            {
                return CGSizeMake(93, 40);
            }
                break;
            default:
            {
                return CGSizeMake(375, 100);
            }
                break;
        }

    }else{
        switch (indexPath.section) {
            case 0:
            {
                return CGSizeMake(187, 80);
            }
                break;
            default:
            {
                return CGSizeMake(375, 100);
            }
                break;
        }

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma button-点击事件
- (IBAction)releaseBtnClick:(UIButton *)sender {
    [self performSegueWithIdentifier:@"ReleaseInfo" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"GoToInfoDetail"]){
        InfoDetailViewController *infoDetailVC = segue.destinationViewController;
        infoDetailVC.info_id = self.info_id;
        infoDetailVC.selected = self.selected;
    }else if([segue.identifier isEqualToString:@"ReleaseInfo"]){
        ReleaseHomeInfoViewController *relesaeVC = segue.destinationViewController;
        relesaeVC.selected = self.selected;
        InfoType *infoType = self.infoTypeArry[self.selected];
        relesaeVC.smallTypeArry = infoType.small_infp_type;
    }else if ([segue.identifier isEqualToString:@"GoToTypeScroll"]){
        InfoTypeScrollViewController *infoTVC = segue.destinationViewController;
        InfoType *infoT = self.infoTypeArry[self.selected];
        infoTVC.smallTypeArry = infoT.small_infp_type;
        infoTVC.selected = self.selected;
    }
}


@end
