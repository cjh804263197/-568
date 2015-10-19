//
//  InfoConfigViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/16.
//  Copyright (c) 2015年 echo. All rights reserved.
//configCell

#import "InfoConfigViewController.h"

@interface InfoConfigViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *isSelectedArry;
@end

@implementation InfoConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.selected == 1){
        self.title = @"选择福利配置";
    }
    self.isSelectedArry = [[NSMutableArray alloc] init];
    for(int i = 0;i<self.configArry.count;i++){
        [self.isSelectedArry addObject:@"0"];
    }
}
#pragma tableView-代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.configArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"configCell" forIndexPath:indexPath];
    UILabel *titleL = (UILabel *)[cell viewWithTag:10];
    UIButton *selectBtn = (UIButton *)[cell viewWithTag:11];
    titleL.text = self.configArry[indexPath.row];
    if([_isSelectedArry[indexPath.row] intValue] == 0){
        selectBtn.selected = NO;
    }else{
        selectBtn.selected = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([_isSelectedArry[indexPath.row] intValue] == 0){
        [_isSelectedArry removeObjectAtIndex:indexPath.row];
        [_isSelectedArry insertObject:@"1" atIndex:indexPath.row];
        [tableView reloadData];
        
    }else{
        [_isSelectedArry removeObjectAtIndex:indexPath.row];
        [_isSelectedArry insertObject:@"0" atIndex:indexPath.row];
        [tableView reloadData];
    }
}

#pragma button-点击事件
- (IBAction)sureBtnClick:(UIButton *)sender {
    NSMutableArray *configArr = [NSMutableArray array];
    for(int i = 0;i < _isSelectedArry.count;i++){
        if([_isSelectedArry[i] intValue] == 1){
            [configArr addObject:self.configArry[i]];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"config" object:configArr userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
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
