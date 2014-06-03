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
    UIViewController *tempStoryController;
    UINavigationController *navController;
    NSMutableDictionary *imageDictionary;
    NSDictionary *loadedImageDict;
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

-(id) loadTableWithURL:(NSString *)urlString withSport:(NSString *)sport
{
    [self loadImageData:sport];
    xmlParser = [[XMLParser alloc] loadXMLByURL:urlString];
    imageDictionary = [NSMutableDictionary dictionary];
    [self getStoryImages];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    self.navigationItem.title = sport;
    tableView.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
    [self saveImageData:sport];
    return self;
}

-(void) getStoryImages
{
    for (int i=0; i<[[xmlParser stories] count]; i++) {
        Story *story = [[xmlParser stories] objectAtIndex:i];
        NSData *data;
        if ([loadedImageDict valueForKey:story.link])
        {
            data = [loadedImageDict valueForKey:story.link];
        } else {
            hpplParser = [[HPPLParser alloc] parseXMLByURL:story.link];
            NSURL *imgURL = [NSURL URLWithString:[hpplParser.images objectAtIndex:2]];
            //NSLog( @"IMG: %@", [hpplParser.images objectAtIndex:2]);
            data = [NSData dataWithContentsOfURL:imgURL];
        }
        CGRect rect = CGRectMake(0,0,70,70);
        UIGraphicsBeginImageContext( rect.size );
        [[[UIImage alloc] initWithData:data] drawInRect:rect];
        story.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [imageDictionary setValue:data forKey:story.link];
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
    }
    Story *sport = [[xmlParser stories] objectAtIndex:indexPath.row];
    //NSURL *imgURL = [NSURL URLWithString:[hpplParser.images objectAtIndex:2]];
    //NSLog( @"IMG: %@", [hpplParser.images objectAtIndex:2]);
    //NSData *data = [NSData dataWithContentsOfURL:imgURL];
    //UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 20.0f, 20.0f)];
    //img.contentMode = UIViewContentModeScaleAspectFit;
    //img.image = [[UIImage alloc] initWithData:data];
    //imageArea.image = [UIImage imageNamed:@"knightHead.jpg"];
    //cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //cell.imageView.frame = CGRectMake(0.0f, 0.0f, 5.0f, 5.0f);
    //cell.imageView.image = img.image;
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
    //NSLog(@"Index: %ld", (long)indexPath.item);
    [self->tableView deselectRowAtIndexPath:indexPath animated:YES];
    Story *story = [[xmlParser stories] objectAtIndex:indexPath.item];
    tempStoryController = [[UIViewController alloc] init];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-65, self.view.frame.size.width, self.view.frame.size.height+115)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:story.link]]];
    [tempStoryController.view addSubview:webView];
    NSLog(@"link: %@", story.link);
    [self.navigationController pushViewController:tempStoryController animated:YES];
}

- (void)saveImageData: (NSString *)sport
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *dictPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:sport];
    [imageDictionary writeToFile:dictPath atomically:YES];
}

- (void)loadImageData: (NSString *)sport
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *dictPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:sport];
    loadedImageDict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
    //for (NSString *key in dictFromFile)
    //NSLog(@"---===----- %@ ---===-----", key);
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
