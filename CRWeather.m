//
//  CRWeather.m
//  Crossroads
//
//  Created by Edgar Aroutiounian on 7/11/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRWeather.h"
#import "ItemViewController.h"
//http://api.wunderground.com/api/e387e4074999e25f/conditions/q/37.8,-122.4.json
static NSString *w_underground_api =
@"http://api.wunderground.com/api/e387e4074999e25f/conditions/q/%f,%f.json";

@implementation CRWeather

-(instancetype)init_with_parent:(ItemViewController*)p
{
    if (self = [super init]) {
        self.my_parent = p;
    }
    return self;
}

-(void)do_pull_data:(float)lat long_:(float)long_
{
    NSURLRequest *this_request =
    [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:w_underground_api, lat, long_]]];
    [NSURLConnection sendAsynchronousRequest:this_request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError) {
                               //Assume the cast will success
                               NSDictionary *json =
                               [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingAllowFragments                                                                 error:NULL];
                               [self.my_parent weather_data:json];
                           }];
}
@end
