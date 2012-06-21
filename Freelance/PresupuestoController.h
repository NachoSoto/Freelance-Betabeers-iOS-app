//
//  FirstViewController.h
//  Freelance
//
//  Created by Miquel Camps Ortea on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface PresupuestoController : UIViewController <MFMailComposeViewControllerDelegate> {
        IBOutlet UIScrollView *scrollview;
}

@property (strong, nonatomic) IBOutlet UISwitch *switchIRPF;

@property (strong, nonatomic) IBOutlet UIStepper *ourStepper1;
@property (strong, nonatomic) IBOutlet UIStepper *ourStepper2;
@property (strong, nonatomic) IBOutlet UIStepper *ourStepper3;
@property (strong, nonatomic) IBOutlet UIStepper *ourStepper4;
@property (strong, nonatomic) IBOutlet UIStepper *ourStepper5;
@property (strong, nonatomic) IBOutlet UIStepper *ourStepper6;

@property (strong, nonatomic) IBOutlet UITextField *stepperValueText1;
@property (strong, nonatomic) IBOutlet UITextField *stepperValueText2;
@property (strong, nonatomic) IBOutlet UITextField *stepperValueText3;
@property (strong, nonatomic) IBOutlet UITextField *stepperValueText4;
@property (strong, nonatomic) IBOutlet UITextField *stepperValueText5;
@property (strong, nonatomic) IBOutlet UITextField *stepperValueText6;

@property (strong, nonatomic) IBOutlet UILabel *txtHoras;
@property (strong, nonatomic) IBOutlet UILabel *txtBase;
@property (strong, nonatomic) IBOutlet UILabel *txtIVA;
@property (strong, nonatomic) IBOutlet UILabel *txtIRPF;
@property (strong, nonatomic) IBOutlet UILabel *txtTotal;

@property (strong, nonatomic) IBOutlet UILabel *lblIVA;
@property (strong, nonatomic) IBOutlet UILabel *lblIRPF;

- (IBAction)sendEmail:(id)sender;
- (IBAction)stepperValueChanged1:(id)sender;
- (IBAction)stepperValueChanged2:(id)sender;
- (IBAction)stepperValueChanged3:(id)sender;
- (IBAction)stepperValueChanged4:(id)sender;
- (IBAction)stepperValueChanged5:(id)sender;
- (IBAction)stepperValueChanged6:(id)sender;

- (IBAction)switchIRPFValueChanged:(id)sender;

@end
