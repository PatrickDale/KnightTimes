//
//  TeamStoryListViewController.h
//  KnightTimes
//
//  Created by Pat Dale on 5/27/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"
#import "Story.h"

@interface TeamStoryListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView;
}

@property (nonatomic, retain) UITableView *tableView;
-(id) loadTableWithURL:(NSString *) urlString withSport:(NSString *)sport;

@end
