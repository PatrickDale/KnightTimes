//
//  HomeViewController.m
//  KnightTimes
//
//  Created by Pat Dale on 5/26/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "HomeViewController.h"
#import "XMLParser.h"
#import "HPPLParser.h"

@interface HomeViewController () {
    NSMutableArray *storyViewArray;
    XMLParser *xmlParser;
    HPPLParser *hpplParser;
    NSMutableDictionary *imageDictionary;
    NSDictionary *loadedImageDict;
}
@end

@implementation HomeViewController
@synthesize homeView;

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
    [self loadImageData];
    xmlParser = [[XMLParser alloc] loadXMLByURL:@"http://apps.carleton.edu/athletics/feeds/blogs/varsity_athletics"];
    //Set background collor of homeview
    homeView.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
    UIScrollView *scrollSubView = [[UIScrollView alloc] initWithFrame:CGRectMake(homeView.frame.origin.x, homeView.frame.origin.y+55, homeView.frame.size.width, homeView.frame.size.height)];
    
    
    int count = 1;
    int height = 20;
    //Create six smaller subviews
    for (int i = 0; i<[[xmlParser stories] count]/2; i++) {
        // Demensions of left and right boxes
        CGRect  leftBox = CGRectMake(10, height, [self box_width]-5, [self box_height]);
        CGRect  rightBox = CGRectMake((homeView.frame.size.width/2)+5, height, [self box_width]-5, [self box_height]);
        height += [self box_height]+10;
        //Build left and right subview
        UIView* leftSubView = [[UIView alloc] initWithFrame:leftBox];
        UIView* rightSubView = [[UIView alloc] initWithFrame:rightBox];
        //Create unique tag for each
        leftSubView.tag = count;
        count++;
        rightSubView.tag = count;
        count++;
        //leftSubView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:188.0/255.0 blue:53.0/255.0 alpha:1];
        leftSubView.backgroundColor = [UIColor whiteColor];
        //Create a gesture for each view
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
        [leftSubView addGestureRecognizer:singleTap];
        [leftSubView setMultipleTouchEnabled:YES];
        [leftSubView setUserInteractionEnabled:YES];
        leftSubView.layer.borderColor = [UIColor colorWithRed:245.0/255.0 green:188.0/255.0 blue:53.0/255.0 alpha:1].CGColor;
        leftSubView.layer.borderWidth = 3.0f;
        rightSubView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
        [rightSubView addGestureRecognizer:singleTap2];
        [rightSubView setMultipleTouchEnabled:YES];
        [rightSubView setUserInteractionEnabled:YES];
        rightSubView.layer.borderColor = [UIColor colorWithRed:245.0/255.0 green:188.0/255.0 blue:53.0/255.0 alpha:1].CGColor;
        rightSubView.layer.borderWidth = 3.0f;
        //Add them to the scrollable subview and array
        [scrollSubView addSubview:leftSubView];
        [scrollSubView addSubview:rightSubView];
        [storyViewArray addObject:leftSubView];
        [storyViewArray addObject:rightSubView];
    }
    
    //Add scrollable subview with all subviews to homeview
    scrollSubView.contentSize = CGSizeMake(homeView.frame.size.width, height+105);
    self.navigationItem.title = @"Front Page";
    [homeView addSubview:scrollSubView];
    imageDictionary = [NSMutableDictionary dictionary];
    
    //homeView.backgroundColor = [UIColor greenColor];
    //UIViewController *viewController = [[UIViewController alloc] init];
    //viewController.view.backgroundColor = [UIColor blueColor];
    //[self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //TEXT IN SUBVIEWS
    for (int i=0; i<[[xmlParser stories] count]; i++) {
        Story *story = [[xmlParser stories] objectAtIndex:i];
        //Get all necessary data
        NSData *data;
        if ([loadedImageDict valueForKey:story.link])
        {
            data = [[loadedImageDict valueForKey:story.link] objectAtIndex:0];
            story.title = [[loadedImageDict valueForKey:story.link] objectAtIndex:1];
            story.articleText = [[loadedImageDict valueForKey:story.link] objectAtIndex:2];
        } else {
            hpplParser = [[HPPLParser alloc] parseXMLByURL:story.link];
            NSURL *imgURL = [NSURL URLWithString:[hpplParser.images objectAtIndex:2]];
            //NSLog( @"IMG: %@", [hpplParser.images objectAtIndex:2]);
            data = [NSData dataWithContentsOfURL:imgURL];
            HPPLParser *hpplStoryParser = [[HPPLParser alloc] parseHTMLByURL:story.link];
            story.title = [[hpplStoryParser articleTitle] objectAtIndex:0];
            story.articleText = [[hpplStoryParser articleText] objectAtIndex:0];
        }
        //NSLog(@"Count: %@", story.title);
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake((((UIView*)[self.view viewWithTag:1]).frame.origin.x)-2, (((UIView*)[self.view viewWithTag:1]).frame.origin.y+((((UIView*)[self.view viewWithTag:1]).frame.size.height)*(3.0/6.0))), (((UIView*)[self.view viewWithTag:1]).frame.size.width)-10, (((UIView*)[self.view viewWithTag:1]).frame.size.height)*(1.0/3.0))];
        [textLabel setText:story.title];
        [textLabel setTextColor:[UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1]];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        [textLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
        textLabel.numberOfLines = 0;
        [((UIView*)[self.view viewWithTag:i+1]) addSubview:textLabel];
        //IMAGE IN SUBVIEWS
        UIImageView *imageArea = [[UIImageView alloc] initWithFrame:CGRectMake((((UIView*)[self.view viewWithTag:1]).frame.origin.x), (((UIView*)[self.view viewWithTag:1]).frame.origin.y)-10, (((UIView*)[self.view viewWithTag:1]).frame.size.width)-20, (((UIView*)[self.view viewWithTag:1]).frame.size.height)*(3.0/6.0))];
        UIImage *img = [[UIImage alloc] initWithData:data];
        story.image = img;
        //imageArea.image = [UIImage imageNamed:@"knightHead.jpg"];
        imageArea.image = img;
        [((UIView*)[self.view viewWithTag:i+1]) addSubview:imageArea];
        NSArray *dataArray = [[NSArray alloc] initWithObjects:data, story.title, story.articleText, nil];
        [imageDictionary setValue:dataArray forKey:story.link];
    }
    
    //yourLabel.shadowColor = [UIColor blackColor];
    //yourLabel.shadowOffset = CGSizeMake(0, 1.0);
    
    //yourLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    
    //IMAGE IN SUBVIEWS
    //UIImageView *imageArea = [[UIImageView alloc] initWithFrame:CGRectMake((((UIView*)[self.view viewWithTag:1]).frame.origin.x), (((UIView*)[self.view viewWithTag:1]).frame.origin.y)-10, (((UIView*)[self.view viewWithTag:1]).frame.size.width)-20, (((UIView*)[self.view viewWithTag:1]).frame.size.height)*(3.0/6.0))];
    //imageArea.image = [UIImage imageNamed:@"CJ_Dale_Shot_Put.jpg"];
    //[((UIView*)[self.view viewWithTag:1]) addSubview:imageArea];
    [self saveImageData];
}

