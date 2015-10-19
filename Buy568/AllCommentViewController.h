//
//  AllCommentViewController.h
//  Buy568
//  查看所有评论VC
//  Created by echo23 on 15/10/5.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

@interface AllCommentViewController : UIViewController
/**
 店铺评论（从店铺详情界面传过来）
 */
@property (nonatomic,strong) NSArray *company_comment;
@end
