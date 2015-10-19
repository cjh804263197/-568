//
//  EditGoodsNumberViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/15.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "EditGoodsNumberViewController.h"
#import "GoodService.h"

@interface EditGoodsNumberViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numL;
@end

@implementation EditGoodsNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.numL.text = [NSString stringWithFormat:@"%d",self.cart.goods_number];
}
//加减按钮事件
- (IBAction)opBtnClick:(UIButton *)sender {
//    if([self.numL.text intValue]>1&&[self.numL.text intValue]<self.cart.goods_number){
        switch (sender.tag) {
            case 10:
            {
                if ([self.numL.text intValue]>1) {
                    int num = [self.numL.text intValue];
                    num --;
                    self.numL.text = [NSString stringWithFormat:@"%d",num];
                }else{
                    [sender setBackgroundImage:[UIImage imageNamed:@"jian_gray.png"] forState:UIControlStateNormal];
                }
            }
                break;
                
            default:
            {
                if([self.numL.text intValue]<99){
                    int num = [self.numL.text intValue];
                    num ++;
                    self.numL.text = [NSString stringWithFormat:@"%d",num];
                }else{
                    [sender setBackgroundImage:[UIImage imageNamed:@"plus_gray.png"] forState:UIControlStateNormal];
                }
            }
                break;
        }
    //}
}
//确定按钮事件
- (IBAction)sureBtnClick:(UIButton *)sender {
    GoodService *goodS = [[GoodService alloc] init];
    [goodS editCartGoodsNumber:self.cart.goods_id GoodsNumber:[self.numL.text intValue] userID:self.cart.user_id success:^(BOOL isSuccess) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"edit" object:[NSString stringWithFormat:@"%d",isSuccess]];
        [self.view removeFromSuperview];
    }];
    
    
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
