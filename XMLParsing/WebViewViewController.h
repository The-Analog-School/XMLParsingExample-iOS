//
//  WebViewViewController.h
//  XMLParsing
//
//  Created by Peter Foti on 10/4/13.
//  Copyright (c) 2013 The Analog School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSFeedItem.h"

@interface WebViewViewController : UIViewController

@property (strong, nonatomic) RSSFeedItem *feedItem;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
