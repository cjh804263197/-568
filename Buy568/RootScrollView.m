//
//  RootScrollView.m
//  Buy568
//
//  Created by echo23 on 15/10/17.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "RootScrollView.h"
#import "InfoTableViewController.h"
#import "TopScrollView.h"

@implementation RootScrollView

+ (RootScrollView *)shareInstance {
    static RootScrollView *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[self alloc] initWithFrame:CGRectMake(0, 108, ScreenWidth, ScreenHeight-108)];
    });
    return _instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor lightGrayColor];
        self.pagingEnabled = YES;
        self.userInteractionEnabled = YES;
        self.bounces = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        _userContentOffsetX = 0;
    }
    return self;
}

-(void)initWithViews{
    self.tableVCArry = [NSMutableArray array];
    for(int i = 0;i < self.smallTypeArry.count;i++){
        UIStoryboard *storyB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        InfoTableViewController *infoTbaleViewVC = [storyB instantiateViewControllerWithIdentifier:@"InfoTableViewController"];
        infoTbaleViewVC.tableView.frame = CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight-108);
        infoTbaleViewVC.tableView.tag = 200+i;
        if(i == 0){
            infoTbaleViewVC.smallT = self.smallTypeArry[i];
            infoTbaleViewVC.selected = self.selected;
        }
        [self addSubview:infoTbaleViewVC.tableView];
        [self.tableVCArry addObject:infoTbaleViewVC];
    }
    self.contentSize = CGSizeMake(ScreenWidth*self.smallTypeArry.count, ScreenHeight-108);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _userContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_userContentOffsetX < scrollView.contentOffset.x) {
        _isLeftScroll = YES;
    }
    else {
        _isLeftScroll = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //调整顶部滑条按钮状态
    [self adjustTopScrollViewButton:scrollView];
    
    [self loadData];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self loadData];
}

-(void)loadData
{
    CGFloat pagewidth = self.frame.size.width;
    int page = floor((self.contentOffset.x - pagewidth/self.smallTypeArry.count)/pagewidth)+1;
    InfoTableViewController *infoVC = self.tableVCArry[page];
    infoVC.smallT = self.smallTypeArry[page];
    infoVC.selected = self.selected;
}
//滚动后修改顶部滚动条
- (void)adjustTopScrollViewButton:(UIScrollView *)scrollView
{
    [[TopScrollView shareInstance] setButtonUnSelect];
    [TopScrollView shareInstance].selected = self.selected;
    [TopScrollView shareInstance].scrollViewSelectedChannelID = scrollView.contentOffset.x/ScreenWidth+100;
    [[TopScrollView shareInstance] setButtonSelect];
    [[TopScrollView shareInstance] setScrollViewContentOffset];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
