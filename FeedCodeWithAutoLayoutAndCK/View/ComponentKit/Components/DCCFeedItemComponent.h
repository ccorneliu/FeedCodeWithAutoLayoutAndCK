//
//  DCCPostHeaderComponent.h
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 28/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "CKCompositeComponent.h"

@protocol DCCFeedItem;

@interface DCCFeedItemComponent : CKCompositeComponent

+(instancetype)newWithData:(id<DCCFeedItem>)feedItemData context:(id)context;

@end
