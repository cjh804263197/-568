//
//  TabBarViewController.m
//  Buy568
//
//  Created by echo23 on 15/9/25.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "TabBarViewController.h"
#import "CompanyService.h"
#import "Company.h"
@interface TabBarViewController ()
@property (nonatomic,strong) UIImageView *imageV;
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addWelcomView];
}
-(void)addWelcomView{
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _imageV.image = [UIImage imageNamed:@"w1.jpg"];
    [self.view addSubview:_imageV];
    CompanyService *companySeivice = [[CompanyService alloc] init];
    __weak typeof(self) MySelf = self;
    [companySeivice getADCompanyObject:2 success:^(Company *company) {
        //加载从服务器上获取到的图片
        [MySelf.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerURL,company.company_ad]] placeholderImage:[UIImage imageNamed:@"w1.jpg"]];
    }];
    //设置一个延迟时间为2.5的线程
    double delayInSeconds = 2.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        //2.5秒后执行动画
        [UIView animateWithDuration:0.4 animations:^{
            //动画的内容是将imageV的中心由（375/2.0, 667.0/2.0）移动到(-375/2.0, 667.0/2.0)
            MySelf.imageV.center = CGPointMake(-375/2.0, 667.0/2.0);
        } completion:^(BOOL finished) {
            //当动画完成时，将imageV从父视图上移除
            [MySelf.imageV removeFromSuperview];
        }];
    });
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
