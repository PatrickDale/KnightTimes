//
//  ScheduleViewController.m
//  HomePageExample
//
//  Created by Garo Anguiano-Sainz on 5/11/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "ScheduleViewController.h"
#import "XMLParser.h"

@interface ScheduleViewController (){
    NSMutableArray *scheduleViewArray;
    XMLParser *xmlParser;
}
@end

@implementation ScheduleViewController

@synthesize scheduleViewController;



-(void)viewDidLoad
{
    [super viewDidLoad];
    xmlParser = [[XMLParser alloc] loadXMLByURL: @"http://apps.carleton.edu/athletics/feeds/events"];
    NSLog(@"Story Count: %lu", (unsigned long)[[xmlParser stories] count]);
    scheduleViewController.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
    UIScrollView *scrollSubView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
    int count = 1;
    int height = 55;
    
    for (int i = 0; i<9; i++){
        CGRect box = CGRectMake(10, height, [self box_width], [self box_height]);
        height += [self box_height];
        UIView *subView = [[UIView alloc] initWithFrame:box];
        subView.tag = count;
        count++;
        
        subView.backgroundColor = [UIColor whiteColor];
        
        //UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
        //[subView addGestureRecognizer:singleTap];
        //[subView setMultipleTouchEnabled:YES];
        //[subView setUserInteractionEnabled:YES];
        subView.layer.borderColor = [UIColor colorWithRed:245.0/255.0 green:188.0/255.0 blue:53.0/255.0 alpha:1].CGColor;
        subView.layer.borderWidth = 3.0f;
        [scrollSubView addSubview:subView];
        [scheduleViewArray addObject:subView];
    }
    scrollSubView.contentSize = CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, height+30);
    [scheduleViewController addSubview:scrollSubView];
    
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake((((UIView*)[self.view viewWithTag:1]).frame.origin.x)-2, (((UIView*)[self.view viewWithTag:1]).frame.origin.y+((((UIView*)[self.view viewWithTag:1]).frame.size.height)*(3.0/6.0))), (((UIView*)[self.view viewWithTag:1]).frame.size.width)-10, (((UIView*)[self.view viewWithTag:1]).frame.size.height)*(1.0/3.0))];
    [yourLabel setText:@"Game 1 We Won"];
    [yourLabel setTextColor:[UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1]];
    [yourLabel setBackgroundColor:[UIColor clearColor]];
    [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 8.0f]];
    yourLabel.numberOfLines = 0;
    [((UIView*)[self.view viewWithTag:1]) addSubview:yourLabel];
    
}

- (IBAction)returnHome:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}



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
    return [UIScreen mainScreen].applicationFrame.size.height/10;
}

- (CGFloat) box_width   {
    return ([UIScreen mainScreen].applicationFrame.size.width-20);
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

@end