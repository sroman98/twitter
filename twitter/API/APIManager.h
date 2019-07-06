//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion;

- (void)favorite:(Tweet *)tweet do:(NSString *)action completion:(void (^)(Tweet *, NSError *))completion;
- (void)retweet:(Tweet *)tweet do:(NSString *)action completion:(void (^)(Tweet *, NSError *))completion;

- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion;
- (void)getUsernameWithCompletion:(void(^)(NSString *username, NSError *error))completion;
- (void)getUserTimelineWithUsername:(NSString*)username withCompletion:(void(^)(NSArray *tweets, NSError *error))completion;

@end
