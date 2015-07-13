//
//  StoreViewController.m
//  Crossroads
//
//  Created by Mary Jenel Myers on 7/12/27 H.
//  Copyright (c) 27 Heisei Mary Jenel Myers. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cloudoneImage;
@property (weak, nonatomic) IBOutlet UIImageView *cloudtwoImage;
@property (weak, nonatomic) IBOutlet UIImageView *cloudthreeImage;
@property (weak, nonatomic) IBOutlet UIImageView *cloudfourImage;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self animateClouds:self.cloudoneImage];
    [self animateClouds:self.cloudtwoImage];
    [self animateClouds:self.cloudthreeImage];
    [self animateClouds:self.cloudfourImage];


}

-(void)animateClouds: (UIImageView *)cloudImage
{
    double cloudSpeed = 20.0 / self.view.frame.size.width;
    NSTimeInterval duration = (self.view.frame.size.width - cloudImage.frame.origin.x) * cloudSpeed;

    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         cloudImage.frame = CGRectMake(self.view.bounds.size.width,
                                                cloudImage.frame.origin.y,
                                                cloudImage.frame.size.width,
                                                cloudImage.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             cloudImage.frame = CGRectMake(-self.view.frame.size.width,
                                                    self.view.frame.origin.y,
                                                    cloudImage.frame.size.width,
                                                    cloudImage.frame.size.height);
                             [self animateClouds:cloudImage];
                         }
                     }];}

@end
