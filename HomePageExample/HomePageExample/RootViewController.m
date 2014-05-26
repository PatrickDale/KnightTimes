//
//  RootViewController.m
//  KnightTime
//
//  Created by Pat Dale on 5/25/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize tableView;

- (void) createData {
    NSArray *sportTeams = [NSArray arrayWithObjects:@"Baseball",@"(M) Basketball",@"(W) Basketball",@"(M) Cross Country",@"(W) Cross Country",@"Football",@"(M) Golf",@"(W) Golf",@"(M) Soccer",@"(W) Soccer",@"Softball",@"(M) Swimming and Diving",@"(W) Swimming and Diving",@"(M) Tennis",@"(W) Tennis",@"(M) Track and Field",@"(W) Track and Field",@"Volleyball", nil];
    theArray = sportTeams;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createData];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+10, self.view.frame.size.width, self.view.frame.size.height-55)];

    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.title = @"Sports";
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
