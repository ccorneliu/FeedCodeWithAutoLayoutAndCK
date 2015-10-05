//
//  DCCAvatarImageComponent.h
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 29/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "CKCompositeComponent.h"

@interface DCCAvatarImageComponent : CKCompositeComponent

+(instancetype)newWithImage:(UIImage *)image
                       size:(const CKComponentSize &)size
               cornerRadius:(CGFloat)cornerRadius;

@end
