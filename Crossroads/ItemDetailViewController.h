//
//  ItemDetailViewController.h
//  Crossroads
//
//  Created by Yi-Chin Sun on 7/11/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PFObject;
@class SearchItem;

@interface ItemDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *itemDescriptionTextView;

@property PFObject *item;
@property SearchItem *searchItem;
// Need to keep track of whether this is offering or request


@end
