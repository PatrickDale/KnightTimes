//
//  SportViewController.m
//  KnightTimes
//
//  Created by Pat Dale on 5/27/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "SportViewController.h"
#import "XMLParser.h"
#import "TeamStoryListViewController.h"

@interface SportViewController () {
    XMLParser *xmlParser;
    TeamStoryListViewController *newTable;
}

@end

@implementation SportViewController
@synthesize sportView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/***
 * Creates the key value pairs for sport -> URL for sport page
 * @Params: None
 * @Returns: void
 ***/
- (void) createData {
    sportsInfo = @{
                   @"Baseball" : @"http://apps.carleton.edu/athletics/feeds/blogs/baseball",
                   @"Basketball (M)" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_basketball",
                   @"Basketball (W)" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_basketball",
                   @"Cross Country (M)" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_cross_country",
                   @"Cross Country (W)" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_cross_country",
                   @"Football" : @"http://apps.carleton.edu/athletics/feeds/blogs/football",
                   @"Golf (M)" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_golf",
                   @"Golf (W)" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_golf",
                   @"Soccer (M)" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_soccer",
                   @"Soccer (W)" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_soccer",
                   @"Softball" : @"http://apps.carleton.edu/athletics/feeds/blogs/softball",
                   @"Swimming and Diving (M)" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_swimming_and_diving",
                   @"Swimming and Diving (W)" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_swimming_and_diving",
                   @"Tennis (M)" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_tennis",
                   @"Tennis (W)" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_tennis",
                   @"Track and Field (M)" : @"http://apps.carleton.edu/athletics/feeds/blogs/mens_track_and_field",
                   @"Track and Field (W)" : @"http://apps.carleton.edu/athletics/feeds/blogs/womens_track_and_field",
                   @"Volleyball" : @"http://apps.carleton.edu/athletics/feeds/blogs/volleyball"
                   };
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createData];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+65, self.view.frame.size.width, self.view.frame.size.height-115)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
    sportView.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
    [sportView addSubview:tableView];
    self.navigationItem.title = @"Sports";

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
    UITableViewCell *cell = [self->tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor colorWithRed:245.0/255.0 green:188.0/255.0 blue:53.0/255.0 alpha:1];
        cell.backgroundColor =[UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray * sortedKeys = [[sportsInfo allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    NSString *sport = [sortedKeys objectAtIndex:indexPath.row];
    cell.textLabel.text = sport;
    cell.tag = indexPath.row;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self->tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [self->tableView cellForRowAtIndexPath:indexPath];
    newTable = [[TeamStoryListViewController alloc]loadTableWithURL:[sportsInfo objectForKey:cell.textLabel.text] withSport:cell.textLabel.text];
    [self.navigationController pushViewController:newTable animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
