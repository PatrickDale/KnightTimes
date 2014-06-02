//
//  HPPLParser.m
//  KnightTimes
//
//  Created by Pat Dale on 6/1/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "HPPLParser.h"
#import "TFHpple.h"

@implementation HPPLParser

@synthesize images;

-(id) parseXMLByURL:(NSString *) urlString
{
    images = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // 2
    TFHpple *parser = [TFHpple hppleWithHTMLData:data];
    
    // 3
    NSString *imageXPathQueryString = @"//img";
    NSArray *imageNodes = [parser searchWithXPathQuery:imageXPathQueryString];
    
    // 4
    for (TFHppleElement *element in imageNodes) {
        NSString *imgURL = [element objectForKey:@"src"];
        if ([imgURL rangeOfString:@"apps.carleton.edu"].location == NSNotFound)
        {
            imgURL = [@"//apps.carleton.edu" stringByAppendingString:imgURL];
        }
        imgURL = [@"http:" stringByAppendingString:imgURL];
        //NSString *theFinalString = [[NSString alloc] initWithString:imgURL];
        NSLog( @"IMG: %@", imgURL);
        [images addObject:imgURL];
    }
    NSLog( @"IMG: %@", [images objectAtIndex:2]);
    return self;
}

@end
