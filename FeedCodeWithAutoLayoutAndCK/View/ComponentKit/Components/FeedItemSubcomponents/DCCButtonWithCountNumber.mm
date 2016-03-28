//
//  DCCHighlightableButtonWithCountNumber.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 29/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCButtonWithCountNumber.h"
#import <ComponentKit/ComponentKit.h>

@implementation DCCButtonWithCountNumber

+(instancetype)newWithImage:(UIImage *)image
                      title:(NSString *)buttonTitle {
    
    return [super newWithComponent:
            [CKStackLayoutComponent
             newWithView:{}
             size:{}
             style:{
                 .direction = CKStackLayoutDirectionHorizontal
             }
             children:{
                 {
                     [CKButtonComponent
                      newWithTitles:{}
                      titleColors:{}
                      images:{{UIControlStateNormal, image}}
                      backgroundImages:{}
                      titleFont:nil
                      selected:NO
                      enabled:YES
                      action:nil
                      size:{.width = 44, .height = 44}
                      attributes:{}
                      accessibilityConfiguration:{}]
                 },
                 {
                     [CKTextComponent
                      newWithTextAttributes:{
                          .attributedString = [[NSAttributedString alloc] initWithString:buttonTitle attributes:@{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote], NSForegroundColorAttributeName:[UIColor blackColor]}]
                      }
                      viewAttributes:{}
                      accessibilityContext:{}
                      size:{}],
                     .spacingBefore = -7.0f,
                     .alignSelf = CKStackLayoutAlignSelfCenter
                 }
             }]];
}

@end
