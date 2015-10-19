//
//  ApplyCompanyViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/16.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "ApplyCompanyViewController.h"

@interface ApplyCompanyViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tablerView;
@property (nonatomic,strong) NSArray *arry;
@end

@implementation ApplyCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _arry = @[@"店铺名称",@"店铺地址",@"店铺分类",@"店铺小分类",@"联系人",@"联系电话"];
    self.tablerView.tableFooterView = [[UIView alloc] init];
}
#pragma tableView-代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if(indexPath.row == 2||indexPath.row == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
        UILabel *titleL = (UILabel *)[cell viewWithTag:10];
        titleL.text = _arry[indexPath.row];
    }else if(indexPath.row == 6){
        cell = [tableView dequeueReusableCellWithIdentifier:@"lastCell" forIndexPath:indexPath];
        UIButton *btn1 = (UIButton *)[cell viewWithTag:10];
        UIButton *btn2 = (UIButton *)[cell viewWithTag:11];
        
        [btn1 addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 6){
        return 130;
    }else{
        return 44;
    }
}
#pragma button-代理
-(void)selectBtnClick:(UIButton *)button{
    
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
