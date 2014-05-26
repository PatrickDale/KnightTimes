//
//  ViewController.m
//  HomePageExample
//
//  Created by Pat Dale on 4/30/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "ViewController.h"
#import "XMLParser.h"

@interface ViewController () {
    NSMutableArray *storyViewArray;
    XMLParser *xmlParser;
    UINavigationController *navigationController;
    UIViewController *tempViewController;
    BOOL isOpen;
}
@end

@implementation ViewController

@synthesize homeViewController, storyView;

/***
 * Initialize globals, and load the views.
 * @Params: None
 * @Returns: None
 **/
- (void)viewDidLoad
{
    [super viewDidLoad];
    xmlParser = [[XMLParser alloc] loadXMLByURL:@"http://apps.carleton.edu/athletics/feeds/blogs/varsity_athletics"];

    //Set background collor of homeview
    homeViewController.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
    
    //Create scrollable subview
    UIScrollView *scrollSubView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
    int count = 1;
    int height = 20;
    //Create six smaller subviews
    for (int i = 0; i<[[xmlParser stories] count]/2; i++) {
        // Demensions of left and right boxes
        CGRect  leftBox = CGRectMake(10, height, [self box_width]-5, [self box_height]);
        CGRect  rightBox = CGRectMake(([UIScreen mainScreen].applicationFrame.size.width/2)+5, height, [self box_width]-5, [self box_height]);
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
    scrollSubView.contentSize = CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, height+30);
    [homeViewController addSubview:scrollSubView];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //TEXT IN SUBVIEWS
    for (int i=0; i<[[xmlParser stories] count]; i++) {
        Story *story = [[xmlParser stories] objectAtIndex:i];
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
        imageArea.image = [UIImage imageNamed:@"knightHead.jpg"];
        [((UIView*)[self.view viewWithTag:i+1]) addSubview:imageArea];
    }
    
    //yourLabel.shadowColor = [UIColor blackColor];
    //yourLabel.shadowOffset = CGSizeMake(0, 1.0);
    
    //yourLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    
    //IMAGE IN SUBVIEWS
    //UIImageView *imageArea = [[UIImageView alloc] initWithFrame:CGRectMake((((UIView*)[self.view viewWithTag:1]).frame.origin.x), (((UIView*)[self.view viewWithTag:1]).frame.origin.y)-10, (((UIView*)[self.view viewWithTag:1]).frame.size.width)-20, (((UIView*)[self.view viewWithTag:1]).frame.size.height)*(3.0/6.0))];
    //imageArea.image = [UIImage imageNamed:@"CJ_Dale_Shot_Put.jpg"];
    //[((UIView*)[self.view viewWithTag:1]) addSubview:imageArea];
}


/***
 * Return to home view when in story view.
 * @Params: id
 * @Return: IBAction
 **/
- (IBAction)returnToHome:(id)sender {
    //[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    //UIView *viewToRemove = [tempViewController.view viewWithTag:111];
    //[viewToRemove removeFromSuperview];
    [self.view removeFromSuperview];
}

/***
 * When a tap gesture has been used, pull up storyView.
 * @Params: id
 * @Return: IBAction
 **/
- (IBAction)gestureRecognized:(id)sender
{
    //[self.navigationController popViewControllerAnimated: NO];
    //[self.tabBarController.navigationController popViewControllerAnimated: YES];
    //NSLog(@"Tag: %d", [sender tag]);
    UIView *view = [sender view];
    Story *story = [[xmlParser stories] objectAtIndex:view.tag-1];
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"StoryViewController"];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(vc.view.frame.origin.x, vc.view.frame.origin.y + 40, vc.view.frame.size.width, vc.view.frame.size.height)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:story.link]]];
    [vc.view addSubview:webView];
    vc.view.tag = 111;
    tempViewController = vc;
    [self.view addSubview:vc.view];
    //[self.view addSubview:storyView];
    //[self presentViewController:vc animated:YES completion:nil];
    //[homeViewController removeFromSuperview];
    //[self.tabBarController.navigationController pushViewController:vc animated:YES];
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) box_height   {
    return [UIScreen mainScreen].applicationFrame.size.height/3;
}

- (CGFloat) box_width   {
    return ([UIScreen mainScreen].applicationFrame.size.width/2)-10;
}

@end
