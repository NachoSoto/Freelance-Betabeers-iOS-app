//
//  TipsController.h
//  Freelance
//
//  Created by Miquel Camps Ortea on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>

#include <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>

@interface TipsController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *consejo;

- (IBAction)cargarFrase:(id)sender;
- (IBAction)twittearConsejo:(id)sender;

@end
