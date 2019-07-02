//
//  TweetCell.m
//  twitter
//
//  Created by sroman98 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(Tweet*)tweet {
    self.tweetTextLabel.text = tweet.text;
    self.createdAtLabel.text = tweet.createdAtString;
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.likeLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    
    User *user = tweet.user;
    self.nameLabel.text = user.name;
    NSString *screenNameWithAt = @"@";
    self.screenNameLabel.text = [screenNameWithAt stringByAppendingString:user.screenName];
    
    self.profileImageView.image = nil;
    [self.profileImageView setImageWithURL:user.profileImageURL];
}

@end
