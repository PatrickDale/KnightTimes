//
//  ListViewController.h
//  KnightTime
//
//  Created by Pat Dale on 5/25/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"
#import "Story.h"

@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView;
}

@property (nonatomic, retain) UITableView *tableView;

- (IBAction)returnToTeamStories:(id)sender;
-(id) loadTableWithURL:(NSString *) urlString;

@end
