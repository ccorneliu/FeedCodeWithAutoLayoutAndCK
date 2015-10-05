//
//  DCCSocEntFeedViewModel.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 27/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCNewsFeedViewModel.h"
#import "DCCNewsFeedItem.h"

@interface DCCNewsFeedViewModel() {
    NSMutableArray *_feedItems;
}

@end

@implementation DCCNewsFeedViewModel

-(instancetype)init {
    self = [super init];
    if (self) {
        [self createData];
    }
    return self;
}

-(void)createData {
    _feedItems = [NSMutableArray array];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"News" ofType:@"plist"];
    NSArray *rawFeedItems = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *rawFeedItem in rawFeedItems) {
        DCCNewsFeedItem *feedItem = [[DCCNewsFeedItem alloc] init];
        NSString *authorAvatar = rawFeedItem[@"authorAvatar"];
        if (authorAvatar.length) {
            feedItem.authorAvatar = authorAvatar;
        }
        feedItem.authorName = rawFeedItem[@"authorName"];
        feedItem.postedTime = rawFeedItem[@"postedTime"];
        NSArray *postImages = rawFeedItem[@"postImages"];
        if (postImages.count) {
            feedItem.postImages = postImages;
        }
        feedItem.postText = rawFeedItem[@"postText"];
        feedItem.currentUserLikesThePost = [rawFeedItem[@"liked"] boolValue];
        feedItem.featured = [rawFeedItem[@"featured"] boolValue];
        NSArray *whoLiked = rawFeedItem[@"whoLikedThePost"];
        feedItem.peopleNamesWhoLikedThePost = whoLiked;
        feedItem.numberOfComments = [rawFeedItem[@"numberOfComments"] integerValue];
        feedItem.numberOfComments = [rawFeedItem[@"numberOfShares"] integerValue];
        [self addFeedItem:feedItem];
    }
}

#pragma mark - KVC compliance

+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    return ![key isEqualToString:NSStringFromSelector(@selector(feedItems))];
}

-(NSArray *)feedItems {
    return [_feedItems copy];
}

-(void)addFeedItem:(id)feedItem {
    NSUInteger indexToAddTo = _feedItems.count;
    [self insertFeedItem:feedItem atIndex:indexToAddTo];
}

-(void)insertFeedItem:(id)feedItem atIndex:(NSUInteger)indexToInsertTo {
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:indexToInsertTo];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:NSStringFromSelector(@selector(feedItems))];
    [_feedItems insertObject:feedItem atIndex:indexToInsertTo];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:NSStringFromSelector(@selector(feedItems))];
}

-(void)removeFeedItemAtIndex:(NSUInteger)indexToRemove {
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:indexToRemove];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:NSStringFromSelector(@selector(feedItems))];
    [_feedItems removeObjectAtIndex:indexToRemove];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:NSStringFromSelector(@selector(feedItems))];
}

-(void)updateFeedItemAtIndex:(NSUInteger)indexToUpdate withFeedItem:(id)feedItem {
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:indexToUpdate];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:NSStringFromSelector(@selector(feedItems))];
    [_feedItems replaceObjectAtIndex:indexToUpdate withObject:feedItem];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:NSStringFromSelector(@selector(feedItems))];
}

@end