/***
 * When a tap gesture has been used, pull up storyView.
 * @Params: id
 * @Return: IBAction
 **/
- (IBAction)gestureRecognized:(id)sender
{
    UIView *view = [sender view];
    Story *story = [[xmlParser stories] objectAtIndex:view.tag-1];
    UIViewController *storyViewController = [[UIViewController alloc] init];
    storyViewController.view.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
    UIScrollView *scrollableView = [[UIScrollView alloc] initWithFrame:storyViewController.view.frame];
    //UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(homeView.frame.origin.x, homeView.frame.origin.y, homeView.frame.size.width, homeView.frame.size.height)];
    //[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:story.link]]];
    //hpplParser = [[HPPLParser alloc] parseXMLByURL:story.link];
    //NSURL *imgURL = [NSURL URLWithString:[hpplParser.images objectAtIndex:2]];
    //NSLog( @"IMG: %@", [hpplParser.images objectAtIndex:2]);
    //NSData *data = [NSData dataWithContentsOfURL:imgURL];
    //UIImage *img = [[UIImage alloc] initWithData:data];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(scrollableView.frame.origin.x+10, scrollableView.frame.origin.y+10, scrollableView.frame.size.width-20, scrollableView.frame.size.height)];
    [title setText:story.title];
    //[title setEditable:NO];
    [title setTextColor:[UIColor whiteColor]];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont fontWithName: @"Trebuchet MS" size: 18.0f]];
    title.numberOfLines = 0;
    [title sizeToFit];
    UIImageView *imageArea = [[UIImageView alloc] initWithFrame: CGRectMake(title.frame.origin.x, title.frame.origin.y + title.frame.size.height+10, scrollableView.frame.size.width-20, scrollableView.frame.size.height/3.5)];
    imageArea.image = story.image;
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
    //scrollableView.frame.size.height = title.frame.size.height + imageArea.frame.size.height + articleText.frame.size.height;
    [storyViewController.view addSubview:scrollableView];
    [self.navigationController pushViewController:storyViewController animated:YES];
}

- (void)saveImageData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *dictPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"imageDict.out"];
    [imageDictionary writeToFile:dictPath atomically:YES];
}

- (void)loadImageData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *dictPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"imageDict.out"];
    loadedImageDict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
    //for (NSString *key in dictFromFile)
        //NSLog(@"---===----- %@ ---===-----", key);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) box_height   {
    return homeView.frame.size.height/3;
}

- (CGFloat) box_width   {
    return (homeView.frame.size.width/2)-10;
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
