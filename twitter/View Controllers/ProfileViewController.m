//
//  ProfileViewController.m
//  twitter
//
//  Created by sroman98 on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "APIManager.h"
#import "TweetCell.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *tweets;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchTweets];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)fetchTweets {
    // Get timeline
    [[APIManager shared] getUsernameWithCompletion:^(NSString *username, NSError *error) {
        if (username) {
            NSLog(@"😎😎😎 Successfully got username");
            [[APIManager shared] getUserTimelineWithUsername:username withCompletion:^(NSArray *tweetsAPI, NSError *error) {
                if (tweetsAPI) {
                    NSLog(@"😎😎😎 Successfully loaded user timeline");
                    
                    self.tweets = [[NSMutableArray alloc] initWithArray:tweetsAPI];
                    
                    [self.tableView reloadData];
                } else {
                    NSLog(@"😫😫😫 Error getting user timeline: %@", error.localizedDescription);
                }
            }];
            
            
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweet = self.tweets[indexPath.row];
    [cell configureCell:tweet];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

@end
