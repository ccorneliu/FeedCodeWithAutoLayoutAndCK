//
//  DCCFeedItem.h
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 28/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

@protocol DCCFeedItem <NSObject>

@property (nonatomic, strong, readonly) NSString *authorAvatar;
@property (nonatomic, strong, readonly) NSString *authorName;
@property (nonatomic, strong, readonly) NSString *postedTime;
@property (nonatomic, strong, readonly) NSArray *postImages;
@property (nonatomic, strong, readonly) NSString *postText;
@property (nonatomic, assign, readonly) BOOL currentUserLikesThePost;
@property (nonatomic, assign, readonly) BOOL featured;
@property (nonatomic, strong, readonly) NSArray *peopleNamesWhoLikedThePost;
@property (nonatomic, assign, readonly) NSUInteger numberOfComments;
@property (nonatomic, assign, readonly) NSUInteger numberOfShares;

@end
