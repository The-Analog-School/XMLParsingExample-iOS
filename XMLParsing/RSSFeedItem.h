//
//  RSSFeedItem.h
//  XMLParsing
//
//  Created by Christopher Constable on 10/4/13.
//  Copyright (c) 2013 The Analog School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSFeedItem : NSObject

@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, copy) NSString *itemUrl;
@property (nonatomic, copy) NSString *itemDescription;

@end
