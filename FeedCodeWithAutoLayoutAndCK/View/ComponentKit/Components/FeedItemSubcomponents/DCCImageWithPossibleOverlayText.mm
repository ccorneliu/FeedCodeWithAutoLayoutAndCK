//
//  DCCImageWithPossibleOverlayText.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 29/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCImageWithPossibleOverlayText.h"
#import "DCCFeedItem.h"
#import <ComponentKit/ComponentKit.h>

@implementation DCCImageWithPossibleOverlayText

+(instancetype)newWithFeedItemData:(id<DCCFeedItem>)feedItemData context:(id)context {
    
    if (![feedItemData postImages].count) {
        return nil;
    }
    
    CGFloat componentWidth = [[context objectForKey:@"componentWidth"] doubleValue];
    NSString *feedImageName = [feedItemData postImages][0];
    UIImage *image = [UIImage imageNamed:feedImageName];
    CKComponent *imageComponent = [super newWithComponent:
                                           [CKComponent
                                            newWithView:{
                                                [UIImageView class],
                                                {
                                                    {@selector(setImage:), image},
                                                    {@selector(setContentMode:), @(UIViewContentModeScaleAspectFill)},
                                                }
                                            }
                                            size:{.width = componentWidth, .height = componentWidth}]];
    
    CKComponent *componentToUseForImage;
    if ([feedItemData featured]) {
        
        NSAttributedString *whiteOverlayTitle = [[NSAttributedString alloc] initWithString:@"Featured" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:30.0f]}];
        CKComponent *overlayComponent = [CKCenterLayoutComponent
                                         newWithCenteringOptions:{CKCenterLayoutComponentCenteringXY}
                                         sizingOptions:{}
                                         child:
                                         [CKStackLayoutComponent
                                          newWithView:{
                                              [UIView class],
                                              {
                                                  {@selector(setBackgroundColor:), [UIColor blackColor]},
                                                  {@selector(setUserInteractionEnabled:), @(NO)}
                                              }
                                          }
                                          size:{}
                                          style:{}
                                          children:{
                                              {
                                                  [CKInsetComponent
                                                   newWithInsets:{.top = 10, .left = 40, .bottom = 10, .right = 40}
                                                   component:[CKTextComponent
                                                              newWithTextAttributes:{
                                                                  .attributedString = [whiteOverlayTitle copy]
                                                              }
                                                              viewAttributes:{
                                                                  {@selector(setBackgroundColor:), [UIColor clearColor]}
                                                              }
                                                              accessibilityContext:{}
                                                              ]],
                                              }
                                          }]
                                         size:{}];
        componentToUseForImage = [CKOverlayLayoutComponent
                                  newWithComponent:imageComponent
                                  overlay:overlayComponent];
    }
    else {
        componentToUseForImage = imageComponent;
    }
    
    return [super
            newWithView:{
                [UIView class],
                {{@selector(setBackgroundColor:), [UIColor whiteColor]}}
            }
            component:componentToUseForImage];
}

@end
