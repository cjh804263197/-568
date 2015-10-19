//
//  InfoTableViewController.h
//  Buy568
//
//  Created by echo23 on 15/10/17.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "smallInfoType.h"

@interface InfoTableViewController : UITableViewController
@property (nonatomic,strong) smallInfoType *smallT;
@property (nonatomic,assign) int selected;
@end
