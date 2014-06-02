//
//  XMLParser.m
//  KnightTimes
//
//  Created by Pat Dale on 5/26/14.
//  Copyright (c) 2014 4students2apps. All rights reserved.
//

#import "XMLParser.h"

@interface XMLParser (){
    NSMutableString *currentString;
    NSXMLParser *parser;
    Story *story;
}

@end

@implementation XMLParser

@synthesize stories;

-(id) loadXMLByURL:(NSString *)urlString
{
    stories = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    return self;
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!currentString) {
        currentString = [NSMutableString string];
    }
        //[[NSMutableString alloc] initWithString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
  //  } else {
//        [currentString appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    //}
    currentString = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //[currentString appendString:string];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"item"]) {
        story = [Story alloc];
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"title"]) {
        story.title = currentString;
    }
    if ([elementName isEqualToString:@"pubDate"]) {
        story.pubDate = currentString;
    }
    if ([elementName isEqualToString:@"link"]) {
        story.link = currentString;
    }
    if ([elementName isEqualToString:@"item"]) {
        [stories addObject:story];
        story = nil;
        currentString = nil;
    }
}

@end
