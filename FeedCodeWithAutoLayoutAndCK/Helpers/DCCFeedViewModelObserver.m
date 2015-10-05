//
//  DCCFeedViewModelController.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 28/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCFeedViewModelObserver.h"
#import "DCCFeedViewModel.h"

@interface DCCFeedViewModelObserver()

@property (nonatomic, strong) IBOutlet id<DCCFeedViewModel> viewModel;

@end

@implementation DCCFeedViewModelObserver

-(void)startObserving {
    if (self.viewModel && [self.viewModel conformsToProtocol:@protocol(DCCFeedViewModel)]) {
        [self addObserversToViewModel:self.viewModel];
    }
}

-(void)removeObserversFromViewModel:(id<DCCFeedViewModel>)viewModel {
    [viewModel DCC_removeObserver:self forKeyPath:NSStringFromSelector(@selector(feedItems)) context:NULL];
}

-(void)addObserversToViewModel:(id<DCCObservableObject>)viewModel {
    [viewModel addObserver:self forKeyPath:NSStringFromSelector(@selector(feedItems)) options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:NULL];
}

-(void)dealloc {
    [self removeObserversFromViewModel:self.viewModel];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(feedItems))]) {
        NSKeyValueChange changeType = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
        NSIndexSet *indexSetOfObjectsChanged = [change objectForKey:NSKeyValueChangeIndexesKey];
        if (!indexSetOfObjectsChanged && changeType == NSKeyValueChangeSetting) {
            indexSetOfObjectsChanged = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.viewModel.feedItems.count)];
        }
        NSMutableArray *indexPathsToDoOperationTo = [NSMutableArray array];
        [indexSetOfObjectsChanged enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [indexPathsToDoOperationTo addObject:indexPath];
        }];
        
        [self.delegate observer:self observedChange:changeType forKeyPath:keyPath atIndexPaths:indexPathsToDoOperationTo];
    }
}

@end
