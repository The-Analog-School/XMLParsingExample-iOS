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
}

@end
