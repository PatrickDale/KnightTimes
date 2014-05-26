//
//  ScheduleViewController.h
//  HomePageExample
//
//  Created by Garo Anguiano-Sainz on 5/11/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *storyImage;
@property (strong, nonatomic) IBOutlet UIView *scheduleViewController;
- (IBAction)returnHome:(id)sender;
- (IBAction)gestureRecognized:(id)sender;


@property NSString *text;


@end


