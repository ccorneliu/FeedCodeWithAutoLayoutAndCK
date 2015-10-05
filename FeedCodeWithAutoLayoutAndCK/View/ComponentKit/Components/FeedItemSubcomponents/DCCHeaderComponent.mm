//
//  DCCHeaderComponent.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 29/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCHeaderComponent.h"
#import <ComponentKit/ComponentKit.h>

#import "DCCAvatarImageComponent.h"
#import "DCCHeaderTitleAndSubtitleComponent.h"
#import "DCCFeedItem.h"

#define DCC_AVATAR_DIMENSION 56.0f
#define DCC_REPORT_BUTTON_DIMENSION 30.0f
#define DCC_SPACE_BETWEEN_ELEMENTS 10.0f
#define DCC_HEADER_MARGIN 10.0f

@interface DCCHeaderComponent() {
    id _context;
    id _feedItemData;
}
@end

@implementation DCCHeaderComponent

+(instancetype)newWithFeedItemData:(id<DCCFeedItem>)feedItemData
                           context:(id)context {
    
    CGFloat componentWidth = [[context objectForKey:@"componentWidth"] doubleValue];
    
    DCCAvatarImageComponent *avatarComponent = [DCCAvatarImageComponent
                                                newWithImage:[UIImage imageNamed:[feedItemData authorAvatar]]
                                                size:{.width = DCC_AVATAR_DIMENSION, .height = DCC_AVATAR_DIMENSION}
                                                cornerRadius:DCC_AVATAR_DIMENSION / 2.0f];
    
    DCCHeaderTitleAndSubtitleComponent *titleAndSubtitleComponent = [DCCHeaderTitleAndSubtitleComponent
                                                                     newWithTitle:[feedItemData authorName]
                                                                     subtitle:[feedItemData postedTime]
                                                                     componentWidth:componentWidth - DCC_AVATAR_DIMENSION - 2 * DCC_SPACE_BETWEEN_ELEMENTS - DCC_REPORT_BUTTON_DIMENSION - 2 * DCC_HEADER_MARGIN];
    CKButtonComponent *reportButtonComponent = [CKButtonComponent
                                                newWithTitles:{}
                                                titleColors:{}
                                                images:{{UIControlStateNormal, [UIImage imageNamed:@"reportIcon"]}}
                                                backgroundImages:{}
                                                titleFont:nil
                                                selected:NO
                                                enabled:YES
                                                action:@selector(didTapOnReportButton:)
                                                size:{.width = DCC_REPORT_BUTTON_DIMENSION, .height = DCC_REPORT_BUTTON_DIMENSION}
                                                attributes:{}
                                                accessibilityConfiguration:{}];
    
    DCCHeaderComponent *headerComponent = [super newWithComponent:
                                           [CKStackLayoutComponent
                                            newWithView:{}
                                            size:{.width = componentWidth - 2 * DCC_HEADER_MARGIN}
                                            style:{
                                                .direction = CKStackLayoutDirectionHorizontal,
                                                .spacing = DCC_SPACE_BETWEEN_ELEMENTS
                                            }
                                            children:{
                                                {avatarComponent},
                                                {
                                                    titleAndSubtitleComponent,
                                                    .alignSelf = CKStackLayoutAlignSelfCenter
                                                },
                                                {reportButtonComponent}
                                            }]];
    headerComponent->_context = context;
    headerComponent->_feedItemData = feedItemData;
    return headerComponent;
}

-(void)didTapOnReportButton:(id)sender {
    if ([self->_context isKindOfClass:[NSDictionary class]]) {
        NSDictionary *contextDict = (NSDictionary *)self->_context;
        NSString *selectorString = [contextDict objectForKey:@"reportAction"];
        SEL selector = NSSelectorFromString(selectorString);
        CKComponentActionSend(CKComponentAction(selector), self, self->_feedItemData, CKComponentActionSendBehaviorStartAtSenderNextResponder);
    }
}

@end
