//
//  TradeCreateViewController.m
//  Crossroads
//
//  Created by Yi-Chin Sun on 7/12/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "TradeCreateViewController.h"
#import "SearchItem.h"
#import <Parse/Parse.h>

#define ARC4RANDOM_MAX      0x100000000

@interface TradeCreateViewController ()
@property (strong, nonatomic) IBOutlet UILabel *itemTextLabel;
@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UITextView *longDescriptionTextView;
@property (strong, nonatomic) IBOutlet UITextField *shortDescriptionTextField;

@end

@implementation TradeCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemTextLabel.text = self.searchItem.itemName;
    self.itemImageView.image = self.searchItem.itemImage;

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideKeyboard
{
    [self.shortDescriptionTextField resignFirstResponder];
    [self.longDescriptionTextView resignFirstResponder];
}
- (IBAction)onPostTradeButtonTapped:(id)sender
{
    PFObject *offering = [PFObject objectWithClassName:@"Offering"];
    offering[@"item"] = self.searchItem.itemName;
    offering[@"description"] = self.shortDescriptionTextField.text;
    offering[@"longDescription"] = self.longDescriptionTextView.text;

    double val = floorf(((double)arc4random() / ARC4RANDOM_MAX) * 3.0f);
    NSString* milesString = [NSString stringWithFormat:@"%.02f miles", val];
    offering[@"distance"] = milesString;
    [offering saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Error: Unable to Save"
                                       message:@"We were unable to upload your trade. Please try again."
                                       preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                       }];
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];

        }
    }];
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
