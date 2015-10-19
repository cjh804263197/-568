//
//  RootScrollView.h
//  Buy568
//
//  Created by echo23 on 15/10/17.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmallCompanyType.h"

@interface RootScrollView : UIScrollView <UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *smallTypeArry;
@property (nonatomic,assign) int userSelectBtnID;
@property (nonatomic,assign) CGFloat userContentOffsetX;
@property (nonatomic,assign) BOOL isLeftScroll;
@property (nonatomic,assign) int selected;
@property (nonatomic,strong) NSMutableArray *tableVCArry;

+ (RootScrollView *)shareInstance;

- (void)initWithViews;
/**
 *  加载主要内容
 */
- (void)loadData;
@end
