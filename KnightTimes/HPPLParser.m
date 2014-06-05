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

@synthesize images, articleTitle, articleText;

-(id) parseXMLByURL:(NSString *) urlString
{
    images = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    TFHpple *parser = [TFHpple hppleWithHTMLData:data];
    NSString *XPathQueryString = @"//img";
    NSArray *nodes = [parser searchWithXPathQuery:XPathQueryString];
    for (TFHppleElement *element in nodes) {
        NSString *imgURL = [element objectForKey:@"src"];
        if ([imgURL rangeOfString:@"apps.carleton.edu"].location == NSNotFound)
        {
            imgURL = [@"//apps.carleton.edu" stringByAppendingString:imgURL];
        }
        imgURL = [@"http:" stringByAppendingString:imgURL];
        [images addObject:imgURL];
    }
    return self;
}

-(id) parseHTMLByURL:(NSString *) urlString {
    articleTitle = [[NSMutableArray alloc] init];
    articleText = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    TFHpple *parser = [TFHpple hppleWithHTMLData:data];
    NSString *XPathQueryString = @"//div[@class='text']";
    NSArray *nodes = [parser searchWithXPathQuery:XPathQueryString];
    for (TFHppleElement *element in nodes) {
        NSMutableString *currentText = [NSMutableString string];
        for (TFHppleElement *child in element.children) {
            if ([[child firstChild] content]) {
                NSMutableString *tempString = [[NSMutableString alloc] initWithString:[[child firstChild] content]];
                [currentText appendString:(NSMutableString *) tempString];
            }
        }
        [currentText appendString:@"\n"];
        [articleText addObject:currentText];
        NSLog(@"Content %@", currentText);
        currentText = nil;
    }
    
    XPathQueryString = @"//h3[@class='postTitle']";
    nodes = [parser searchWithXPathQuery:XPathQueryString];
    for (TFHppleElement *element in nodes) {
        NSLog(@"Title---: %@", [[element firstChild] content]);
        if ([[element firstChild] content]) {
            [articleTitle addObject:[[element firstChild] content]];
        }
    }
    return self;
}

@end
