//
//  DCCPostHeaderComponent.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 28/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCFeedItemComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "DCCFeedItem.h"

#import "DCCHeaderComponent.h"
#import "DCCImageWithPossibleOverlayText.h"
#import "DCCTextComponent.h"
#import "DCCFooterPostActionsComponent.h"

@implementation DCCFeedItemComponent

+(instancetype)newWithData:(id<DCCFeedItem>)feedItemData context:(id)context {
    //step 1. demo a simple component
    
    //step 2. create component item header
    
    //step 3. create report button action
    
    CGFloat componentWidth = [[context objectForKey:@"componentWidth"] doubleValue];
    return [super newWithComponent:
            [CKStackLayoutComponent
             newWithView:{}
             size:{.width = componentWidth}
             style:{
                 .spacing = 10
             }
             children:{
                 {
                     [DCCHeaderComponent
                      newWithFeedItemData:feedItemData
                      context:context],
                     .alignSelf = CKStackLayoutAlignSelfCenter
                 },
                 {
                     [DCCImageWithPossibleOverlayText newWithFeedItemData:feedItemData context:context],
                 },
                 {
                     [DCCTextComponent newWithText:[feedItemData postText] context:context],
                     .alignSelf = CKStackLayoutAlignSelfCenter
                 },
                 {
                     [DCCFooterPostActionsComponent newWithItemData:feedItemData context:context],
                     .alignSelf = CKStackLayoutAlignSelfStretch
                 },
                 {
                     [DCCTextComponent newWithText:[[feedItemData peopleNamesWhoLikedThePost] componentsJoinedByString:@", "] context:context],
                     .alignSelf = CKStackLayoutAlignSelfCenter,
                     .spacingAfter = 50
                 },
             }]
            ];
}

@end
