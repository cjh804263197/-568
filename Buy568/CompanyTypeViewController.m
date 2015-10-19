//
//  CompanyTypeViewController.m
//  Buy568
//  分类列表界面
//  Created by echo23 on 15/9/28.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "CompanyTypeViewController.h"
#import "CompanyDetailInfoViewController.h"

@interface CompanyTypeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) int company_id;//用来存放Button点击对象中的company_id
@end

@implementation CompanyTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma tableView-代理
//设置块数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.companyType.small_company_type.count;
}
//设置块内行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SmallCompanyType *smallCT = self.companyType.small_company_type[section];
    if(smallCT.company.count != 0)
        return 2;
    else
        return 1;
}
//返回Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SmallCompanyType *smallCT = self.companyType.small_company_type[indexPath.section];
    if(indexPath.row == 0){
        UITableViewCell *typeCell = [tableView dequeueReusableCellWithIdentifier:@"smallCompanyTypeCell" forIndexPath:indexPath];
        UILabel *typeL = (UILabel *)[typeCell viewWithTag:50];
        typeL.text = smallCT.company_type_name;
        return typeCell;
    }else{
        UITableViewCell *comCell = [tableView dequeueReusableCellWithIdentifier:@"CompanyCell" forIndexPath:indexPath];
        //storyboard 解决Cell复用问题
        for(UIButton *button in comCell.contentView.subviews){
            if(button.tag == 60||button.tag == 61||button.tag == 62){
                [button setTitle:@"" forState:UIControlStateNormal];
            }
        }
        NSArray *comArry = smallCT.company;
        for(int i = 0 ;i < comArry.count;i++){
            Company *com = comArry[i];
            UIButton *button = (UIButton *)[comCell viewWithTag:60+i];
            [button setTitle:com.company_name forState:UIControlStateNormal];
            [button addTarget:self action:@selector(companyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        return comCell;
    }
    
}
//设置section headview高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}

#pragma button-点击事件
-(void)companyBtnClick:(UIButton *)button{
    UITableViewCell *cell = (UITableViewCell *)button.superview.superview;
    NSIndexPath *index = [_tableView indexPathForCell:cell];
    SmallCompanyType *smallT = self.companyType.small_company_type[index.section];
    Company *com = smallT.company[button.tag-60];
    //触发连线器
    self.company_id = com.company_id;
    [self performSegueWithIdentifier:@"companyTypeForCompanyDetailID" sender:self];
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
    if([segue.identifier isEqualToString:@"companyTypeForCompanyDetailID"]){
        CompanyDetailInfoViewController *companyDetailInfoVC = segue.destinationViewController;
        companyDetailInfoVC.company_id = self.company_id;
    }
}


@end
