//
//  PresupuestoController.m
//  Freelance
//
//  Created by Miquel Camps Ortea on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PresupuestoController.h"



@interface PresupuestoController ()

@end

@implementation PresupuestoController

@synthesize
    ourStepper1,
    ourStepper2,
    ourStepper3,
    ourStepper4,
    ourStepper5,
    ourStepper6,

    stepperValueText1,
    stepperValueText2,
    stepperValueText3,
    stepperValueText4,
    stepperValueText5,
    stepperValueText6,

    txtHoras,
    txtBase,
    txtIVA,
    txtIRPF,
    txtTotal,

    lblIVA,
    lblIRPF,

    switchIRPF;

// http://cocoadev.com/wiki/NSLog
// http://www.ioslearner.com/uistepper-tutorial-example-sample-cod/
// http://blog.twg.ca/2010/11/retina-display-icon-set/
// http://stackoverflow.com/questions/1949475/iphone-code-change-the-tabbar-badge-value-from-the-viewcontrollers
// http://stackoverflow.com/questions/1113408/limit-a-double-to-two-decimal-places


////////////////////////////

- (void)setBackground{
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"whitey.png"]];
}

////////////////////////////


- (void)sumar
{
    int precio_hora, horas;
    float sum_irpf;
    
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];    
    int iva = [prefs integerForKey:@"iva"];
    int irpf = [prefs integerForKey:@"irpf"];
    NSString *divisa = @"€";//[prefs stringForKey:@"divisa"];
    
    
    float p1 = ((float)iva / 100);
    float p2 = ((float)irpf / 100);    
    
    
    //NSLog(@"iva %d (%f) - irpf %d (%f)",iva,p1,irpf,p2);

    precio_hora = ourStepper1.value;
    
    horas = [self.stepperValueText2.text intValue];
    horas += [self.stepperValueText3.text intValue];
    horas += [self.stepperValueText4.text intValue];
    horas += [self.stepperValueText5.text intValue];
    horas += [self.stepperValueText6.text intValue];
    self.txtHoras.text = [NSString stringWithFormat:@"%d", horas];

    self.txtBase.text = [NSString stringWithFormat:@"%d %@", (horas * precio_hora), divisa];
    self.txtIVA.text = [NSString stringWithFormat:@"%.2lf %@", ([self.txtBase.text floatValue] * p1), divisa ];
    self.txtIRPF.text = [NSString stringWithFormat:@"%.2lf %@", ([self.txtBase.text floatValue] * p2), divisa ];
    
    

    

    
    
    if( self.switchIRPF.on == TRUE ){
        sum_irpf = [self.txtIRPF.text floatValue];
        
    }else{
        sum_irpf = 0;
        
    }
    
    
    self.txtTotal.text = [NSString stringWithFormat:@"%.2lf %@", ( ( [self.txtBase.text floatValue] + [self.txtIVA.text floatValue] ) - sum_irpf ), divisa ];

    
    
    
    
}

- (IBAction)stepperValueChanged1:(id)sender 
{
    int stepperValue = ourStepper1.value;
    self.stepperValueText1.text = [NSString stringWithFormat:@"%d", stepperValue];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:stepperValue forKey:@"precio_hora"];
    
    [self sumar];
}

- (IBAction)stepperValueChanged2:(id)sender 
{
    int stepperValue = ourStepper2.value;
    self.stepperValueText2.text = [NSString stringWithFormat:@"%d", stepperValue];
    [self sumar];
}

- (IBAction)stepperValueChanged3:(id)sender 
{
    int stepperValue = ourStepper3.value;
    self.stepperValueText3.text = [NSString stringWithFormat:@"%d", stepperValue];
    [self sumar];
}

- (IBAction)stepperValueChanged4:(id)sender 
{
    int stepperValue = ourStepper4.value;
    self.stepperValueText4.text = [NSString stringWithFormat:@"%d", stepperValue];
    [self sumar];
}

- (IBAction)stepperValueChanged5:(id)sender 
{
    int stepperValue = ourStepper5.value;
    self.stepperValueText5.text = [NSString stringWithFormat:@"%d", stepperValue];
    [self sumar];
}

- (IBAction)stepperValueChanged6:(id)sender 
{
    int stepperValue = ourStepper6.value;
    self.stepperValueText6.text = [NSString stringWithFormat:@"%d", stepperValue];
    [self sumar];
}

- (IBAction)switchIRPFValueChanged:(id)sender 
{
    [self sumar];
}



- (NSString *)base64String:(NSString *)str
{
    NSData *theData = [str dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}



    

- (IBAction)sendEmail:(id)sender
{
        
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];    
    int iva = [prefs integerForKey:@"iva"];
    int irpf = [prefs integerForKey:@"irpf"];
    NSString *name = [prefs stringForKey:@"name"];
    NSString *cif = [prefs stringForKey:@"cif"];
    

    if( switchIRPF.on == NO ) irpf = 0;
    
    NSString *values = [self base64String: [NSString stringWithFormat:@"%@;%@;%@;%d;%d;%@;%@;%@;%@;%@", name, cif, self.stepperValueText1.text, iva, irpf, self.stepperValueText2.text, self.stepperValueText3.text, self.stepperValueText4.text, self.stepperValueText5.text, self.stepperValueText6.text]];
    

    NSLog(@"%@",[NSString stringWithFormat:@"%@;%@;%@;%d;%d;%@;%@;%@;%@;%@", name, cif, self.stepperValueText1.text, iva, irpf, self.stepperValueText2.text, self.stepperValueText3.text, self.stepperValueText4.text, self.stepperValueText5.text, self.stepperValueText6.text]);
    

    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        [controller setSubject:@"Presupuesto"];
        NSString *url = @"http://migueldev.com/freelance/presupuesto.php?v=";
        [controller setMessageBody:[NSString stringWithFormat:@"<br/><br/><a href=\"%@%@\">descargar presupuesto en pdf</a>", url, values] isHTML:YES];
        [self presentModalViewController:controller animated:YES];
        controller.mailComposeDelegate = self;
        
        NSLog(@"%@%@", url, values);
        
    }else{
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Para enviar sugerencias antes tienes que configurar una cuenta de correo" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [someError show];
        
    }
    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissModalViewControllerAnimated:YES];
}


////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[[[[self tabBarController] tabBar] items] objectAtIndex:1] setBadgeValue:@"1"];
    [self sumar];
    [self setBackground];
    

    scrollview.contentSize = CGSizeMake(scrollview.frame.size.width,250);
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];    
    int iva = [prefs integerForKey:@"iva"];
    int irpf = [prefs integerForKey:@"irpf"];
    int precio_hora = [prefs integerForKey:@"precio_hora"];
    NSString *divisa = @"€";
    
    if( !iva ){
        iva = 18;
        irpf = 15;
        precio_hora = 30;
        
        [prefs setInteger:iva forKey:@"iva"];
        [prefs setInteger:irpf forKey:@"irpf"];
        [prefs setObject:divisa forKey:@"divisa"];
        [prefs setObject:@"" forKey:@"email"];
        [prefs setObject:@"" forKey:@"linkedin"];
        [prefs setInteger:precio_hora forKey:@"precio_hora"];
    }
    
    
    self.lblIVA.text = [NSString stringWithFormat:@"IVA %d%%", iva];
    self.lblIRPF.text = [NSString stringWithFormat:@"IPRF %d%%", irpf];
    
    self.stepperValueText1.text = [NSString stringWithFormat:@"%d", precio_hora];
    self.ourStepper1.value = precio_hora;
    
    [self sumar];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
