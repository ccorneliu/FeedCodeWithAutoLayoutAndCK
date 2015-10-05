//
//  DCCTextComponent.h
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 29/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "CKCompositeComponent.h"

@interface DCCTextComponent : CKCompositeComponent

+(instancetype)newWithText:(NSString *)postText context:(id)context;

@end
