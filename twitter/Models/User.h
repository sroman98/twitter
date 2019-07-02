//
//  User.h
//  twitter
//
//  Created by sroman98 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

// TODO: Add properties
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSURL *profileImageURL;

// TODO: Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
