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



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    ItemGridViewController *vc = [segue destinationViewController];
    // Wanted button has tag 0
    if (sender.tag == 0)
    {
        vc.isRequestedWanted = YES;
        }
    else
    {
        vc.isRequestedWanted = NO;
    }
}

@end
