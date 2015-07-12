//
//  ItemDetailViewController.h
//  Crossroads
//
//  Created by Yi-Chin Sun on 7/11/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchItem;

@interface ItemDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *itemDescriptionTextView;

@property NSString *user;
// Instead of SearchItem, maybe have PFObject instead
// Or just pass the description from previous view
@property SearchItem *item;
// Need to keep track of whether this is offering or request
@property BOOL isOffering;


@end
