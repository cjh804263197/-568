//
//  SettingViewController.h
//  Buy568
//
//  Created by echo23 on 15/10/13.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface SettingViewController : UIViewController
@property (nonatomic,assign) int row;
@property (nonatomic,strong) User *user;
@property (nonatomic,strong) NSArray *titleArry;
@end
