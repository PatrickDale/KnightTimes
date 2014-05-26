//
//  TeamViewController.m
//  KnightTime
//
//  Created by Pat Dale on 5/22/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "TeamViewController.h"
#import "XMLParser.h"
#import "StoryListView.h"
#import "ListViewController.h"

@interface TeamViewController () {
    XMLParser *xmlParser;
    ListViewController *newTable;
    UIViewController *tempStoryList;
}

@end

@implementation TeamViewController


@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) createData {
    sportsInfo = @{
                   @"Baseball" : @"http://apps.carleton.edu/athletics/feeds/blogs/baseball",
                   @"(M) Basketball" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_basketball",
                   @"(W) Basketball" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_basketball",
                   @"(M) Cross Country" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_cross_country",
                   @"(W) Cross Country" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_cross_country",
                   @"Football" : @"http://apps.carleton.edu/athletics/feeds/blogs/football",
                   @"(M) Golf" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_golf",
                   @"(W) Golf" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_golf",
                   @"(M) Soccer" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_soccer",
                   @"(W) Soccer" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_soccer",
                   @"Softball" : @"http://apps.carleton.edu/athletics/feeds/blogs/softball",
                   @"(M) Swimming and Diving" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_swimming_and_diving",
                   @"(W) Swimming and Diving" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_swimming_and_diving",
                   @"(M) Tennis" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_tennis",
                   @"(W) Tennis" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_tennis",
                   @"(M) Track and Field" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_track_and_field",
                   @"(W) Track and Field" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_track_and_field",
                   @"Volleyball" : @"http://apps.carleton.edu/athletics/feeds/blogs/volleyball"
                   };
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createData];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+40, self.view.frame.size.width, self.view.frame.size.height-55)];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.title = @"Sports";

    [self.view addSubview: self.tableView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[sportsInfo allKeys] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"SportsCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *sport = [[sportsInfo allKeys] objectAtIndex:indexPath.row];
    cell.textLabel.text = sport;
    cell.tag = indexPath.row;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //StoryListView *newView = [[StoryListView alloc] init];
    //newView.theTitle = [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    //[self.navigationController pushViewController:newView animated:YES];
    //NSLog(@"Index: %@", cell.textLabel.text);
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    newTable = [[ListViewController alloc]loadTableWithURL:[sportsInfo objectForKey:cell.textLabel.text]];
    UITableView *view = newTable.tableView;
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
    [viewController.view addSubview:view];
    tempStoryList = viewController;
    [self.view addSubview:viewController.view];
    
}

- (IBAction)returnToTeamList:(id)sender {
    [self.view removeFromSuperview];
}
@end
