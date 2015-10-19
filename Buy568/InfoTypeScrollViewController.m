//
//  InfoTypeScrollViewController.m
//  Buy568
//
//  Created by echo23 on 15/10/17.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "InfoTypeScrollViewController.h"
#import "TopScrollView.h"
#import "RootScrollView.h"

@interface InfoTypeScrollViewController ()

@end

@implementation InfoTypeScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *topShadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320, 5)];
    [topShadowImageView setImage:[UIImage imageNamed:@"top_background_shadow.png"]];
    [self.view addSubview:topShadowImageView];
    
    TopScrollView *topV = [TopScrollView shareInstance];
    RootScrollView *rootV = [RootScrollView shareInstance];
    
    topV.smallTypeArry = self.smallTypeArry;
    rootV.smallTypeArry = self.smallTypeArry;
    
    [self.view addSubview:topV];
    [self.view addSubview:rootV];
    
    [topV initWithTitleButtons];
    [rootV initWithViews];
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
