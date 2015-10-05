//
//  DCCTextComponent.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 29/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCTextComponent.h"
#import <ComponentKit/ComponentKit.h>

@implementation DCCTextComponent

+(instancetype)newWithText:(NSString *)postText context:(id)context {
    CGFloat componentWidth = [[context objectForKey:@"componentWidth"] doubleValue];
    return [super newWithComponent:
            [CKStackLayoutComponent
             newWithView:{}
             size:{.width = componentWidth - 20}
             style:{}
             children:{
                 {[CKTextComponent
                   newWithTextAttributes:{
                       .attributedString = [[NSAttributedString alloc] initWithString:postText attributes:@{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody], NSForegroundColorAttributeName:[UIColor blackColor]}],
                   }
                   viewAttributes:{
                   }
                   accessibilityContext:{}]}
             }]];
}

@end
