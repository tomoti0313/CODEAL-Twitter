//
//  TimeLineCell.m
//  TwitterClient01
//
//  Created by ともや on 2014/04/12.
//  Copyright (c) 2014年 tomo. All rights reserved.
//

#import "TimeLineCell.h"

@implementation TimeLineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.tweetTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.tweetTextLabel.font = [UIFont fontWithName:@"CourierNewPS-BoldItalicMT" size:12.0f];
        self.tweetTextLabel.textColor = [UIColor blackColor];
        self.tweetTextLabel.numberOfLines = 0;
        //self.tweetTextLabel.highlightedTextColor = [UIColor blueColor];
        [self.contentView addSubview:self.tweetTextLabel];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLabel.font = [UIFont systemFontOfSize:10.0f];
        self.nameLabel.textColor = [UIColor blueColor];
        //self.nameLabel.highlightedTextColor = [UIColor blueColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.jnameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.jnameLabel.font = [UIFont systemFontOfSize:10.0f];
        self.jnameLabel.textColor = [UIColor grayColor];
        //self.jnameLabel.highlightedTextColor = [UIColor blueColor];
        [self.contentView addSubview:self.jnameLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.timeLabel.font = [UIFont systemFontOfSize:10.0f];
        self.timeLabel.textColor = [UIColor grayColor];
        //self.timeLabel.highlightedTextColor = [UIColor blueColor];
        [self.contentView addSubview:self.timeLabel];
        
        self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.profileImageView.image = self.image;
        [self.contentView addSubview:self.profileImageView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.profileImageView.frame = CGRectMake(5,5,48,48);
    self.tweetTextLabel.frame = CGRectMake(58, 23, 257, self.tweetTextLabelHeight);
    self.nameLabel.frame = CGRectMake(58, 13, 257, 15);
    self.jnameLabel.frame = CGRectMake(58,3,257,15);
    self.timeLabel.frame = CGRectMake(200, 3, 115, 15);
}

-(void)setSelected:(BOOL)selected animater:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    //Confiqure the view for the selected state
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
