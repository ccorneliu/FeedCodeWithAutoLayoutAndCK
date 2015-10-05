//
//  DCCObservableObject.h
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 28/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "NSObject+DCCObservationHelper.h"

@protocol DCCObservableObject <NSObject>

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)DCC_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context NS_AVAILABLE(10_7, 5_0);

@end
