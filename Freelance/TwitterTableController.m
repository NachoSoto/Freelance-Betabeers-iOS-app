//
//  TwitterTableController.m
//  Freelance
//
//  Created by Miquel Camps Ortea on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TwitterTableController.h"
#import "SimpleTableCell.h"


@interface TwitterTableController ()

@end

@implementation TwitterTableController

@synthesize tableView;

////////////////////

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

- (void) refreshTweets
{
    
    
    
    [SVProgressHUD show];
    
    
    NSString *hashtag = @"freesos";
    int limit = 30;
    
    
    //freesos
    NSString *url = [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%%23%@%%20-RT&rpp=%d&include_entities=true&result_type=recent", hashtag, limit];
    
    
    // fill table
    arrayC = [[NSMutableArray alloc] init];
    
    
    NSData *tweets = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSInputStream *twitterStream = [[NSInputStream alloc] initWithData:tweets];
    [twitterStream open];
    
    if (twitterStream) {
        
        
        
        
        
        NSError *parseError = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithStream:twitterStream options:NSJSONReadingAllowFragments error:&parseError];

        
        NSArray *items = [jsonObject objectForKey:@"results"];
        for (NSDictionary *tweet in items) {
            
            
            
            NSLog(@"%@",[tweet objectForKey:@"text"]);
            
            
            
            [arrayC addObject:tweet];

            
        }
        
        [tableView reloadData]; 
        [SVProgressHUD dismiss];

    } else {
        NSLog(@"Failed to open stream.");
    }
    
    
}


- (IBAction)newTweet:(id)sender
{
 
    if( [TWTweetComposeViewController canSendTweet] ){
        
        
        TWTweetComposeViewController *tweet = [[TWTweetComposeViewController alloc] init];
        [tweet setInitialText:@"#freesos "];
        [self presentModalViewController:tweet animated:YES];
        
    }else{
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Para publicar en twitter tienes que configurar una cuenta" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [someError show];
        
    }
    
}
- (IBAction)refreshTweet:(id)sender{
    [self refreshTweets];
}


- (void)viewDidLoad
{
    [super viewDidLoad];


    
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2){
        isRetina = YES;
    } else {
        isRetina = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    

    
    [super viewDidAppear:animated];
    
    
    if ( [self connectedToNetwork] ) {
    
        [self refreshTweets];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Hace falta conexión a internet" delegate: self cancelButtonTitle: @"Cancelar" otherButtonTitles: @"Reintentar", nil];
        [alert show];
    }
}






- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

//////////////


// tabla
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return[arrayC count];
}

- (UITableViewCell *)tableView:(UITableView *)tabla cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        
    
    if (cell == nil) 
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
        cell.prepTimeLabel.font = [UIFont systemFontOfSize:15];
        cell.prepTimeLabel.numberOfLines = 0;
        
    } 
    
    
    
    NSString *avatar_url = [[arrayC objectAtIndex:indexPath.row] objectForKey:@"profile_image_url"];
    
    if( isRetina == YES ){
        avatar_url = [avatar_url stringByReplacingOccurrencesOfString:@"_normal" withString:@"_reasonably_small"];
    }
    
    
    NSLog(@"%@",avatar_url);
    
    [cell.thumbnailImageView setImageWithURL:[NSURL URLWithString:[[arrayC objectAtIndex:indexPath.row] objectForKey:@"profile_image_url"]]  placeholderImage:[UIImage imageNamed:@"twitter.png"]];
    




	cell.nameLabel.text = [[arrayC objectAtIndex:indexPath.row] objectForKey:@"from_user"];

    cell.prepTimeLabel.text = [[arrayC objectAtIndex:indexPath.row] objectForKey:@"text"];
    
    
    cell.prepTimeLabel.numberOfLines = 0;
    [cell.prepTimeLabel sizeToFit];
    
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    

    if( [TWTweetComposeViewController canSendTweet] ){
        
        NSString *mensaje = [NSString stringWithFormat:@"@%@ ", [[arrayC objectAtIndex:indexPath.row] objectForKey:@"from_user"]];
        TWTweetComposeViewController *tweet = [[TWTweetComposeViewController alloc] init];
        [tweet setInitialText:mensaje];
        [self presentModalViewController:tweet animated:YES];
        
    }else{
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Para publicar en twitter tienes que configurar una cuenta" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [someError show];
        
    }
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 125;
    

    NSString *cellValue =[[arrayC objectAtIndex:indexPath.row] objectForKey:@"text"];
    
    CGSize size = [cellValue 
                   sizeWithFont:[UIFont systemFontOfSize:16] 
                   constrainedToSize:CGSizeMake(300, CGFLOAT_MAX)];
    
    
    
    
    return size.height + 50;
    
    
 
    
}


////////////////////////////


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0){
        //consejo.text = @"Error no se pudieron cargar los contenidos";
    }else{
        [self viewDidAppear:YES];
    }
}


@end
