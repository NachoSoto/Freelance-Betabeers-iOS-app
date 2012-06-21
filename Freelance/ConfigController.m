//
//  ConfigController.m
//  Freelance
//
//  Created by Miquel Camps Ortea on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConfigController.h"

@interface ConfigController ()

@end

@implementation ConfigController

@synthesize
    ourStepper1,
    ourStepper2,

    txt_iva,
    txt_irpf,
    txt_email,
    txt_linkedin,

    txt_name,
    txt_cif;


////////////////////////////

- (void)setBackground{
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"whitey.png"]];
}

////////////////////////////

- (IBAction)stepperValueChanged1:(id)sender 
{
    int iva = ourStepper1.value;
    txt_iva.text = [NSString stringWithFormat:@"%d", iva];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:iva forKey:@"iva"];
}

- (IBAction)stepperValueChanged2:(id)sender 
{
    int irpf = ourStepper2.value;
    txt_irpf.text = [NSString stringWithFormat:@"%d", irpf];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:irpf forKey:@"irpf"];
}


- (IBAction)stepperValueChanged4:(id)sender 
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:txt_email.text forKey:@"email"];
}

- (IBAction)stepperValueChanged5:(id)sender 
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:txt_linkedin.text forKey:@"linkedin"];
}


- (IBAction)stepperValueChanged6:(id)sender 
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:txt_name.text forKey:@"name"];
}


- (IBAction)stepperValueChanged7:(id)sender 
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:txt_cif.text forKey:@"cif"];
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
} 

////////////////

- (IBAction)rateApp:(id)sender
{

    int appId = 535827516;
    NSString *reviewURL = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=535827516", appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL]];
    


}







- (IBAction)sendEmailFeedback:(id)sender
{

    
    if ([MFMailComposeViewController canSendMail]) {

        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        [controller setSubject:@"Sugerencias Freelance Betabeers"];
        [controller setToRecipients:[NSArray arrayWithObject:[NSString stringWithString:@"gafeman@gmail.com"]]];
        [self presentModalViewController:controller animated:YES];
        controller.mailComposeDelegate = self;

    }else{
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Para enviar sugerencias antes tienes que configurar una cuenta de correo" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [someError show];
        
    }
    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissModalViewControllerAnimated:YES];
}


///////

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];    
    int iva = [prefs integerForKey:@"iva"];
    int irpf = [prefs integerForKey:@"irpf"];
    NSString *name = [prefs stringForKey:@"name"];
    NSString *cif = [prefs stringForKey:@"cif"];
    NSString *email = [prefs stringForKey:@"email"];
    NSString *linkedin = [prefs stringForKey:@"linkedin"];
    


    txt_iva.text = [NSString stringWithFormat:@"%d", iva];
    txt_irpf.text = [NSString stringWithFormat:@"%d", irpf];

    txt_name.text = name;
    txt_cif.text = cif;
    txt_email.text = email;
    txt_linkedin.text = linkedin;    

    
    scrollview.contentSize = CGSizeMake(scrollview.frame.size.width,380);

    


    
    
    [self setBackground];
    

}




@end
