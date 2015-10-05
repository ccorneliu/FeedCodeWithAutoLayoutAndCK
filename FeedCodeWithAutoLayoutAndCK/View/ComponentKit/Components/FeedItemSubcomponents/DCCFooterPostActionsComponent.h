//
//  DCCFooterPostActionsComponent.h
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 29/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "CKCompositeComponent.h"

@protocol DCCFeedItem;

@interface DCCFooterPostActionsComponent : CKCompositeComponent

+(instancetype)newWithItemData:(id<DCCFeedItem>)feedItemData context:(id)context;

@end
