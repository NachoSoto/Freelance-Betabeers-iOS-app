//
//  JobViewController.h
//  Freelance
//
//  Created by Miquel Camps Ortea on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface JobViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
        
    IBOutlet UIScrollView *scrollview;
}

@property (strong, nonatomic) NSDictionary *job;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *web;

@property (strong, nonatomic) IBOutlet UILabel *titulo;
@property (strong, nonatomic) IBOutlet UILabel *fecha;
@property (strong, nonatomic) IBOutlet UILabel *descripcion;
@property (strong, nonatomic) IBOutlet UIButton *btnReply;

- (IBAction)replyJob:(id)sender;

@end