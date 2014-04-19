//
//  MyUIApplication.m
//  TwitterClient01
//
//  Created by ともや on 2014/04/19.
//  Copyright (c) 2014年 tomo. All rights reserved.
//

#import "MyUIApplication.h"

@implementation MyUIApplication
{
    
}
-(BOOL)openURL:(NSURL *)url{
    if(!url){
        return NO;
    }
    
    self.myOpenURL = url;
    AppDelegate *appDelegate = (AppDelegate *)[self delegate];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
        WebViewController *WebViewController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        WebViewController.openURL = self.myOpenURL;
        WebViewController.title = @"Web View";
        
        [appDelegate.navigationController pushViewController:WebViewController animated:YES];
        self.myOpenURL = nil;
        
        return YES;
    
}

@end
