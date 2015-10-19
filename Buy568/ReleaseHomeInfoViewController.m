//
//  ReleaseHomeInfoViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/10.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "ReleaseHomeInfoViewController.h"
#import "AddPictureCollectionViewCell.h"
#import "smallInfoType.h"
#import "InfoTypeSelectViewController.h"
#import "InfoService.h"
#import "InfoConfigViewController.h"

@interface ReleaseHomeInfoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *titleHomeArry;
@property (nonatomic,strong) NSArray *titleJobArry;
@property (nonatomic,strong) NSMutableArray *imgArry;
@property (nonatomic,strong) UICollectionView *collectionV;
@property (nonatomic,strong) smallInfoType *selectType;
@property (nonatomic,strong) NSArray *configArry;
@property (nonatomic,strong) NSArray *selectedConfigArry;//已选择的配置/福利数组
//@property (nonatomic,strong) UIView *footerV;
@end

@implementation ReleaseHomeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectedConfigArry = [NSArray array];
    self.titleHomeArry = @[@"分类",@"标题",@"价格",@"地址",@"配置",@"房屋说明",@"联系人",@"手机号"];
    self.titleJobArry = @[@"分类",@"标题",@"职位",@"招聘人数",@"薪资",@"福利",@"公司名称",@"公司地址",@"公司简介",@"联系人",@"手机号"];
    self.imgArry = [NSMutableArray array];
    [self.imgArry addObject:[UIImage imageNamed:@"addpic@2x.png"]];
    [self addTableViewFooterView];
    if(self.selected == 1){
        self.title = @"招聘信息发布";
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectType:) name:@"selectType" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectConfig:) name:@"config" object:nil];
}
//类别选择通知事件
-(void)selectType:(NSNotification *)notification{
    self.selectType = [notification object];
    if(self.selected == 0){
        self.titleHomeArry = @[self.selectType.info_type_name,@"标题",@"价格",@"地址",@"配置",@"房屋说明",@"联系人",@"手机号"];
    }else{
        self.titleJobArry = @[self.selectType.info_type_name,@"标题",@"职位",@"招聘人数",@"薪资",@"福利",@"公司名称",@"公司地址",@"公司简介",@"联系人",@"手机号"];
    }
    [self.tableView reloadData];
}
//配置选择通知事件
-(void)SelectConfig:(NSNotification *)notification{
    self.selectedConfigArry = [notification object];
    [self.tableView reloadData];
}
//加载tableview的footerView
-(void)addTableViewFooterView{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.8)];
    footerV.backgroundColor = [UIColor whiteColor];
    //创建一个UICollectionView流布局
    UICollectionViewFlowLayout *cvf = [[UICollectionViewFlowLayout alloc] init];
    //创建一个UICollectionView
    _collectionV = [[UICollectionView alloc] initWithFrame:footerV.bounds collectionViewLayout:cvf];
    _collectionV.backgroundColor = [UIColor clearColor];
    [_collectionV registerClass:[AddPictureCollectionViewCell class] forCellWithReuseIdentifier:@"PictureCell"];
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    [footerV addSubview:_collectionV];
    
    self.tableView.tableFooterView = footerV;
}
#pragma tableView-代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.selected == 0){
        return 8;
    }else{
        return 11;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    switch (self.selected) {
        case 0:
        {
            if(indexPath.row==0){
                cell = [tableView dequeueReusableCellWithIdentifier:@"OneCell" forIndexPath:indexPath];
                UILabel *titleL = (UILabel *)[cell viewWithTag:10];
                
                titleL.text = self.titleHomeArry[indexPath.row];
            }else if (indexPath.row==4){
                cell = [tableView dequeueReusableCellWithIdentifier:@"OneCell" forIndexPath:indexPath];
                UILabel *titleL = (UILabel *)[cell viewWithTag:10];
                
                titleL.text = self.titleHomeArry[indexPath.row];
                
                for(int i =20;i < self.selectedConfigArry.count+20;i++){
                    UIButton *btn = (UIButton *)[cell viewWithTag:i];
                    btn.hidden = NO;
                    [btn setTitle:self.selectedConfigArry[i-20] forState:UIControlStateNormal];
                }
            }else if (indexPath.row == 2) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"TwoCell" forIndexPath:indexPath];
                UITextField *TF = (UITextField *)[cell viewWithTag:10];
                TF.placeholder = self.titleHomeArry[indexPath.row];
            }else{
                cell = [tableView dequeueReusableCellWithIdentifier:@"ThreeCell" forIndexPath:indexPath];
                UITextField *TF = (UITextField *)[cell viewWithTag:10];
                TF.placeholder = self.titleHomeArry[indexPath.row];
            }
        }
            break;
            
        default:
        {
            if(indexPath.row==0){
                cell = [tableView dequeueReusableCellWithIdentifier:@"OneCell" forIndexPath:indexPath];
                UILabel *titleL = (UILabel *)[cell viewWithTag:10];
                
                titleL.text = self.titleJobArry[indexPath.row];
            }else if (indexPath.row == 5){
                cell = [tableView dequeueReusableCellWithIdentifier:@"OneCell" forIndexPath:indexPath];
                UILabel *titleL = (UILabel *)[cell viewWithTag:10];
                
                titleL.text = self.titleJobArry[indexPath.row];
                for(int i =20;i < self.selectedConfigArry.count+20;i++){
                    UIButton *btn = (UIButton *)[cell viewWithTag:i];
                    btn.hidden = NO;
                    [btn setTitle:self.selectedConfigArry[i-20] forState:UIControlStateNormal];
                }
            }else if (indexPath.row == 4) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"TwoCell" forIndexPath:indexPath];
                UITextField *TF = (UITextField *)[cell viewWithTag:10];
                TF.placeholder = self.titleJobArry[indexPath.row];
            }else{
                cell = [tableView dequeueReusableCellWithIdentifier:@"ThreeCell" forIndexPath:indexPath];
                UITextField *TF = (UITextField *)[cell viewWithTag:10];
                TF.placeholder = self.titleJobArry[indexPath.row];
            }
        }
            break;
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        InfoTypeSelectViewController *infoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoTypeSelectViewController"];
        infoVC.smallTypeArry = self.smallTypeArry;
        [self addChildViewController:infoVC];
        [self.view addSubview:infoVC.view];
    }
    if(self.selected == 0){
        if(indexPath.row == 4){
            if(self.selectType == nil){
                NSLog(@"请选择类别");
            }else{
                InfoService *infoS = [[InfoService alloc] init];
                __weak typeof(self) MySelf = self;
                [infoS getInfoConfig:self.selectType.info_type_pid InfoTypeID:self.selectType.info_type_id success:^(NSArray *configArry) {
                    MySelf.configArry = configArry;
                    [MySelf performSegueWithIdentifier:@"GoToSelectInfoConfig" sender:self];
                    [SVProgressHUD dismiss];
                }];
            }
        }
    }else{
        if(indexPath.row == 5){
            if(self.selectType == nil){
                NSLog(@"请选择类别");
            }else{
                InfoService *infoS = [[InfoService alloc] init];
                __weak typeof(self) MySelf = self;
                [infoS getInfoConfig:self.selectType.info_type_pid InfoTypeID:self.selectType.info_type_id success:^(NSArray *configArry) {
                    MySelf.configArry = configArry;
                    [MySelf performSegueWithIdentifier:@"GoToSelectInfoConfig" sender:self];
                    [SVProgressHUD dismiss];
                }];
            }
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.selected) {
        case 0:
        {
            if(indexPath.row == 4){
                int count = (int)self.selectedConfigArry.count;
                if(count == 0){
                    return 44;
                }else if (count>0&&count<=3){
                    return 66;
                }else if (count>3&&count<=6){
                    return 96;
                }else{
                    return 126;
                }
            }else{
                return 44;
            }
        }
            break;
            
        default:
        {
            if(indexPath.row == 5){
                int count = (int)self.selectedConfigArry.count;
                if(count == 0){
                    return 44;
                }else if (count>0&&count<=3){
                    return 66;
                }else if (count>3&&count<=6){
                    return 96;
                }else{
                    return 126;
                }
            }else{
                return 44;
            }
        }
            break;
    }
}
#pragma  collectionView-代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgArry.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AddPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PictureCell" forIndexPath:indexPath];
    UIImage *image = self.imgArry[indexPath.row];
    UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
    imageV.image = image;
    return cell;
}
//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(105, 105);
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 7.5;
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 7.5;
}
//cell section块的位置
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 15, 15);
   }
