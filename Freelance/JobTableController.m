//
//  JobTableController.m
//  Freelance
//
//  Created by Miquel Camps Ortea on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JobTableController.h"
#import "JobViewController.h"


@interface JobTableController ()

@end

@implementation JobTableController

@synthesize tableView;

////////////////////////


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

////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    connected = FALSE;
}




- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

    if ( connected == FALSE ) {
        
        connected = [self connectedToNetwork];

        if( connected ){
            
            
            [SVProgressHUD show];
            
            NSString *url = @"http://migueldev.com/freelance/trabajos.php";
       
         
            // fill table
            arrayC = [[NSMutableArray alloc] init];

            
            
            NSData *tweets = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            NSInputStream *twitterStream = [[NSInputStream alloc] initWithData:tweets];
            [twitterStream open];
            
            if (twitterStream) {
                
                
            
                NSError *parseError = nil;
                id jsonObject = [NSJSONSerialization JSONObjectWithStream:twitterStream options:NSJSONReadingAllowFragments error:&parseError];
                
                
                NSArray *items = [[jsonObject objectForKey:@"response"] objectForKey:@"jobs"];
                for (NSDictionary *tweet in items) {
                    
                    
                    
                    NSLog(@"%@",[tweet objectForKey:@"title"]);
                    
                    
                    
                    [arrayC addObject:tweet];

                    
                }
                
                [tableView reloadData]; 
                
                
                [SVProgressHUD dismiss];

            } else {
                NSLog(@"Failed to open stream.");
            }
        
        
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Hace falta conexión a internet" delegate: self cancelButtonTitle: @"Cancelar" otherButtonTitles: @"Reintentar", nil];
            [alert show];
        }
            
            
    }

}


- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
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



//////////////


// tabla
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return[arrayC count];
}
- (UITableViewCell *)tableView:(UITableView *)tabla cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tabla dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	NSString *cellValue =[[arrayC objectAtIndex:indexPath.row] objectForKey:@"title"];
	cell.textLabel.text = cellValue ;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"getJob" sender:indexPath];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"getJob"]) 
    {
        JobViewController *destination = [segue destinationViewController];
        NSIndexPath * indexPath = (NSIndexPath*)sender;
        

        
        destination.job = [arrayC objectAtIndex:[indexPath row]];
    }
}



- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0){
        [self viewDidAppear:YES];
    }
}

- (IBAction)info:(id)sender
{
    UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Información" message: @"Las ofertas de empleo se dan de alta en http://dir.betabeers.com" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [someError show];
}

@end