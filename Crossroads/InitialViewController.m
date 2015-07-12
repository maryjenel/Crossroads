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


@interface InitialViewController ()<CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property CLLocation *currentLocation;
@property CLLocationCoordinate2D locationCoordinate;

@end

@implementation InitialViewController

- (void)viewDidLoad
{    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor blackColor],
                                                                       NSFontAttributeName: [UIFont fontWithName:@"Avenir" size:20.0f]                                                                      }];
    [self.navigationItem setTitle: @"Crossroads"];
    [self setupLocationManager];

    // Update location
    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - Setup Location Manager
- (void)setupLocationManager
{
    // Pre-check for authorizations
    if (![CLLocationManager locationServicesEnabled])
    {
        NSLog(@"location services are disabled");
        return;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"location services are blocked by the user");
        return;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        NSLog(@"about to show a dialog requesting permission");
    }

    // Create LocationManager
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;

    // Request user authorization
    [self.locationManager requestAlwaysAuthorization];

    /* Pinpoint our location with the following accuracy:
     *
     *     kCLLocationAccuracyBestForNavigation  highest + sensor data
     *     kCLLocationAccuracyBest               highest
     *     kCLLocationAccuracyNearestTenMeters   10 meters
     *     kCLLocationAccuracyHundredMeters      100 meters
     *     kCLLocationAccuracyKilometer          1000 meters
     *     kCLLocationAccuracyThreeKilometers    3000 meters
     */
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;

    /* Notify changes when device has moved x meters.
     * Default value is kCLDistanceFilterNone: all movements are reported.
     */
    self.locationManager.distanceFilter = 10.0f;

    /* Notify heading changes when heading is > 5.
     * Default value is kCLHeadingFilterNone: all movements are reported.
     */
    self.locationManager.headingFilter = 5;
}

#pragma mark - Location Manager
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocationCoordinate2D myLocation = [locations.firstObject coordinate];
    self.locationCoordinate = myLocation;

    // Set phones current location
    self.currentLocation = locations.lastObject;

    if (self.currentLocation != nil)
    {
        // Stop updating location
        [self.locationManager stopUpdatingLocation];

        PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.locationCoordinate.latitude longitude:self.locationCoordinate.longitude];
        [[PFUser currentUser] setObject:geoPoint forKey:@"location"];
        [[PFUser currentUser] saveInBackground];
    }
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"User has denied location services");
    }
    else
    {
        NSLog(@"Location manager did fail with error: %@", error.localizedFailureReason);
    }
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