//点击选择
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == self.imgArry.count-1){
        UIActionSheet *sheet = nil;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册选择" otherButtonTitles:@"拍照", nil];
        }else{
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册选择" otherButtonTitles:nil, nil];
        }
        [sheet showInView:self.view];
    }
    
}

#pragma actionSheet-代理
//为actionsheet添加点击事件
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSInteger type = 0;
    if(actionSheet.numberOfButtons == 3){
        if(buttonIndex == 0){
            type = UIImagePickerControllerSourceTypePhotoLibrary;
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            imgPicker.delegate = self;
            imgPicker.sourceType = type;
            [self presentViewController:imgPicker animated:YES completion:^{
            }];
        }
        else if(buttonIndex == 1){
            type = UIImagePickerControllerSourceTypeCamera;
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            imgPicker.delegate = self;
            imgPicker.sourceType = type;
            [self presentViewController:imgPicker animated:YES completion:^{
            }];
        }
        else{
        }
    }else{
        if(buttonIndex == 0){
            type = UIImagePickerControllerSourceTypePhotoLibrary;
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            imgPicker.delegate = self;
            imgPicker.sourceType = type;
            [self presentViewController:imgPicker animated:YES completion:^{
            }];
        }
        else{
        }
    }
    
}


#pragma UIImagePickerController-代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self.imgArry insertObject:info[UIImagePickerControllerOriginalImage] atIndex:0];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.collectionV reloadData];
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
    if([segue.identifier isEqualToString:@"GoToSelectInfoConfig"]){
        InfoConfigViewController *infoConfigVC = segue.destinationViewController;
        infoConfigVC.configArry = self.configArry;
        infoConfigVC.selected = self.selected;
    }
}


@end
