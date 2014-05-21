//
//  XMLParser.h
//  KnightTime
//
//  Created by Pat Dale on 5/21/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"

@interface XMLParser : NSObject <NSXMLParserDelegate>

@property (strong, readonly) NSMutableArray *stories;

-(id) loadXMLByURL:(NSString *) urlString;

@end
