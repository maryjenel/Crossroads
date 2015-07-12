//
//  ItemViewController.h
//  Crossroads
//
//  Created by Yi-Chin Sun on 7/11/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRWeather;
@class SearchItem;

@interface ItemViewController : UIViewController

@property SearchItem *searchItem;
@property (strong, nonatomic) IBOutlet UILabel *itemLabel;
@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UITableView *itemOfferingsTableView;
@property (nonatomic, strong) CRWeather *data_model;

-(void)weather_data:(NSDictionary*)j_data;

@end
