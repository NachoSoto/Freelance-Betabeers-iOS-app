//
//  JobTableController.h
//  Freelance
//
//  Created by Miquel Camps Ortea on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

#include <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>

@interface JobTableController : UIViewController <UIAlertViewDelegate>{
    NSMutableArray *arrayC;
    IBOutlet UITableView *tableView;
    BOOL connected;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)info:(id)sender;

@end