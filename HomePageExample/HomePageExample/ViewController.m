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


- (void)viewDidLoad
{
    [super viewDidLoad];
	storyViewArray = [NSArray arrayWithObjects:storyOneView, storyTwoView, storyThreeView, storyFourView, storyFiveView, storySixView, storySevenView, storyEightView, storyNineView, storyTenView, storyElevenView, storyTwelveView, storyThirteenView, storyFourteenView, nil];
    for (int i = 0; i < [storyViewArray count]; i++) {
        UIView* field = [storyViewArray objectAtIndex: i];
        field.tag = i;
    }
}

- (IBAction)gestureRecognized:(id)sender
{
    UIView* field = [(UITapGestureRecognizer*)sender view];
    field.backgroundColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
