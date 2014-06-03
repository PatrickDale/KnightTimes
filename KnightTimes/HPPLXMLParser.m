//
//  HPPLXMLParser.m
//  KnightTimes
//
//  Created by Pat Dale on 6/2/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "HPPLXMLParser.h"
#import "TFHpple.h"
#import "Story.h"

@implementation HPPLXMLParser

@synthesize stories;

-(id) parseXMLByURL:(NSString *) urlString
{
    stories = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // 2
    TFHpple *parser = [TFHpple hppleWithHTMLData:data];
    
    // 3
    //NSString *imageXPathQueryString = @"//img";
    //NSArray *imageNodes = [parser searchWithXPathQuery:imageXPathQueryString];
    
    NSString *titleXPathQueryString = @"//link";
    NSArray *titleNodes = [parser searchWithXPathQuery:titleXPathQueryString];
    
    // 4
    for (TFHppleElement *element in titleNodes) {
        NSLog(@"parent: ===== %@ ======", [element content]);
        for (TFHppleElement *child in element.children){
            NSLog(@"child: ===== %@ ======", [[child firstChild] content]);
            if ([child.tagName isEqualToString:@"title"]) {
                NSString *title = [[child firstChild] content];
                NSLog( @"title: %@", title);
            } else if ([child.tagName isEqualToString:@"pubDate"]) {
                NSString *pubDate = [[child firstChild] content];
                NSLog( @"pubDate: %@", pubDate);
            } else if ([child.tagName isEqualToString:@"link"]) {
                NSString *link = [[child firstChild] content];
                NSLog( @"link: %@", link);
            }
        }
        
    }
    return self;
}

@end
