//
//  LogInViewController.m
//  Crossroads
//
//  Created by Yi-Chin Sun on 7/11/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "LogInViewController.h"
#import "SignUpViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface LogInViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([PFUser currentUser])
    {
        NSLog(@"Already logged in as %@", [PFUser currentUser].username);

    }

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
}

- (void)hideKeyboard
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}


- (IBAction)onLoginButtonTapped:(id)sender
{
    if ([self.usernameTextField.text isEqualToString:@""])
    {
        [self showLoginErrorAlertController: @"Error: Username missing" withMessage:@"Please enter a username."];
    }
    else if([self.passwordTextField.text isEqualToString:@""])
    {
        [self showLoginErrorAlertController: @"Error: Password missing" withMessage:@"Please enter a password."];
    }
    else
    {
        [PFUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error)
         {
             if (!error)
             {
                 NSLog(@"Logged in as %@", [PFUser currentUser].username);
                 // Clear all local cached data
                 [PFQuery clearAllCachedResults];
                 self.successLoginBlock();
             }
             else
             {
                 NSString *errorString = [error userInfo][@"error"];
                 NSLog(@"%@", errorString);
                 [self showLoginErrorAlertController:@"Error" withMessage:errorString];
             }
         }];
    }
}

- (void)showLoginErrorAlertController: (NSString *)errorTitle withMessage: (NSString*)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:errorTitle
                               message:errorMessage
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                               }];
    [alert addAction:ok];

    [self presentViewController:alert animated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SignUpViewController *vc = segue.destinationViewController;
    vc.successSignUpBlock = self.successLoginBlock;
    
}

@end
