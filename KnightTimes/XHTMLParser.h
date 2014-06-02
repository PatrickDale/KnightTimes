//
//  XHTMLParser.h
//  KnightTimes
//
//  Created by Pat Dale on 6/1/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XHTMLParser : NSObject <NSXMLParserDelegate>

@property (strong, readonly) NSMutableArray *images;
@property (strong, nonatomic) NSMutableString *description;

-(id) loadXMLByURL:(NSString *) urlString;

@end
