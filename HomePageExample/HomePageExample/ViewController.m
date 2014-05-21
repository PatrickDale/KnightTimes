//
//  ViewController.m
//  HomePageExample
//
//  Created by Pat Dale on 4/30/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
NSMutableArray *storyViewArray;
}
@end

@implementation ViewController

@synthesize homeViewController;
@synthesize storyImage;

/***
 * Initialize globals, and load the views.
 * @Params: None
 * @Returns: None
 **/
- (void)viewDidLoad
{
    [super viewDidLoad];
    //Set background collor of homeview
    homeViewController.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
    //Create scrollable subview
    UIScrollView *scrollSubView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
    int count = 1;
    int height = 20;
    //Create six smaller subviews
    for (int i = 0; i<6; i++) {
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
    storyImage.image = [UIImage imageNamed:@"CJ_Dale_Shot_Put.jpg"];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //TEXT IN SUBVIEWS
    UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake((((UIView*)[self.view viewWithTag:1]).frame.origin.x)-2, (((UIView*)[self.view viewWithTag:1]).frame.origin.y+((((UIView*)[self.view viewWithTag:1]).frame.size.height)*(3.0/6.0))), (((UIView*)[self.view viewWithTag:1]).frame.size.width)-10, (((UIView*)[self.view viewWithTag:1]).frame.size.height)*(1.0/3.0))];
    [yourLabel setText:@"Dsida, Tsutsui, Baker, and Stillerman named to D3baseball.com All-Region Team"];
    [yourLabel setTextColor:[UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1]];
    [yourLabel setBackgroundColor:[UIColor clearColor]];
    [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
    //yourLabel.shadowColor = [UIColor blackColor];
    //yourLabel.shadowOffset = CGSizeMake(0, 1.0);
    yourLabel.numberOfLines = 0;
    //yourLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [((UIView*)[self.view viewWithTag:1]) addSubview:yourLabel];
    
    //IMAGE IN SUBVIEWS
    UIImageView *imageArea = [[UIImageView alloc] initWithFrame:CGRectMake((((UIView*)[self.view viewWithTag:1]).frame.origin.x), (((UIView*)[self.view viewWithTag:1]).frame.origin.y)-10, (((UIView*)[self.view viewWithTag:1]).frame.size.width)-20, (((UIView*)[self.view viewWithTag:1]).frame.size.height)*(3.0/6.0))];
    imageArea.image = [UIImage imageNamed:@"CJ_Dale_Shot_Put.jpg"];
    [((UIView*)[self.view viewWithTag:1]) addSubview:imageArea];
}


/***
 * Return to home view when in story view.
 * @Params: id
 * @Return: IBAction
 **/
- (IBAction)returnToHome:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

/***
 * When a tap gesture has been used, pull up storyView.
 * @Params: id
 * @Return: IBAction
 **/
- (IBAction)gestureRecognized:(id)sender
{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"StoryViewController"];
    [self presentViewController:vc animated:YES completion:nil];
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
