//
//  TweetCell.m
//  twitter
//
//  Created by sroman98 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

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
    self.tweet = tweet;
    
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

- (IBAction)didTapLike:(id)sender {
    // TODO: Update the local tweet model
    NSString *fav = @"create";
    self.tweet.favorited = !self.tweet.favorited;
    if(self.tweet.favorited) {
        self.tweet.favoriteCount += 1;
    } else {
        self.tweet.favoriteCount -= 1;
        fav = @"destroy";
    }
    // TODO: Update cell UI
    [self refreshData];
    // TODO: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet do:fav completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error %@ favorite tweet: %@", fav, error.localizedDescription);
        }
        else{
            NSLog(@"Successfully %@ favorite to Tweet: %@", fav, tweet.text);
        }
    }];
}

- (IBAction)didTapRetweet:(id)sender {
    // TODO: Update the local tweet model
    NSString *rt = @"retweet";
    self.tweet.retweeted = !self.tweet.retweeted;
    if(self.tweet.retweeted) {
        self.tweet.retweetCount += 1;
    } else {
        self.tweet.retweetCount -= 1;
        rt = @"unretweet";
    }
    // TODO: Update cell UI
    [self refreshData];
    // TODO: Send a POST request to the POST retweets/create endpoint
    [[APIManager shared] retweet:self.tweet do:rt completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error %@ tweet: %@", rt, error.localizedDescription);
        }
        else{
            NSLog(@"Successfully %@ the following Tweet: %@", rt, tweet.text);
        }
    }];
}

- (void)refreshData {
    if(self.tweet.favorited) {
        [self.likeButton setSelected:YES];
    } else {
        [self.likeButton setSelected:NO];
    }
    if(self.tweet.retweeted) {
        [self.retweetButton setSelected:YES];
    } else {
        [self.retweetButton setSelected:NO];
    }
    
    self.likeLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
}


@end
