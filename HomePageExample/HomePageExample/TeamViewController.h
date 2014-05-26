//
//  TeamViewController.h
//  KnightTime
//
//  Created by Pat Dale on 5/22/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"

@interface TeamViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView;
    NSDictionary *sportsInfo;
}

- (IBAction)returnToTeamList:(id)sender;
@property (nonatomic, retain) UITableView *tableView;




@end
