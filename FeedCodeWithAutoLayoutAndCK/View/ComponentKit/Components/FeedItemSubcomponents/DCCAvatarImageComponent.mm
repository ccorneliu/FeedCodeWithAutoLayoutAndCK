//
//  DCCAvatarImageComponent.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 29/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCAvatarImageComponent.h"

@implementation DCCAvatarImageComponent

+(instancetype)newWithImage:(UIImage *)image
                       size:(const CKComponentSize &)size
               cornerRadius:(CGFloat)cornerRadius {
    
    return [super newWithComponent:[CKComponent
                                    newWithView:{
                                        [UIImageView class],
                                        {
                                            {@selector(setImage:), image},
                                            {@selector(setContentMode:), @(UIViewContentModeScaleAspectFill)},
                                            {@selector(setClipsToBounds:), @YES},
                                            {CKComponentViewAttribute::LayerAttribute(@selector(setCornerRadius:)),@(cornerRadius)},
                                        }
                                    }
                                    size:size]];
}

@end
