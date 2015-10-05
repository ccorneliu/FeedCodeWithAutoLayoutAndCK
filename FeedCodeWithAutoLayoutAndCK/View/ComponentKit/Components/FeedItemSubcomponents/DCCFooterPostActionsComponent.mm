//
//  DCCFooterPostActionsComponent.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 29/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCFooterPostActionsComponent.h"
#import "DCCFeedItem.h"
#import <ComponentKit/ComponentKit.h>
#import "DCCButtonWithCountNumber.h"

@implementation DCCFooterPostActionsComponent

+(instancetype)newWithItemData:(id<DCCFeedItem>)feedItemData context:(id)context {
    UIImage *likeIcon = [UIImage imageNamed:@"likeIcon"];
    NSString *likeTitle = [NSString stringWithFormat:@"%lu Likes", [feedItemData peopleNamesWhoLikedThePost].count];
    
    UIImage *commentIcon = [UIImage imageNamed:@"commentIcon"];
    NSString *commentTitle = [NSString stringWithFormat:@"%lu Comments", [feedItemData numberOfComments]];
    
    UIImage *shareIcon = [UIImage imageNamed:@"shareIcon"];
    NSString *shareTitle = [NSString stringWithFormat:@"%lu Shares", [feedItemData numberOfShares]];
    
    CKComponent *likeComponent = [DCCButtonWithCountNumber newWithImage:likeIcon title:likeTitle];
    CKComponent *commentComponent = [CKStackLayoutComponent
                                     newWithView:{}
                                     size:{}
                                     style:{.alignItems = CKStackLayoutAlignItemsCenter}
                                     children:{
                                         {[DCCButtonWithCountNumber newWithImage:commentIcon title:commentTitle]}
                                     }];
    CKComponent *shareComponent = [DCCButtonWithCountNumber newWithImage:shareIcon title:shareTitle];
    
    return [super newWithComponent:
            [CKStackLayoutComponent
             newWithView:{}
             size:{}
             style:{
                 .direction = CKStackLayoutDirectionHorizontal,
                 .justifyContent = CKStackLayoutJustifyContentCenter
             }
             children:{
                 {
                     likeComponent
                 },
                 {
                     commentComponent,
                     .flexGrow = YES
                 },
                 {
                     shareComponent,
                     .spacingAfter = 10
                 },
             }]];
}

@end
