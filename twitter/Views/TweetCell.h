//
//  TweetCell.h
//  twitter
//
//  Created by sroman98 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView; 
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; //
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel; //
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel; //
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel; //
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel; //
@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel; //

@property (strong, nonatomic) Tweet *tweet;

- (void)configureCell:(Tweet *)tweet;

@end

NS_ASSUME_NONNULL_END
