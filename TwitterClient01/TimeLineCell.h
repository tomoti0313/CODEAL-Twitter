//
//  TimeLineCell.h
//  TwitterClient01
//
//  Created by ともや on 2014/04/12.
//  Copyright (c) 2014年 tomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLineCell : UITableViewCell

@property UILabel *tweetTextLabel;
@property UILabel *nameLabel;
@property UILabel *jnameLabel;
@property UILabel *timeLabel;
@property UIImageView *profileImageView;
@property UIImage *image;
@property int tweetTextLabelHeight;

@end
