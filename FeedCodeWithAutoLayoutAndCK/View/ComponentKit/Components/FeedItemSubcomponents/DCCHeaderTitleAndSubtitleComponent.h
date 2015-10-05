//
//  DCCHeaderTitleAndSubtitleComponent.h
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 29/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "CKCompositeComponent.h"

@interface DCCHeaderTitleAndSubtitleComponent : CKCompositeComponent

+(instancetype)newWithTitle:(NSString *)title
                   subtitle:(NSString *)subtitle
             componentWidth:(CGFloat)componentWidth;

@end
