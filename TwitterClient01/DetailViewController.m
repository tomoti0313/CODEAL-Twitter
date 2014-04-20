//
//  DetailViewController.m
//  TwitterClient01
//
//  Created by ともや on 2014/04/19.
//  Copyright (c) 2014年 tomo. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *nameView;
@property (weak, nonatomic) IBOutlet UITextView *jnameView;
@property (weak, nonatomic) IBOutlet UITextView *timeView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation DetailViewController

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
    self.navigationItem.title =@"ツイート";
    self.imageView.image = self.image;
    self.nameView.text = self.name;
    self.jnameView.text = self.jname;
    self.timeView.text = self.time;
    self.textView.text = self.text;
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

    //RTボタン
- (IBAction)retweetAction:(id)sender {
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccount *account = [accountStore accountWithIdentifier:self.identifier]; //アカウント情報の引き継ぎ
    NSString *urlString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/statuses/retweet/%@.json",self.idStr];
    NSURL *url = [NSURL URLWithString:urlString];
    
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:url parameters:nil];
    [request setAccount:account];
    
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    
    [request performRequestWithHandler:^(NSData *responseData,NSHTTPURLResponse *urlResponse,NSError *error){
        if(responseData){
            NSInteger statusCode = urlResponse.statusCode;
            if(statusCode >= 200 && statusCode < 300){
                NSDictionary *postResponseData =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                NSLog(@"[SUCCESS!] Created Tweet with ID: %@",postResponseData[@"id_str"]);
                }
                else{
                    NSLog(@"[ERROR] Server responded: status code %1d %@",statusCode,[NSHTTPURLResponse localizedStringForStatusCode:statusCode]);
                }
            }
            else{
                NSLog(@"[ERROR] An error occurred while posting: %@", [error localizedDescription]);
            }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIApplication *application = [UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
        });
    }];

}

    //ふぁぼボタン
- (IBAction)favoriteAction:(id)sender {
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccount *account = [accountStore accountWithIdentifier:self.identifier]; //アカウント情報の引き継ぎ
    NSString *urlString = [NSString stringWithFormat:@"https://api.twitter.com/1/favorites/create/%@.json",self.idStr];
    NSURL *url = [NSURL URLWithString:urlString];
    
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:url parameters:nil];
    [request setAccount:account];
    
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    
    [request performRequestWithHandler:^(NSData *responseData,NSHTTPURLResponse *urlResponse,NSError *error){
        if(responseData){
            NSInteger statusCode = urlResponse.statusCode;
            if(statusCode >= 200 && statusCode < 300){
                NSDictionary *postResponseData =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                NSLog(@"[SUCCESS!] Created Tweet with ID: %@",postResponseData[@"id_str"]);
            }
            else{
                NSLog(@"[ERROR] Server responded: status code %1d %@",statusCode,[NSHTTPURLResponse localizedStringForStatusCode:statusCode]);
            }
        }
        else{
            NSLog(@"[ERROR] An error occurred while posting: %@", [error localizedDescription]);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIApplication *application = [UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
        });
    }];
    

}
    //ふぁぼをやめるボタン
- (IBAction)destryAction:(id)sender {
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccount *account = [accountStore accountWithIdentifier:self.identifier];
    NSString *urlString = [NSString stringWithFormat:@"https://api.twitter.com/1/favorites/destroy/%@.json",self.idStr];
    NSURL *url = [NSURL URLWithString:urlString];
    
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:url parameters:nil];
    [request setAccount:account];
    
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    
    [request performRequestWithHandler:^(NSData *responseData,NSHTTPURLResponse *urlResponse,NSError *error){
        if(responseData){
            NSInteger statusCode = urlResponse.statusCode;
            if(statusCode >= 200 && statusCode < 300){
                NSDictionary *postResponseData =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
                NSLog(@"[SUCCESS!] Created Tweet with ID: %@",postResponseData[@"id_str"]);
            }
            else{
                NSLog(@"[ERROR] Server responded: status code %1d %@",statusCode,[NSHTTPURLResponse localizedStringForStatusCode:statusCode]);
            }
        }
        else{
            NSLog(@"[ERROR] An error occurred while posting: %@", [error localizedDescription]);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIApplication *application = [UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
        });
    }];
}


@end
