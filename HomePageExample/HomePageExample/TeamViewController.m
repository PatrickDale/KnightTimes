//
//  TeamViewController.m
//  KnightTime
//
//  Created by Pat Dale on 5/22/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "TeamViewController.h"
#import "XMLParser.h"

@interface TeamViewController () {
    NSArray *sportTeams;
    XMLParser *xmlParser;
}

@end

@implementation TeamViewController

@synthesize TeamView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sportTeams = [NSArray arrayWithObjects:@"Baseball",@"(M) Basketball",@"(W) Basketball",@"(M) Cross Country",@"(W) Cross Country",@"Football",@"(M) Golf",@"(W) Golf",@"(M) Soccer",@"(W) Soccer",@"Softball",@"(M) Swimming and Diving",@"(W) Swimming and Diving",@"(M) Tennis",@"(W) Tennis",@"(M) Track and Field",@"(W) Track and Field",@"Volleyball", nil];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(TeamView.frame.origin.x, TeamView.frame.origin.y+10, TeamView.frame.size.width, TeamView.frame.size.height-55)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [TeamView addSubview:tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sportTeams count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"SportsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *sport = [sportTeams objectAtIndex:indexPath.row];
    cell.textLabel.text = sport;
    
    return cell;
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
