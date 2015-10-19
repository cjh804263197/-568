//
//  ConfirmOrderViewController.h
//  Buy568
//
//  Created by echo23 on 15/10/8.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
#import "User.h"

@interface ConfirmOrderViewController : UIViewController
@property (nonatomic,strong) User *user;
@property (nonatomic,strong) NSArray *cartArry;
@end
