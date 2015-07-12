//
//  CRWeather.h
//  Crossroads
//
//  Created by Edgar Aroutiounian on 7/11/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemViewController.h"

@interface CRWeather : NSObject

@property (nonatomic, weak) ItemViewController *my_parent;

-(instancetype)init_with_parent:(ItemViewController*)p;
-(void)do_pull_data:(float)lat long_:(float)long_;

@end
