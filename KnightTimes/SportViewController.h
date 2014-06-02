//
//  SportViewController.h
//  KnightTimes
//
//  Created by Pat Dale on 5/27/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamStoryListViewController.h"

@interface SportViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView;
    NSDictionary *sportsInfo;
}

@property (strong, nonatomic) IBOutlet UIView *sportView;

@end
