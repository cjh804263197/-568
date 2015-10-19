//
//  WelcomeViewController.m
//  Buy568
//  第一次安装欢迎界面
//  Created by echo23 on 15/9/25.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "WelcomeViewController.h"
#import "TabBarViewController.h"
@interface WelcomeViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollV;
@property (nonatomic,strong) UIPageControl *pageC;
@property (nonatomic,strong) NSArray *IMGArry;//存放欢迎图片的数组
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _IMGArry = @[@"w1.jpg",@"w2.jpg",@"w3.jpg"];//将图片存到数组中
    [self addContentView];
}
//主视图
-(void)addContentView{
    //添加UIScrollerView
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];//初始化一个scrollview
    _scrollV.delegate = self;//为scrollview添加代理
    _scrollV.pagingEnabled = YES;//设置scrollview为整页滚动
    _scrollV.showsHorizontalScrollIndicator = NO;//设置scrollview的水平滚动条消失
    _scrollV.showsVerticalScrollIndicator = NO;//设置scrollview的垂直滚动条消失
    [self.view addSubview:_scrollV];
    [_scrollV setContentSize:CGSizeMake(ScreenWidth*_IMGArry.count, ScreenHeight)];//设置scrollerview的contentsize
    //将图片加载到scrollview上
    for(int i = 0; i < _IMGArry.count; i++){
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight)];
        imageV.image = [UIImage imageNamed:_IMGArry[i]];
        [_scrollV addSubview:imageV];
    }
    //将点击进入的Button添加到scrollerview的最后一张图片上
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((_IMGArry.count-1)*ScreenWidth+92.5, 543, 190, 48);
    [button setImage:[UIImage imageNamed:@"scr_button_jr.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(intoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollV addSubview:button];
    
    //添加UIPageControl
    _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(137.5, 600, 100, 60)];
    _pageC.currentPage = 0;//设置当前页数为0
    _pageC.numberOfPages = _IMGArry.count;//设置总页数
    [_pageC addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageC];
}
#pragma ScrollView-代理
//结束滚动触发的代理事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageC.currentPage = page;
}
//点击进入Button点击事件
-(void)intoBtnClick:(UIButton *)button{
    //先获取到storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //再获取到storyboard上的TabBarViewController
    TabBarViewController *tabVC = [storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
  
    [self presentViewController:tabVC animated:YES completion:^{
        
    }];
}
//点击pageControl事件
-(void)pageChange:(UIPageControl *)page{
    CGSize scrollSize = _scrollV.frame.size;
    CGRect rect = CGRectMake(page.currentPage*scrollSize.width, 0, scrollSize.width, scrollSize.height);
    [_scrollV scrollRectToVisible:rect animated:YES];
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
