//
//  ItemDetailViewController.m
//  Crossroads
//
//  Created by Yi-Chin Sun on 7/11/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "SearchItem.h"
#import <Parse/Parse.h>

@interface ItemDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *detailImageView;

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailImageView.image = self.item.itemImage;
    UIColor *red = [UIColor colorWithRed:.93 green:.35 blue:.17 alpha:1];
    UIColor *blue = [UIColor colorWithRed:.29 green:.84 blue:.84 alpha:1];
    if ([SearchItem isRequestWanted]) {

        [self.view setBackgroundColor:red];
    }
    else
    {
        [self.view setBackgroundColor:blue];
    }

    }



- (IBAction)onTradeButtonTapped:(id)sender
{
    //Get in contact with user who is offering the item
    
    //Also push a Request/Offering object to Parse, depending on which flow led to this screen
    NSString *className = self.isOffering ? @"Offering" : @"Request";
    PFObject *offering = [PFObject objectWithClassName:className];
    offering[@"item"] = self.item.itemName;
    offering[@"user"] = [PFUser currentUser];

    [offering saveInBackground];
}

- (IBAction)onStoreButtonTapped:(id)sender
{
    //Decide what to do when this is tapped. What if Outside Lands doesn't have an online store?
    //Should we just pull up a map with the store's physical location?
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
