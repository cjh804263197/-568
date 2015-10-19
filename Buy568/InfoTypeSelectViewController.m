//
//  InfoTypeSelectViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/16.
//  Copyright (c) 2015年 echo. All rights reserved.
//selectType

#import "InfoTypeSelectViewController.h"
#import "smallInfoType.h"

@interface InfoTypeSelectViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation InfoTypeSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.layer.cornerRadius = 5.0;
}
#pragma tableView-代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.smallTypeArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"typeCell" forIndexPath:indexPath];
    UILabel *typeL = (UILabel *)[cell viewWithTag:10];
    smallInfoType *smallT = self.smallTypeArry[indexPath.row];
    typeL.text = smallT.info_type_name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    smallInfoType *smallT = self.smallTypeArry[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectType" object:smallT userInfo:nil];
    [self.view removeFromSuperview];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view removeFromSuperview];
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
