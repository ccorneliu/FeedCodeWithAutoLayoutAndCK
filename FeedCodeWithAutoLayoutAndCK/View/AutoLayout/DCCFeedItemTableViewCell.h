//
//  DCCFeedItemCollectionViewCell.h
//  FeedCodeWithAutoLayoutAndCK
//
//  Created by Corneliu on 28/09/15.
//  Copyright © 2015 Dolfn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCFeedItemTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UILabel *headerTitle;
@property (nonatomic, weak) IBOutlet UILabel *headerSubtitle;
@property (nonatomic, weak) IBOutlet UIImageView *firstImage;
@property (nonatomic, weak) IBOutlet UIImageView *secondImage;
@property (nonatomic, weak) IBOutlet UIImageView *thirdImage;
@property (nonatomic, weak) IBOutlet UIImageView *fourthImage;
@property (nonatomic, weak) IBOutlet UILabel *bodyText;
@property (nonatomic, weak) IBOutlet UIButton *leftSideButton;
@property (nonatomic, weak) IBOutlet UILabel *leftSideButtonLabel;
@property (nonatomic, weak) IBOutlet UIButton *centerButton;
@property (nonatomic, weak) IBOutlet UILabel *centerButtonLabel;
@property (nonatomic, weak) IBOutlet UIButton *rightSideButton;
@property (nonatomic, weak) IBOutlet UILabel *rightSideButtonLabel;
@property (nonatomic, weak) IBOutlet UILabel *footerText;
@property (nonatomic, weak) IBOutlet UIView *highlightedIndicator;

@end
