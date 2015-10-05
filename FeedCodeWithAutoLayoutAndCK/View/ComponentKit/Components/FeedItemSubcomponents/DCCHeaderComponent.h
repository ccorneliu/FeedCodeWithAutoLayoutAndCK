//
//  DCCHeaderComponent.h
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 29/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "CKCompositeComponent.h"

@protocol DCCFeedItem;

@interface DCCHeaderComponent : CKCompositeComponent

+(instancetype)newWithFeedItemData:(id<DCCFeedItem>)feedItemData
                           context:(id)context;

@end
