//
//  DCCFeedViewModelController.h
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 28/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCCFeedViewModelObserver;

@protocol DCCFeedViewModelObserverDelegate <NSObject>

-(void)observer:(DCCFeedViewModelObserver *)observer observedChange:(NSKeyValueChange)changeType forKeyPath:(NSString *)keyPath atIndexPaths:(NSArray *)indexPaths;

@end

@interface DCCFeedViewModelObserver : NSObject

@property (nonatomic,weak) IBOutlet id<DCCFeedViewModelObserverDelegate> delegate;

-(void)startObserving;

@end
