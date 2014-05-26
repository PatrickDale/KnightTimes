//
//  StoryListView.m
//  KnightTime
//
//  Created by Pat Dale on 5/25/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "StoryListView.h"

@interface StoryListView ()

@end

@implementation StoryListView

@synthesize theTitle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = theTitle;
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
