//
//  ViewController.m
//  HomePageExample
//
//  Created by Pat Dale on 4/30/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
NSArray *storyViewArray;
}
@end

@implementation ViewController

@synthesize storyOneView, storyTwoView, storyThreeView, storyFourView, storyFiveView, storySixView, storySevenView, storyEightView, storyNineView, storyTenView, storyElevenView, storyTwelveView, storyThirteenView, storyFourteenView;
@synthesize storyImage;

/***
 * Initialize globals, and load the views.
 * @Params: None
 * @Returns: None
 **/
- (void)viewDidLoad
{
    [super viewDidLoad];
	storyViewArray = [NSArray arrayWithObjects:storyOneView, storyTwoView, storyThreeView, storyFourView, storyFiveView, storySixView, storySevenView, storyEightView, storyNineView, storyTenView, storyElevenView, storyTwelveView, storyThirteenView, storyFourteenView, nil];
    for (int i = 0; i < [storyViewArray count]; i++) {
        UIView* field = [storyViewArray objectAtIndex: i];
        field.tag = i;
        field.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:67.0/255.0 blue:115.0/255.0 alpha:1];
    }
    storyImage.image = [UIImage imageNamed:@"CJ_Dale_Shot_Put.jpg"];
}

/*
 UNIMPLEMENTED CODE
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(storyTwoView.frame.origin.x, storyTwoView.frame.origin.y, storyTwoView.frame.size.width, storyTwoView.frame.size.height)];
    [yourLabel setText:@"ONE TWO THREE FOUR FIVE"];
    [yourLabel setTextColor:[UIColor yellowColor]];
    [yourLabel setBackgroundColor:[UIColor clearColor]];
    [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
    yourLabel.numberOfLines = 0;
    //yourLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [storyTwoView addSubview:yourLabel];
}
*/

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

@end
