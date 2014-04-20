//
//  TweetSheetViewController.m
//  TwitterClient01
//
//  Created by ともや on 2014/04/19.
//  Copyright (c) 2014年 tomo. All rights reserved.
//

#import "TweetSheetViewController.h"

@interface TweetSheetViewController ()

@end

@implementation TweetSheetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)editEndAction:(id)sender {
    [self.tweetTextView resignFirstResponder];
}
-(IBAction)cancelAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(IBAction)tweetAction:(id)sender{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccount *account =[accountStore accountWithIdentifier:self.identifier];
    NSString *tweetString = self.tweetTextView.text;
    
    NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1.1/statuses/update/json"];
    NSDictionary *params = @{@"status" : tweetString};
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:url parameters:params];
    request.account = account;
    
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    
    [request performRequestWithHandler:^(NSData *responseData,NSHTTPURLResponse *urlResponse,NSError *error){
        if(responseData){
            NSString *httpErrorMessage;
            httpErrorMessage = nil;
            if(urlResponse.statusCode >= 200 && urlResponse.statusCode < 300){
                NSDictionary *postResponseData =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                NSLog(@"[SUCCESS!] Created Tweet with ID: %@",postResponseData[@"id_str"]);
            }
            else{
                httpErrorMessage =
                [NSString stringWithFormat:@"The response status code is @%d",urlResponse.statusCode];
                NSLog(@"HTTP Error: %@",httpErrorMessage);
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIApplication *application = [UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
            [self dismissViewControllerAnimated:YES completion:^{
                NSLog(@"Tweet Sheet has been dismissed.");
            }];
        });
    }];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
