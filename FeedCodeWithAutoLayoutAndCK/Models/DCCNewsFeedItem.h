//
//  DCCSocEntFeedItem.h
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 28/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCFeedItem.h"

@interface DCCNewsFeedItem : NSObject <DCCFeedItem>

@property (nonatomic, strong) NSString *authorAvatar;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *postedTime;
@property (nonatomic, strong) NSArray *postImages;
@property (nonatomic, strong) NSString *postText;
@property (nonatomic, assign) BOOL currentUserLikesThePost;
@property (nonatomic, assign) BOOL featured;
@property (nonatomic, strong) NSArray *peopleNamesWhoLikedThePost;
@property (nonatomic, assign) NSUInteger numberOfComments;
@property (nonatomic, assign) NSUInteger numberOfShares;

@end
