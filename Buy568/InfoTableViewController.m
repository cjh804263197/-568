//
//  InfoTableViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/17.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "InfoTableViewController.h"
#import "Info.h"
#import "InfoService.h"
#import "InfoDetailViewController.h"

@interface InfoTableViewController ()
@property (nonatomic,strong) NSArray *infoArry;
@end

@implementation InfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.infoArry = [NSArray array];
    InfoService *infoS = [[InfoService alloc] init];
    __weak typeof(self) MySelf = self;
    [infoS getTypeInfoList:self.smallT.info_type_pid InfoTypeID:self.smallT.info_type_id CityID:2 PageNum:1 PageSize:10 success:^(NSArray *infoArry) {
        MySelf.infoArry = infoArry;
        [MySelf.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.infoArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
    Info *info = self.infoArry[indexPath.row];
    UIImageView *imageV = (UIImageView *)[cell viewWithTag:10];
    UILabel *titleL = (UILabel *)[cell viewWithTag:11];
    UILabel *adressL = (UILabel *)[cell viewWithTag:12];
    UILabel *priceL = (UILabel *)[cell viewWithTag:13];
    UILabel *timeL = (UILabel *)[cell viewWithTag:14];
    
    [imageV sd_setImageWithURL:[NSURL URLWithString:info.info_imgs] placeholderImage:[UIImage imageNamed:@"net_error_icon.png"]];
    
    titleL.text = info.info_title;
    
    adressL.text = info.info_address;
    
    
    priceL.text = [NSString stringWithFormat:@"¥%0.0lf",info.info_money];
    
    timeL.text = info.info_addtime;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Info *info = self.infoArry[indexPath.row];
    InfoDetailViewController *infoDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoDetailViewController"];
    infoDetailVC.info_id = info.info_id;
    infoDetailVC.selected = self.selected;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
