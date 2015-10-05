//
//  DCCPerformantFeedViewController.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 28/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCPerformantFeedViewController.h"
#import "DCCFeedViewModelObserver.h"
#import "DCCFeedViewModel.h"

#import <ComponentKit/ComponentKit.h>

#import "DCCFeedItemComponent.h"

@interface DCCPerformantFeedViewController () <DCCFeedViewModelObserverDelegate, CKComponentProvider, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) IBOutlet id<DCCFeedViewModel> viewModel;
@property (nonatomic, strong) IBOutlet DCCFeedViewModelObserver *viewModelObserver;
@property (nonatomic, weak) IBOutlet UICollectionView *feedCollectionView;

@property (nonatomic, strong) CKComponentFlexibleSizeRangeProvider *sizeRangeProvider;
@property (nonatomic, strong) CKCollectionViewDataSource *dataSource;
@property (nonatomic, strong) NSDictionary *dataSourceContext;

@end

@implementation DCCPerformantFeedViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //create size range provider - ck_size_range_provider
    self.sizeRangeProvider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibleHeight];
    
    //create component kit data source - ck_create_data_source
    self.dataSourceContext = @{@"componentWidth":[NSNumber numberWithDouble:self.feedCollectionView.bounds.size.width],
                               @"reportAction":NSStringFromSelector(@selector(topBarActionButtonTapped:forItemWithData:))};
    self.dataSource = [[CKCollectionViewDataSource alloc] initWithCollectionView:self.feedCollectionView
                                                     supplementaryViewDataSource:nil
                                                               componentProvider:[self class]
                                                                         context:self.dataSourceContext
                                                       cellConfigurationFunction:nil];
    
    
    // Insert the initial section - ck_insert_section
    CKArrayControllerSections sections;
    sections.insert(0);
    [self.dataSource enqueueChangeset:{sections, {}}
                      constrainedSize:[self.sizeRangeProvider sizeRangeForBoundingSize:self.feedCollectionView.bounds.size]];
    
    [self.viewModelObserver startObserving];
}

#pragma mark - DCCFeedViewModelObservationControllerDelegate
-(void)observer:(DCCFeedViewModelObserver *)observer observedChange:(NSKeyValueChange)changeType forKeyPath:(NSString *)keyPath atIndexPaths:(NSArray *)indexPaths {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(feedItems))]) {
        //react to model changes - ck_react_to_model_changes
        __block CKArrayControllerInputItems items;
        switch (changeType) {
            case NSKeyValueChangeSetting:
            case NSKeyValueChangeInsertion:
            {
                for (NSIndexPath *indexPath in indexPaths) {
                    items.insert(indexPath, [self.viewModel.feedItems objectAtIndex:indexPath.row]);
                }
            }
                break;
                
            case NSKeyValueChangeRemoval:
            {
                for (NSIndexPath *indexPath in indexPaths) {
                    items.remove(indexPath);
                }
            }
                break;
                
            case NSKeyValueChangeReplacement:
            {
                for (NSIndexPath *indexPath in indexPaths) {
                    items.update(indexPath, [self.viewModel.feedItems objectAtIndex:indexPath.row]);
                }
            }
                break;
                
            default:
                break;
        }
        
        [self.dataSource enqueueChangeset:{{}, items}
                          constrainedSize:[self.sizeRangeProvider sizeRangeForBoundingSize:CGSizeMake(self.feedCollectionView.bounds.size.width, self.feedCollectionView.bounds.size.height / 2.0f)]];
    }
}

#pragma mark - CKComponentProvider
//provide component ck_provide_component
+ (CKComponent *)componentForModel:(id)feedItemData context:(id<NSObject>)context {
    DCCFeedItemComponent *feedItemComponent = [DCCFeedItemComponent newWithData:feedItemData context:context];
    return feedItemComponent;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//use calculated component size - ck_use_calculated_component_size
-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.dataSource sizeForItemAtIndexPath:indexPath];
}

#pragma mark - Feed Item Actions
-(void)topBarActionButtonTapped:(CKComponent *)component forItemWithData:(id<DCCFeedItem>)feedItemData {
    NSLog(@"report");
}

@end
