//
//  OfferingTableViewCell.h
//  Crossroads
//
//  Created by Yi-Chin Sun on 7/11/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferingTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userAvatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *offeringTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *offeringDistanceLabel;

@end
