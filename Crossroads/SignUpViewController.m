//
//  SignUpViewController.m
//  Crossroads
//
//  Created by Yi-Chin Sun on 7/11/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "SignUpViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *verifyPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
}

- (void)hideKeyboard
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.verifyPasswordTextField resignFirstResponder];
    [self.phoneNumberTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}
- (IBAction)onSignUpButtonTapped:(id)sender
{
    if ([self.emailTextField.text isEqualToString:@""])
    {
        [self showSignUpErrorAlertController:@"Error: Email missing" withMessage:@"Please enter an email."];
    }
    else if ([self.usernameTextField.text isEqualToString:@""])
    {
        [self showSignUpErrorAlertController:@"Error: Username Required" withMessage:@"Please enter a username."];
    }
    else if ([self.phoneNumberTextField.text isEqualToString:@""])
    {
        [self showSignUpErrorAlertController:@"Error: Phone number missing" withMessage:@"Please enter a phone number."];
    }
    else if([self.passwordTextField.text isEqualToString:@""])
    {
        [self showSignUpErrorAlertController:@"Error: Password missing" withMessage:@"Please enter a password."];
    }
    else if (![self.verifyPasswordTextField.text isEqualToString:self.passwordTextField.text])
    {
        [self showSignUpErrorAlertController:@"Error: Invalid Password" withMessage:@"Please make sure your passwords match."];
    }
    else
    {
        PFUser *user = [PFUser user];
        user.username = self.usernameTextField.text;
        user.password = self.passwordTextField.text;
        user.email = self.emailTextField.text;
        [user setObject:self.phoneNumberTextField.text forKey:@"phoneNumber"];

        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             if (!error)
             {
                 // Hooray! Let them use the app now.
                 NSLog(@"Signed up as %@", [PFUser currentUser].username);
                 self.successSignUpBlock();
             }
             else
             {
                 NSString *errorString = [error userInfo][@"error"];
                 [self showSignUpErrorAlertController:@"Error" withMessage:errorString];
             }
         }];
    }

}

- (void)showSignUpErrorAlertController: (NSString *)errorTitle withMessage: (NSString*)errorMessage
{
    UIAlertController * alert= [UIAlertController
                                alertControllerWithTitle:errorTitle
                                message:errorMessage
                                preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                               }];
    [alert addAction:ok];

    [self presentViewController:alert animated:YES completion:nil];
}

@end
