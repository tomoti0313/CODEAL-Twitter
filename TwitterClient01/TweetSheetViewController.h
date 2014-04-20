//
//  TweetSheetViewController.h
//  TwitterClient01
//
//  Created by ともや on 2014/04/19.
//  Copyright (c) 2014年 tomo. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIkit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface TweetSheetViewController : ViewController

@property IBOutlet UITextView *tweetTextView;
@property ACAccountStore *accountStore;
@property NSString *identifier;

-(IBAction)editEndAction:(id)sender;
-(IBAction)tweetAction:(id)sender;
@end
