//
//  ListViewController.m
//  KnightTime
//
//  Created by Pat Dale on 5/25/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "ListViewController.h"
#import "XMLParser.h"

@interface ListViewController () {
    XMLParser *xmlParser;
    UIViewController *tempStoryController;
}

@end

@implementation ListViewController

@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)returnToTeamStories:(id)sender {
    [self.view removeFromSuperview];
}

-(id) loadTableWithURL:(NSString *)urlString
{
    xmlParser = [[XMLParser alloc] loadXMLByURL:urlString];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+40, self.view.frame.size.width, self.view.frame.size.height-85)];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    return self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[xmlParser stories] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"SportsCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Story *sport = [[xmlParser stories] objectAtIndex:indexPath.row];
    cell.textLabel.text = sport.title;
    cell.tag = indexPath.row;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view removeFromSuperview];
    //ListStoryViewController
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    CGPoint hitPoint = [cell convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    NSLog(@"Index: %ld", (long)hitIndex.item);
    Story *story = [[xmlParser stories] objectAtIndex:hitIndex.item];
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController *viewC = [storyboard instantiateViewControllerWithIdentifier:@"ListStoryViewController"];
    UIWebView *wView = [[UIWebView alloc] initWithFrame:CGRectMake(viewC.view.frame.origin.x, viewC.view.frame.origin.y + 40, viewC.view.frame.size.width, viewC.view.frame.size.height)];
    [wView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:story.link]]];
    NSLog(@"Link: %@", story.link);
    [viewC.view addSubview:wView];
    tempStoryController = viewC;
    //[self.view addSubview:viewC.view];
    [self presentViewController:viewC animated:YES completion:nil];

    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
