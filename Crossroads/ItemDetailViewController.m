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
#import <MessageUI/MFMessageComposeViewController.h>

@interface ItemDetailViewController ()<MFMessageComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *detailImageView;
@property (strong, nonatomic) IBOutlet UITextView *longDescriptionTextView;

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailImageView.image = self.searchItem.itemImage;

    UIColor *red = [UIColor colorWithRed:.93 green:.35 blue:.17 alpha:1];
    UIColor *blue = [UIColor colorWithRed:.29 green:.84 blue:.84 alpha:1];
    self.longDescriptionTextView.text = self.item[@"longDescription"];
    [self.longDescriptionTextView setFont:[UIFont systemFontOfSize:17]];
    if ([SearchItem isRequestWanted]) {
        self.detailImageView.image = self.searchItem.itemImage;
        // Do any additional setup after loading the view.


        [self.view setBackgroundColor:red];
    }
    else
    {
        [self.view setBackgroundColor:blue];
    }

}



- (IBAction)onTradeButtonTapped:(id)sender
{
    //get phone number of user

    PFRelation *relation = [self.item relationForKey:@"user"];

    [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error){
            PFUser *user = [results objectAtIndex:0];
            NSString *itemString = [self.item[@"item"] lowercaseString];
            if (![itemString hasSuffix:@"s"])
            {
                itemString = [NSString stringWithFormat:@"a %@", itemString];
            }
            NSString *SMSMessage = [NSString stringWithFormat:@"Hi, I saw that you were offering %@ for trade.", itemString];
            [self sendSMS:SMSMessage recipientList:[NSArray arrayWithObjects:user[@"phoneNumber"], nil]];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

//    //Also push a Request/Offering object to Parse, depending on which flow led to this screen
//    NSString *className = self.isOffering ? @"Offering" : @"Request";
//    PFObject *offering = [PFObject objectWithClassName:className];
//    offering[@"item"] = self.item[@"item"];
//    offering[@"user"] = [PFUser currentUser];
//    [offering saveInBackground];
}

- (IBAction)onStoreButtonTapped:(id)sender
{
    //Decide what to do when this is tapped. What if Outside Lands doesn't have an online store?
    //Should we just pull up a map with the store's physical location?
}

- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [MFMessageComposeViewController new];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];

    if (result == MessageComposeResultCancelled)
    {
        NSLog(@"Message cancelled");
    }
    else if (result == MessageComposeResultSent)
    {
        NSLog(@"Message sent");
    }
    else
    {
        NSLog(@"Message failed");
    }
}

@end
