//
//  ViewController.m
//  XMLParsing
//
//  Created by Christopher Constable on 10/4/13.
//  Copyright (c) 2013 The Analog School. All rights reserved.
//

#import "ViewController.h"
#import "RSSFeedItem.h"

#import <SVProgressHUD.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

// Import XML parsing libraries
#import <GDataXMLNode.h>
#import <TouchXML.h>
#import <RXMLElement.h>
#import "WebViewViewController.h"
#import <DTCoreText/NSAttributedString+HTML.h>
#import <DTCoreText/NSAttributedString+DTCoreText.h>

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *feedItems;

// Used for the NSXMLParser
@property (nonatomic, strong) NSMutableString *xmlCharactersFound;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.feedItems = [NSMutableArray array];
    
	[self requestXMLData];
}

- (void)requestXMLData
{
    // XML Data: http://www.mobiquityinc.com/news.rss
    
    NSURL *url = [NSURL URLWithString:@"http://www.mobiquityinc.com/news.rss"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFHTTPResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Receieved %d bytes of XML data.", [(NSData *)responseObject length]);
        
        //
        // Try parsing the XML using different parsers...
        //
        
        [self parseXMLUsingGData:responseObject];
//        [self parseXMLUsingTouchXML:responseObject];
//        [self parseXMLUsingRaptureXML:responseObject];
        //[self parseXMLUsingNSXMLParser:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
    
    [requestOperation start];
}

- (void)parseXMLUsingGData:(NSData *)responseData
{
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithData:responseData error:nil];
    
    NSArray *root = [xmlDoc.rootElement nodesForXPath:@"channel/item" error:nil];
    
    [root enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        GDataXMLNode *newNode = obj;
        RSSFeedItem *feedItem = [[RSSFeedItem alloc] init];
        feedItem.itemTitle = [[[newNode nodesForXPath:@"title" error:nil] firstObject] stringValue];
        feedItem.itemUrl = [[[newNode nodesForXPath:@"link" error:nil] firstObject] stringValue];
        feedItem.itemDescription = [[[newNode nodesForXPath:@"description" error:nil] firstObject] stringValue];

        [self.feedItems addObject:feedItem];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });

    }];
    
}

- (void)parseXMLUsingTouchXML:(NSData *)responseData
{
    
}

- (void)parseXMLUsingRaptureXML:(NSData *)responseData
{
    
}

- (void)parseXMLUsingNSXMLParser:(NSData *)responseData
{
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:responseData];
    
    // The NSXMLParser uses SAX which means it parses XML in an event-driven
    // fashion. Therefore, we need to setup a delegate to receive events.
    parser.delegate = self;
    
    // Parsing must be started manually.
    BOOL success = [parser parse];
    
    if (success) {
        NSLog(@"NSXMLParser finished successfully.");
        [self.tableView reloadData];
    }
    else {
        NSLog(@"NSXMLParser failed. %@ %@", [parser.parserError localizedDescription], [parser.parserError userInfo]);
    }
}

#pragma mark - NSXMLParser

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.xmlCharactersFound appendString:string];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    self.xmlCharactersFound = [[NSMutableString alloc] init];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    // Let's print out a trucated version so it's easier to read...
    NSInteger charactersInTruncatedString = MIN(36, self.xmlCharactersFound.length);
    NSString *truncatedCharacters = [self.xmlCharactersFound substringToIndex:charactersInTruncatedString];
    
    NSLog(@"[%@] %@", elementName, truncatedCharacters);
    
    RSSFeedItem *newFeedItem = [[RSSFeedItem alloc] init];
    newFeedItem.itemTitle = elementName;
    newFeedItem.itemDescription = self.xmlCharactersFound;
    
    [self.feedItems addObject:newFeedItem];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.feedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"Cell"];
    }
    
    RSSFeedItem *feedItem = [self.feedItems objectAtIndex:indexPath.row];
    NSAttributedString *attritedDesc = [[NSAttributedString alloc] initWithHTMLData:[feedItem.itemDescription dataUsingEncoding:NSUTF8StringEncoding] options:nil documentAttributes:nil];
    cell.textLabel.text = feedItem.itemTitle;
    cell.detailTextLabel.text = [attritedDesc plainTextString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        
    [self performSegueWithIdentifier:@"ajsdfl" sender:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewViewController *newVC = segue.destinationViewController;
    newVC.feedItem = [self.feedItems objectAtIndex:[self.tableView indexPathForSelectedRow].row];
}
@end
