//
//  TopScrollView.m
//  Buy568
//
//  Created by echo23 on 15/10/17.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "TopScrollView.h"
#import "RootScrollView.h"
#import "smallInfoType.h"
//按钮间隙
#define BUTTONGAP 5
//滑条宽度
//#define CONTENTSIZEX ScreenWidth


@implementation TopScrollView

+ (TopScrollView *)shareInstance {
    static TopScrollView *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[self alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 44)];
    });
    return _instance;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        _userSelectBtnID = 100;
        _scrollViewSelectedChannelID = 100;
        self.buttonOriginXArray = [NSMutableArray array];
        self.buttonWithArray = [NSMutableArray array];
        
    }
    return self;
}

-(void)initWithTitleButtons{
    float xPos = 5.0;
    for(int i = 0;i < self.smallTypeArry.count; i++){
        smallInfoType *smallT = self.smallTypeArry[i];
        UIButton *btn = (UIButton *)[self viewWithTag:100+i];
        [btn removeFromSuperview];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        if(i == 0)
            button.selected = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [button setTitle:smallT.info_type_name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        int buttonWidth = [smallT.info_type_name sizeWithFont:button.titleLabel.font constrainedToSize:CGSizeMake(150, 30) lineBreakMode:NSLineBreakByClipping].width;
        button.frame = CGRectMake(xPos, 9, buttonWidth+BUTTONGAP, 30);
        [_buttonOriginXArray addObject:@(xPos)];
        xPos += buttonWidth+BUTTONGAP;
        [_buttonWithArray addObject:@(button.frame.size.width)];
        [self addSubview:button];
    }
    self.contentSize = CGSizeMake(xPos, 44);
    
    _shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(BUTTONGAP, 0, [_buttonWithArray[0] floatValue], 44)];
    _shadowImageView.image = [UIImage imageNamed:@"red_line_and_shadow.png"];
    [self addSubview:_shadowImageView];
}

//点击Button事件
-(void)selectTitleButton:(UIButton *)sender{
    [self adjustScrollViewContentX:sender];
    
    //如果更换按钮
    if(sender.tag != _userSelectBtnID){
        //取上一个所点击的按钮
        UIButton *lastButton = (UIButton *)[self viewWithTag:_userSelectBtnID];
        lastButton.selected = NO;
        //赋值按钮ID
        _userSelectBtnID = (int)sender.tag;
    }
    
    //按钮从未被选中到选中状态
    if(!sender.selected){
        sender.selected = YES;
        [UIView animateWithDuration:0.25 animations:^{
            [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 0, [_buttonWithArray[sender.tag-100] floatValue], 44)];
        } completion:^(BOOL finished) {
            if(finished){
                //设置rootView出现
                [[RootScrollView shareInstance] setContentOffset:CGPointMake((sender.tag-100)*ScreenWidth, 0) animated:YES];
                [RootScrollView shareInstance].selected = self.selected;
                [RootScrollView shareInstance].smallTypeArry = self.smallTypeArry;
                //赋值滑动列表选择频道ID
                _scrollViewSelectedChannelID = (int)sender.tag;
            }
        }];
    //重复点击已选中按钮不作任何操作
    }else{
        
    }
}


- (void)adjustScrollViewContentX:(UIButton *)sender
{
    float originX = [[_buttonOriginXArray objectAtIndex:sender.tag-100] floatValue];
    float width = [[_buttonWithArray objectAtIndex:sender.tag-100] floatValue];
    
    if (sender.frame.origin.x - self.contentOffset.x > ScreenWidth-(BUTTONGAP+width)) {
        [self setContentOffset:CGPointMake(originX - 30, 0)  animated:YES];
    }
    
    if (sender.frame.origin.x - self.contentOffset.x < 5) {
        [self setContentOffset:CGPointMake(originX,0)  animated:YES];
    }
}

//滚动内容页顶部滚动
- (void)setButtonUnSelect
{
    //滑动撤销选中按钮
    UIButton *lastButton = (UIButton *)[self viewWithTag:_scrollViewSelectedChannelID];
    lastButton.selected = NO;
}

-(void)setButtonSelect{
    //滑动选中按钮
    UIButton *button = (UIButton *)[self viewWithTag:_scrollViewSelectedChannelID];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [_shadowImageView setFrame:CGRectMake(button.frame.origin.x, 0, [[_buttonWithArray objectAtIndex:button.tag-100] floatValue], 44)];
        
    } completion:^(BOOL finished) {
        if (finished) {
            if (!button.selected) {
                button.selected = YES;
                _userSelectBtnID = (int)button.tag;
            }
        }
    }];

}

-(void)setScrollViewContentOffset
{
    float originX = [[_buttonOriginXArray objectAtIndex:_scrollViewSelectedChannelID] floatValue];
    float width = [[_buttonWithArray objectAtIndex:_scrollViewSelectedChannelID] floatValue];
    
    if (originX - self.contentOffset.x > ScreenWidth-(BUTTONGAP+width)) {
        [self setContentOffset:CGPointMake(originX - 30, 0)  animated:YES];
    }
    
    if (originX - self.contentOffset.x < 5) {
        [self setContentOffset:CGPointMake(originX,0)  animated:YES];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
