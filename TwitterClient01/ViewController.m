//
//  ViewController.m
//  TwitterClient01
//
//  Created by ともや on 2014/04/12.
//  Copyright (c) 2014年 tomo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//@property (weak, nonatomic) IBOutlet UIButton *tweetActionBotton; ツイートボタンラベルの変更はあまりないので、一応コメントアウト
@property (weak, nonatomic) IBOutlet UILabel *accountDisplayLabel;
@property ACAccountStore * accountStore;
@property NSString *identifier;
@property NSArray *twitterAccounts;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.accountStore = [[ACAccountStore alloc] init];
    ACAccountType *twitterType =
    [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self.accountStore requestAccessToAccountsWithType:twitterType options:NULL completion:^(BOOL granted, NSError *error){
        if (granted) {
            self.twitterAccounts = [self.accountStore accountsWithAccountType:twitterType];
            if (self.twitterAccounts.count > 0) {
                
                ACAccount *account = [self.twitterAccounts objectAtIndex:0];
                self.identifier = account.identifier;
                dispatch_async(dispatch_get_main_queue(),^{
                    self.accountDisplayLabel.text = account.username;
                });
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.accountDisplayLabel.text = @"アカウントなし";
                });
            }
        }
        else{
            NSLog(@"Account Error: %@", [error localizedDescription]);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.accountDisplayLabel.text = @"アカウント認証エラー";
            });
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tweetAction:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        NSString *serviceType = SLServiceTypeTwitter;
        SLComposeViewController *composeCtl = [SLComposeViewController
                                               composeViewControllerForServiceType:serviceType];
        [composeCtl setCompletionHandler:^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultDone) {
                //投稿成功時の処理
            }
        }];
        
        [self presentViewController:composeCtl animated:YES completion:NULL];
    }
}
- (IBAction)setAccountAction:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] init];
    sheet.delegate = self;
    
    sheet.title = @"選択してください。";
    for(ACAccount *account in self.twitterAccounts){
        [sheet addButtonWithTitle:account.username];
    }
        [sheet addButtonWithTitle:@"キャンセル"];
        sheet.cancelButtonIndex = self.twitterAccounts.count;
        sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [sheet showInView:self.view];
    }
    - (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
        if (self.twitterAccounts.count > 0) {
            if(buttonIndex != self.twitterAccounts.count){
                ACAccount *account = self.twitterAccounts[buttonIndex];
                self.identifier = account.identifier;
                self.accountDisplayLabel.text = account.username;
                NSLog(@"Account set! %@", account.username);
            }
            else{
                NSLog(@"cansel!");
            }
        }
    }

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"TimeLineSegue"]){
        TimeLineTableViewController *timeLineTableViewController =
        [segue destinationViewController];
        if([timeLineTableViewController isKindOfClass:[TimeLineTableViewController class]]) {
            timeLineTableViewController.identifier = self.identifier;
        }
    }
    
    if ([[segue identifier] isEqualToString:@"DirectMessagesSegue"]){
        DirectMessagesTableViewController *directmessagesTableViewController =
        [segue destinationViewController];
        if([directmessagesTableViewController isKindOfClass:[DirectMessagesTableViewController class]]) {
            directmessagesTableViewController.identifier = self.identifier;
        }
    }

}


@end
