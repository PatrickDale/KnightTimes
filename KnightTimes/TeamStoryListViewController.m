//
//  TeamStoryListViewController.m
//  KnightTimes
//
//  Created by Pat Dale on 5/27/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "TeamStoryListViewController.h"
#import "XMLParser.h"
#import "HPPLParser.h"
#import "Story.h"

@interface TeamStoryListViewController () {
    XMLParser *xmlParser;
    HPPLParser *hpplParser;
    UINavigationController *navController;
    NSMutableDictionary *dataDictionary;
    NSDictionary *loadedDataDict;
}

@end

@implementation TeamStoryListViewController
@synthesize tableView;

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
}

/***
 * Creates a UITableView listing articles given the sport
 * @Params: NSString, NSString
 * @Returns: id
 ***/
-(id) loadTableWithURL:(NSString *)urlString withSport:(NSString *)sport
{
    [self loadData:sport];
    xmlParser = [[XMLParser alloc] loadXMLByURL:urlString];
    dataDictionary = [NSMutableDictionary dictionary];
    [self getStoryImages];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    self.navigationItem.title = sport;
    tableView.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
    [self saveData:sport];
    return self;
}

/***
 * Gets images for stories, if not already stored, and resizes them to an appropriate thumbnail size
 * @Params: none
 * @Returns: void
 ***/
-(void) getStoryImages
{
    for (int i=0; i<[[xmlParser stories] count]; i++) {
        Story *story = [[xmlParser stories] objectAtIndex:i];
        NSData *data;
        if ([loadedDataDict valueForKey:story.link])
        {
            data = [[loadedDataDict valueForKey:story.link] objectAtIndex:0];
            story.title = [[loadedDataDict valueForKey:story.link] objectAtIndex:1];
            story.articleText = [[loadedDataDict valueForKey:story.link] objectAtIndex:2];
        } else {
            hpplParser = [[HPPLParser alloc] parseXMLByURL:story.link];
            NSURL *imgURL = [NSURL URLWithString:[hpplParser.images objectAtIndex:2]];
            data = [NSData dataWithContentsOfURL:imgURL];
            HPPLParser *hpplStoryParser = [[HPPLParser alloc] parseHTMLByURL:story.link];
            story.title = [[hpplStoryParser articleTitle] objectAtIndex:0];
            story.articleText = [[hpplStoryParser articleText] objectAtIndex:0];
        }
        CGRect rect = CGRectMake(0,0,70,70);
        UIGraphicsBeginImageContext( rect.size );
        [[[UIImage alloc] initWithData:data] drawInRect:rect];
        story.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSArray *dataArray = [[NSArray alloc] initWithObjects:data, story.title, story.articleText, nil];
        [dataDictionary setValue:dataArray forKey:story.link];
    }
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor colorWithRed:245.0/255.0 green:188.0/255.0 blue:53.0/255.0 alpha:1];
        cell.backgroundColor =[UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Story *sport = [[xmlParser stories] objectAtIndex:indexPath.row];
    [cell.detailTextLabel setText:sport.pubDate];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = sport.image;
    cell.imageView.backgroundColor = [UIColor clearColor];
    cell.imageView.layer.cornerRadius = 5.0;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.textLabel.text = sport.title;
    cell.tag = indexPath.row;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self->tableView deselectRowAtIndexPath:indexPath animated:YES];
    Story *story = [[xmlParser stories] objectAtIndex:indexPath.item];
    hpplParser = [[HPPLParser alloc] parseXMLByURL:story.link];
    NSURL *imgURL = [NSURL URLWithString:[hpplParser.images objectAtIndex:2]];
    NSData *data = [NSData dataWithContentsOfURL:imgURL];
    UIImage *img = [[UIImage alloc] initWithData:data];
    UIViewController *storyViewController = [[UIViewController alloc] init];
    storyViewController.view.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
    UIScrollView *scrollableView = [[UIScrollView alloc] initWithFrame:storyViewController.view.frame];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(scrollableView.frame.origin.x+10, scrollableView.frame.origin.y+10, scrollableView.frame.size.width-20, scrollableView.frame.size.height)];
    [title setText:story.title];
    [title setTextColor:[UIColor whiteColor]];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont fontWithName: @"Trebuchet MS" size: 18.0f]];
    title.numberOfLines = 0;
    [title sizeToFit];
    UIImageView *imageArea = [[UIImageView alloc] initWithFrame: CGRectMake(title.frame.origin.x, title.frame.origin.y + title.frame.size.height+10, scrollableView.frame.size.width-20, scrollableView.frame.size.height/3.5)];
    imageArea.image = img;
    imageArea.contentMode = UIViewContentModeScaleAspectFit;
    UILabel *articleText = [[UILabel alloc] initWithFrame:CGRectMake(title.frame.origin.x, imageArea.frame.origin.y + imageArea.frame.size.height+10, scrollableView.frame.size.width-20, 200)];
    [articleText setText:story.articleText];
    [articleText setTextColor:[UIColor whiteColor]];
    [articleText setBackgroundColor:[UIColor clearColor]];
    [articleText setFont:[UIFont fontWithName: @"Trebuchet MS" size: 12.0f]];
    articleText.numberOfLines = 0;
    [articleText sizeToFit];
    [scrollableView addSubview:imageArea];
    [scrollableView addSubview:title];
    [scrollableView addSubview:articleText];
    scrollableView.contentSize = CGSizeMake(scrollableView.frame.size.width, title.frame.size.height + imageArea.frame.size.height + articleText.frame.size.height+40);
    [storyViewController.view addSubview:scrollableView];
    [self.navigationController pushViewController:storyViewController animated:YES];
}

/***
 * Saves all data for the articles shown in memory
 * @Params: NSString
 * @Returns: void
 ***/
- (void)saveData: (NSString *)sport
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *dictPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:sport];
    [dataDictionary writeToFile:dictPath atomically:YES];
}

/***
 * Loads all data for the articles previously shown from memory
 * @Params: NSString
 * @Returns: void
 ***/
- (void)loadData: (NSString *)sport
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *dictPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:sport];
    loadedDataDict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
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
