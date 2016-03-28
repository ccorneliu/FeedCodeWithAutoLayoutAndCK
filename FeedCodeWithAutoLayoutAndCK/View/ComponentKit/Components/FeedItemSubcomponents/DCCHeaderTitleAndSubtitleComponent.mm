//
//  DCCHeaderTitleAndSubtitleComponent.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 29/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCHeaderTitleAndSubtitleComponent.h"
#import <ComponentKit/ComponentKit.h>

@implementation DCCHeaderTitleAndSubtitleComponent

+(instancetype)newWithTitle:(NSString *)title
                   subtitle:(NSString *)subtitle
             componentWidth:(CGFloat)componentWidth {
    
    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    UIFont *subtitleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    
    return [super newWithComponent:
            [CKStackLayoutComponent
             newWithView:{}
             size:{.width = componentWidth}
             style:{}
             children:{
                 {
                     [CKTextComponent
                      newWithTextAttributes:{
                          .attributedString = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:titleFont, NSForegroundColorAttributeName:[UIColor blackColor]}],
                      }
                      viewAttributes:{
                          {@selector(setBackgroundColor:), [UIColor clearColor]}
                      }
                      accessibilityContext:{}
                      size:{}]
                 },
                 {
                     [CKTextComponent
                      newWithTextAttributes:{
                          .attributedString = [[NSAttributedString alloc] initWithString:subtitle attributes:@{NSFontAttributeName:subtitleFont, NSForegroundColorAttributeName:[UIColor lightGrayColor]}],
                      }
                      viewAttributes:{
                          {@selector(setBackgroundColor:), [UIColor clearColor]}
                      }
                      accessibilityContext:{}
                      size:{}]
                 }
             }]];
}

@end
