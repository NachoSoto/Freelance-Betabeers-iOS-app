//
//  JobViewController.m
//  Freelance
//
//  Created by Miquel Camps Ortea on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JobViewController.h"

@interface JobViewController ()

@end

@implementation JobViewController


@synthesize job, titulo, fecha, descripcion, email, web, btnReply;

////////////////////////////

- (void)setBackground{
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"whitey.png"]];
}

////////////////////////////

- (IBAction)replyJob:(id)sender{

    

    
    

    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle: @"Acción" delegate: self cancelButtonTitle: @"Cancelar" destructiveButtonTitle:nil otherButtonTitles: @"Responder",@"Enviar copia",nil];

    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	
    [popupQuery showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];    
    NSString *subject = @"";
    NSString *body = @"";
    NSString *to = @"";
    
    
    // reply
	if (buttonIndex == 0) {

        to = [NSString stringWithString:email];
        subject = [NSString stringWithFormat:@"RE: %@", self.titulo.text];
        NSString *linkedin = [prefs stringForKey:@"linkedin"];
        
        NSLog(@"%@",linkedin);
        
        
        if( [linkedin isEqualToString: @""] )
        {
            body = [NSString stringWithFormat:@"<br/><br/><a href=\"%@\">enlace de la oferta</a>", web];
            
        }else{
            body = [NSString stringWithFormat:@"<br/><br/><a href=\"%@\">mi linkedin</a><br/><br/><a href=\"%@\">enlace de la oferta</a>", linkedin, web];
        }
        
        
    // copy
    } else if (buttonIndex == 1) {
		
        to = [prefs stringForKey:@"email"];
        subject = [NSString stringWithFormat:@"Fwd: %@", self.titulo.text];
        body = [NSString stringWithFormat:@"<a href=\"%@\">enlace de la oferta</a><br/><br/>%@", web, self.descripcion.text];
        
        
    }
    
    
    if (buttonIndex != 2) {
            
        if ([MFMailComposeViewController canSendMail]) {
            
            MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
            [controller setSubject: subject ];
            [controller setToRecipients:[NSArray arrayWithObject:to]];
            [controller setMessageBody:body isHTML:YES];
            
            
            [self presentModalViewController:controller animated:YES];
            controller.mailComposeDelegate = self;
            
        }else{
            
            UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Para enviar sugerencias antes tienes que configurar una cuenta de correo" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [someError show];
            
        }
    }
    
	
}



- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissModalViewControllerAnimated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
    self.titulo.text = [job objectForKey:@"title"];
    

    
    
    if( [[job objectForKey:@"interested"] isEqualToString: @"0"] )
    {
        self.fecha.text = [job objectForKey:@"date"];
    }else{
        self.fecha.text = [NSString stringWithFormat:@"%@ - %@ interesados", [job objectForKey:@"date"], [job objectForKey:@"interested"]];
    }
    
    
    
    self.title = [job objectForKey:@"company"];
    

    
    self.descripcion.text = [job objectForKey:@"body"];
    email = [job objectForKey:@"email"];
    web = [job objectForKey:@"url"];
    
    
    descripcion.numberOfLines = 0;
    [descripcion sizeToFit];
    

    
    [self setBackground];
    
    
    scrollview.contentSize = CGSizeMake(scrollview.frame.size.width,
                                        descripcion.frame.size.height+110);
    
    
    
    

    btnReply.frame = CGRectMake(btnReply.frame.origin.x, (descripcion.frame.size.height + 35), btnReply.frame.size.width, btnReply.frame.size.height);


    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
