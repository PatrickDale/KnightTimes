//
//  ViewController.h
//  HomePageExample
//
//  Created by Pat Dale on 4/30/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"
#import "Story.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *homeViewController;
@property (strong, nonatomic) IBOutlet UIView *storyView;

- (IBAction)returnToHome:(id)sender;
- (IBAction)gestureRecognized:(id)sender;

@end

