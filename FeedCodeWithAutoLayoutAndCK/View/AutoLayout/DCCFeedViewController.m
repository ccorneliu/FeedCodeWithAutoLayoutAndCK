//
//  ViewController.m
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 27/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import "DCCFeedViewController.h"
#import "DCCFeedViewModel.h"
#import "DCCFeedItemTableViewCell.h"
#import "DCCFeedViewModelObserver.h"

@interface DCCFeedViewController () <UITableViewDataSource, UITableViewDelegate, DCCFeedViewModelObserverDelegate>

@property (nonatomic, strong) IBOutlet id<DCCFeedViewModel> viewModel;
@property (nonatomic, weak) IBOutlet DCCFeedViewModelObserver *viewModelObserver;
@property (nonatomic, weak) IBOutlet UITableView *feedItemsTableView;

@end

@implementation DCCFeedViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModelObserver startObserving];
}

#pragma mark - Helpers
-(NSString *)cellIdentifierForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<DCCFeedItem> feedItem = self.viewModel.feedItems[indexPath.row];
    if (feedItem.postImages.count == 1) {
        return @"postWith1ImageCell";
    }
    else if (feedItem.postImages.count == 2) {
        return @"postWith2ImagesCell";
    }
    else if (feedItem.postImages.count == 3) {
        return @"postWith3ImagesCell";
    }
    else if (feedItem.postImages.count >= 4) {
        return @"postWith4ImagesCell";
    }
    else {
        return @"textPostCell";
    }
}

-(void)configureCell:(DCCFeedItemTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    id<DCCFeedItem> feedItem = self.viewModel.feedItems[indexPath.row];
    UIImage *avatar = [UIImage imageNamed:feedItem.authorAvatar];
    cell.avatar.image = avatar;
    cell.headerTitle.text = feedItem.authorName;
    cell.headerSubtitle.text = feedItem.postedTime;
    for (NSUInteger imageIndex = 0; imageIndex < feedItem.postImages.count; imageIndex++) {
        NSString *imageName = feedItem.postImages[imageIndex];
        switch (imageIndex) {
            case 0:
                cell.firstImage.image = [UIImage imageNamed:imageName];
                break;
            case 1:
                cell.secondImage.image = [UIImage imageNamed:imageName];
                break;
            case 2:
                cell.thirdImage.image = [UIImage imageNamed:imageName];
                break;
            case 3:
                cell.fourthImage.image = [UIImage imageNamed:imageName];
                break;
            default:
                break;
        }
    }
    cell.bodyText.text = feedItem.postText;
    UIColor *titleColor = feedItem.currentUserLikesThePost ? [UIColor redColor] : [UIColor blackColor];
    [cell.leftSideButton setTitleColor:titleColor forState:UIControlStateNormal];
    [self configureFeedLabel:cell.leftSideButtonLabel withElementName:@"Like" numberOfElements:feedItem.peopleNamesWhoLikedThePost.count];
    [self configureFeedLabel:cell.centerButtonLabel withElementName:@"Comment" numberOfElements:feedItem.numberOfComments];
    [self configureFeedLabel:cell.rightSideButtonLabel withElementName:@"Share" numberOfElements:feedItem.numberOfShares];
    cell.footerText.text = [feedItem.peopleNamesWhoLikedThePost componentsJoinedByString:@", "];
    cell.highlightedIndicator.hidden = !feedItem.featured;
}

-(void)configureFeedLabel:(UILabel *)feedButtonLabelToConfigure withElementName:(NSString *)elementName numberOfElements:(NSUInteger)numberOfElements {
    NSString *pluralIfNecessary = numberOfElements == 1 ? @"" : @"s";
    NSString *buttonTitle = [NSString stringWithFormat:@"%lu %@%@", numberOfElements, elementName, pluralIfNecessary];
    feedButtonLabelToConfigure.text = buttonTitle;
}

-(CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static DCCFeedItemTableViewCell *sizingCellWith1Image = nil;
    static DCCFeedItemTableViewCell *sizingCellWith2Image = nil;
    static DCCFeedItemTableViewCell *sizingCellWith3Image = nil;
    static DCCFeedItemTableViewCell *sizingCellWith4Image = nil;
    static DCCFeedItemTableViewCell *sizingCellWithText = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCellWith1Image = [self.feedItemsTableView dequeueReusableCellWithIdentifier:@"postWith1ImageCell"];
        sizingCellWith2Image = [self.feedItemsTableView dequeueReusableCellWithIdentifier:@"postWith2ImagesCell"];
        sizingCellWith3Image = [self.feedItemsTableView dequeueReusableCellWithIdentifier:@"postWith3ImagesCell"];
        sizingCellWith4Image = [self.feedItemsTableView dequeueReusableCellWithIdentifier:@"postWith4ImagesCell"];
        sizingCellWithText = [self.feedItemsTableView dequeueReusableCellWithIdentifier:@"textPostCell"];
    });
    DCCFeedItemTableViewCell *cellToUseForCalculatingSize;
    id<DCCFeedItem> feedItem = self.viewModel.feedItems[indexPath.row];
    switch (feedItem.postImages.count) {
        case 0:
        {
            cellToUseForCalculatingSize = sizingCellWithText;
        }
        case 1:
        {
            cellToUseForCalculatingSize = sizingCellWith1Image;
        }
            break;
        case 2:
        {
            cellToUseForCalculatingSize = sizingCellWith2Image;
        }
            break;
        case 3:
        {
            cellToUseForCalculatingSize = sizingCellWith3Image;
        }
            break;
        default:
        {
            cellToUseForCalculatingSize = sizingCellWith4Image;
        }
            break;
    }
    [self configureCell:cellToUseForCalculatingSize atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:cellToUseForCalculatingSize];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    CGFloat deviceWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, deviceWidth, CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGFloat heightToReturn = size.height;
    return heightToReturn;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.feedItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [self cellIdentifierForItemAtIndexPath:indexPath];
    DCCFeedItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath];
}

#pragma mark - DCCFeedViewModelObservationControllerDelegate
-(void)observer:(DCCFeedViewModelObserver *)observer observedChange:(NSKeyValueChange)changeType forKeyPath:(NSString *)keyPath atIndexPaths:(NSArray *)indexPaths {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(feedItems))]) {
        switch (changeType) {
            case NSKeyValueChangeSetting:
            case NSKeyValueChangeInsertion:
            {
                [self.feedItemsTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            }
                break;
            case NSKeyValueChangeRemoval:
            {
                [self.feedItemsTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            }
                break;
            case NSKeyValueChangeReplacement:
            {
                [self.feedItemsTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            }
                break;
                
            default:
                break;
        }
    }
}


@end
