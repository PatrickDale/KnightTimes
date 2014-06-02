//
//  TwitterViewController.m
//  KnightTimes
//
//  Created by Pat Dale on 6/1/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "TwitterViewController.h"

@interface TwitterViewController ()

@end

@implementation TwitterViewController

@synthesize twitterView;

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
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(twitterView.frame.origin.x, twitterView.frame.origin.y+20, twitterView.frame.size.width, twitterView.frame.size.height)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://twitter.com/CarletonKnights"]]];
    [twitterView addSubview:webView];
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
