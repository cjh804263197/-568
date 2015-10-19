//
//  TopScrollView.h
//  Buy568
//
//  Created by echo23 on 15/10/17.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopScrollView : UIScrollView <UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *smallTypeArry;//接受smallType的数组
@property (nonatomic,assign) int scrollViewSelectedChannelID;//接受rootScrollView传过来的id
@property (nonatomic,assign) int userSelectBtnID;//用户点击Button的ID
@property (nonatomic,strong) NSMutableArray *buttonOriginXArray;
@property (nonatomic,strong) NSMutableArray *buttonWithArray;
@property (nonatomic,strong) UIImageView *shadowImageView;
@property (nonatomic,assign) int selected;

+ (TopScrollView *)shareInstance;
/**
 *  加载顶部标签
 */
-(void)initWithTitleButtons;
/**
 *  滑动撤销选中按钮
 */
- (void)setButtonUnSelect;
/**
 *  滑动选择按钮
 */
- (void)setButtonSelect;
/**
 *  滑动顶部标签位置适应
 */
-(void)setScrollViewContentOffset;
@end
