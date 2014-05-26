//
//  RootViewController.h
//  KnightTime
//
//  Created by Pat Dale on 5/25/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> { 
    UITableView *tableView;
    NSArray *theArray;
}

@property (nonatomic, retain) UITableView *tableView;

@end
