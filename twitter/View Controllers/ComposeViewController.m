//
//  ComposeViewController.m
//  twitter
//
//  Created by sroman98 on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (strong, nonatomic) NSString *placeholderText;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tweetTextView.delegate = self;
    
    self.placeholderText = @"What's happening?";
    
    self.tweetTextView.text = self.placeholderText;
    self.tweetTextView.textColor = [UIColor lightGrayColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tapClose:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tapTweet:(UIBarButtonItem *)sender {
    NSString *tweetText = self.tweetTextView.text;
    
    [[APIManager shared]postStatusWithText:tweetText completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // Set the max character limit
    unsigned long characterLimit = 140;
    
    // TODO: Check the proposed new text character count
    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.tweetTextView.text stringByReplacingCharactersInRange:range withString:text];
    
    // TODO: Update Character Count Label
    int charactersLeft = (int)characterLimit - (int)newText.length;
    if(newText.length <= characterLimit) {
        self.countLabel.text = [NSString stringWithFormat:@"%d", charactersLeft];
        // Allow or disallow the new text
        return YES;
    }
    
    return NO;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:self.placeholderText]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = self.placeholderText;
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

@end
