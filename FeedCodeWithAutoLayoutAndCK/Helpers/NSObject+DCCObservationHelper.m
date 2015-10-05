//
//  NSObject+DCCObservationHelper.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 28/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "NSObject+DCCObservationHelper.h"

@implementation NSObject (DCCObservationHelper)

-(void)DCC_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context {
    @try {
        [self removeObserver:observer forKeyPath:keyPath context:context];
    }
    @catch (NSException *exception) {}
}

@end
