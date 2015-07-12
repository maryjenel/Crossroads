//
//  ViewController.m
//  Crossroads
//
//  Created by Mary Jenel Myers on 7/10/27 H.
//  Copyright (c) 27 Heisei Mary Jenel Myers. All rights reserved.
//

#import "InitialViewController.h"
#import <Parse/Parse.h>
#import "ItemGridViewController.h"


@interface InitialViewController ()
@property (weak, nonatomic) IBOutlet UIButton *wantedbtn;
@property (weak, nonatomic) IBOutlet UIButton *tradebtn;

@end

@implementation InitialViewController

- (void)viewDidLoad
{    [super viewDidLoad];
}


- (IBAction)onWantedButtonSelected:(UIButton *)sender
{
    //Should really just pass that the user is requesting something
}

- (IBAction)onTradeButtonSelected:(UIButton *)sender
{
    //Should really just pass that the user is offering something
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    // Wanted button has tag 0
    if (sender.tag == 0)
    {
        // pass that the user is requesting something to next view controller
    }
    else
    {
        // pass that the user is offering something to next view controller
    }
}

@end
