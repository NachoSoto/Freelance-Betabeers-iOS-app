//
//  TwitterTableController.h
//  Freelance
//
//  Created by Miquel Camps Ortea on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>

#import "UIImageView+WebCache.h"

#import "SVProgressHUD.h"

#include <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>

@interface TwitterTableController : UIViewController <UIAlertViewDelegate>{
    NSMutableArray *arrayC;
    IBOutlet UITableView *tableView;
    BOOL isRetina;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)newTweet:(id)sender;
- (IBAction)refreshTweet:(id)sender;

@end