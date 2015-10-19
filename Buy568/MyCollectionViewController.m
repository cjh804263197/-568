//
//  MyCollectionViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/14.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "GoodService.h"
#import "Collection.h"

@interface MyCollectionViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) GoodService *goodS;
@property (nonatomic,strong) NSArray *collectionArry;
@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.goodS = [[GoodService alloc] init];
    self.collectionArry = [NSArray array];
    __weak typeof(self) MySelf = self;
    [self.goodS getMyCollectionList:self.user_id success:^(NSArray *collectionList) {
        MySelf.collectionArry = collectionList;
        [MySelf.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    self.tableView.tableFooterView = [[UIView alloc] init];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.collectionArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectionCell" forIndexPath:indexPath];
    Collection *collection = self.collectionArry[indexPath.row];
    UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
    UILabel *titleL = (UILabel *)[cell viewWithTag:11];
    UILabel *priceL = (UILabel *)[cell viewWithTag:12];
    UIButton *button = (UIButton *)[cell viewWithTag:13];
    
    [imageV sd_setImageWithURL:[NSURL URLWithString:collection.goods_imgs] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
    titleL.text = collection.goods_name;
    
    priceL.text = [NSString stringWithFormat:@"¥%0.0lf",collection.goods_price];
    
    button.layer.borderColor = [UIColor blueColor].CGColor;
    button.layer.borderWidth = 1.0;
    [button addTarget:self action:@selector(cancelCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

#pragma button-点击事件
//取消收藏按钮点击事件
-(void)cancelCollectionBtn:(UIButton *)button{
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    Collection *colletion = self.collectionArry[index.row];
    __weak typeof(self) MySelf = self;
    [self.goodS cancelCollection:colletion.collect_id success:^(BOOL isSuccess, NSString *content) {
        if(isSuccess){
            NSLog(@"%@",content);
            [MySelf.goodS getMyCollectionList:MySelf.user_id success:^(NSArray *collectionList) {
                MySelf.collectionArry = collectionList;
                [MySelf.tableView reloadData];
                [SVProgressHUD dismiss];
            }];
        }else{
            NSLog(@"%@",content);
        }
        [SVProgressHUD dismiss];
    }];
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
