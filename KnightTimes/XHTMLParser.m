//
//  XHTMLParser.m
//  KnightTimes
//
//  Created by Pat Dale on 6/1/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "XHTMLParser.h"

@interface XHTMLParser (){
    NSMutableString *currentString;
    NSXMLParser *parser;
}

@end

@implementation XHTMLParser

@synthesize images, description;

-(id) loadXMLByURL:(NSString *)urlString
{
    images = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    return self;
}

- (NSMutableArray *)retrieveImageSourceTagsViaRegex:(NSString *)string
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<img\\s[\\s\\S]*?src\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSMutableArray *results = [NSMutableArray array];
    
    [regex enumerateMatchesInString:string
                            options:0
                              range:NSMakeRange(0, [string length])
                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                             
                             [results addObject:[string substringWithRange:[result rangeAtIndex:2]]];
                         }];
    
    return results;
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (description) {
        [self.description appendString:string];
    }
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"p"]) {
        NSLog(@"here1");
        self.description = [NSMutableString string];
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"p"]) {
        NSArray *imgTags = [self retrieveImageSourceTagsViaRegex:self.description];
        //NSDictionary *result = @{@"description": self.description, @"imgs" : imgTags};
        NSString *tag = [imgTags objectAtIndex:0];
        NSLog(@"Image: %@", tag);
        self.description = nil;
    }
}

@end








