//
//  ViewController.h
//  XMLParsing
//
//  Created by Christopher Constable on 10/4/13.
//  Copyright (c) 2013 The Analog School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
