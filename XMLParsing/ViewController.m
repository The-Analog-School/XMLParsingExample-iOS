//
//  ViewController.m
//  XMLParsing
//
//  Created by Christopher Constable on 10/4/13.
//  Copyright (c) 2013 The Analog School. All rights reserved.
//

#import "ViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

// Import XML parsing libraries

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self requestXMLData];
}

- (void)requestXMLData
{
    // XML Data: http://www.mobiquityinc.com/news.rss
    
    // Try it out using different parsers
    // [self parseXMLUsingGData]; etc...
}

- (void)parseXMLUsingGData
{
    
}

- (void)parseXMLUsingTouchXML
{
    
}

- (void)parseXMLUsingRaptureXML
{
    
}

- (void)parseXMLUsingNSXMLParser
{
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"Cell"];
    }
    
    // TODO: Setup cell
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
