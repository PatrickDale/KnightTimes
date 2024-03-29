//
//  HPPLParser.h
//  KnightTimes
//
//  Created by Pat Dale on 6/1/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPPLParser : NSObject

@property (strong, readonly) NSMutableArray *images;
@property (strong, readonly) NSMutableArray *articleText;
@property (strong, readonly) NSMutableArray *articleTitle;
-(id) parseXMLByURL:(NSString *) urlString;
-(id) parseHTMLByURL:(NSString *) urlString;

@end
