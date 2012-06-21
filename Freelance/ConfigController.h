//
//  ConfigController.h
//  Freelance
//
//  Created by Miquel Camps Ortea on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Twitter/Twitter.h>

@interface ConfigController : UIViewController <MFMailComposeViewControllerDelegate>  {
    IBOutlet UIScrollView *scrollview;
}


@property (strong, nonatomic) IBOutlet UIStepper *ourStepper1;
@property (strong, nonatomic) IBOutlet UIStepper *ourStepper2;

@property (strong, nonatomic) IBOutlet UITextField *txt_iva;
@property (strong, nonatomic) IBOutlet UITextField *txt_irpf;
@property (strong, nonatomic) IBOutlet UITextField *txt_email;
@property (strong, nonatomic) IBOutlet UITextField *txt_linkedin;
@property (strong, nonatomic) IBOutlet UITextField *txt_name;
@property (strong, nonatomic) IBOutlet UITextField *txt_cif;


- (IBAction)stepperValueChanged1:(id)sender;
- (IBAction)stepperValueChanged2:(id)sender;
- (IBAction)stepperValueChanged4:(id)sender;
- (IBAction)stepperValueChanged5:(id)sender;
- (IBAction)stepperValueChanged6:(id)sender;
- (IBAction)stepperValueChanged7:(id)sender;


/////////////////

- (IBAction)rateApp:(id)sender;
- (IBAction)sendEmailFeedback:(id)sender;


@end