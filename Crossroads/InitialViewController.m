//
//  ViewController.m
//  Crossroads
//
//  Created by Mary Jenel Myers on 7/10/27 H.
//  Copyright (c) 27 Heisei Mary Jenel Myers. All rights reserved.
//

#import "InitialViewController.h"
#import <Parse/Parse.h>
@interface InitialViewController ()
@property (weak, nonatomic) IBOutlet UIButton *wantedbtn;
@property (weak, nonatomic) IBOutlet UIButton *tradebtn;

@end

@implementation InitialViewController

- (void)viewDidLoad
<<<<<<< HEAD
{    [super viewDidLoad];
=======
}


- (IBAction)onWantedBtnSelected:(UIButton *)sender
{
    PFObject *user = [PFObject objectWithClassName:@"User"];
    user[@"isRequesting"] = @"Yes";

    PFObject *wanted = [PFObject objectWithClassName:@"Request"];
   // wanted[@"user"] = [PFUser currentUser];
}
- (IBAction)onTradeBtnSelected:(UIButton *)sender
{
    PFObject *user = [PFObject objectWithClassName:@"User"];
    user[@"isOffering"] = @"Yes";

    PFObject *wanted = [PFObject objectWithClassName:@"Request"];
  //  wanted[@"user"] = [PFUser currentUser];
}

@end
