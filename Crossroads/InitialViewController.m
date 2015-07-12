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
#import "SearchItem.h"


@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad
{    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor blackColor],
                                                                       NSFontAttributeName: [UIFont fontWithName:@"Avenir" size:20.0f]                                                                      }];
    [self.navigationItem setTitle: @"Crossroads"];

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    ItemGridViewController *vc = [segue destinationViewController];
    // Wanted button has tag 0
    if (sender.tag == 0)
    {
        vc.isRequestedWanted = YES;
        [SearchItem isRequestWanted:YES];
        }
    else
    {
        vc.isRequestedWanted = NO;
        [SearchItem isRequestWanted:NO];
    }
}

@end
