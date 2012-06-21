//
//  TipsController.m
//  Freelance
//
//  Created by Miquel Camps Ortea on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TipsController.h"

@interface TipsController ()

@end

@implementation TipsController

@synthesize consejo;

////////////////////////////

- (void)setBackground{
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"whitey.png"]];
}


- (BOOL)connectedToNetwork  {
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr*)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return 0;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    //below suggested by Ariel
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    NSURL *testURL = [NSURL URLWithString:@"http://www.apple.com/"]; //comment by friendlydeveloper: maybe use www.google.com
    NSURLRequest *testRequest = [NSURLRequest requestWithURL:testURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
    //NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:nil]; //suggested by Ariel
    NSURLConnection *testConnection = [[NSURLConnection alloc] initWithRequest:testRequest delegate:nil]; //modified by friendlydeveloper
    return ((isReachable && !needsConnection) || nonWiFi) ? (testConnection ? YES : NO) : NO;
}

////////////////////////////

- (IBAction)cargarFrase:(id)sender
{
    [self cargarFrase];
}

- (IBAction)twittearConsejo:(id)sender
{

    if( [TWTweetComposeViewController canSendTweet] ){

        TWTweetComposeViewController *tweet = [[TWTweetComposeViewController alloc] init];
        [tweet setInitialText:self.consejo.text];
        [self presentModalViewController:tweet animated:YES];
        
    }else{
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Para publicar en twitter tienes que configurar una cuenta" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [someError show];
    }
    
}

- (void) cargarFrase
{
    NSString *url = @"http://migueldev.com/freelance/consejos.php";
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // si carga la misma frase, cargar otra
    if( [response isEqualToString: self.consejo.text] )
    {
        [self cargarFrase];
    }else{
        self.consejo.text = response;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setBackground];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
     if ([self connectedToNetwork]) {
        [self cargarFrase];
        [[[[[self tabBarController] tabBar] items] objectAtIndex:1]  setBadgeValue:nil];
     }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Hace falta conexión a internet" delegate: self cancelButtonTitle: @"Cancelar" otherButtonTitles: @"Reintentar", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0){
        consejo.text = @"Error no se pudieron cargar los contenidos";
    }else{
        [self viewDidAppear:YES];
    }
}

@end
