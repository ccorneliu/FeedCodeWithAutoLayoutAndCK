//
//  DCCFeedViewModel.h
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 28/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCObservableObject.h"
#import "DCCFeedItem.h"

@protocol DCCFeedViewModel <DCCObservableObject>

@property (nonatomic, strong, readonly) NSArray *feedItems; // contains id<DCCFeedItems>

@end
