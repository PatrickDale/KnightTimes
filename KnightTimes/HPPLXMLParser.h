//
//  HPPLXMLParser.h
//  KnightTimes
//
//  Created by Pat Dale on 6/2/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPPLXMLParser : NSObject

@property (strong, readonly) NSMutableArray *stories;
-(id) parseXMLByURL:(NSString *) urlString;

@end
