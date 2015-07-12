//
//  ItemViewController.m
//  Crossroads
//
//  Created by Yi-Chin Sun on 7/11/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//
#import <Parse/Parse.h>
#import "MarqueeLabel.h"
#import "ItemViewController.h"
#import "OfferingTableViewCell.h"
#import "ItemDetailViewController.h"
#import "SearchItem.h"
#import "CRWeather.h"
#import "CRGracieNote.h"

@interface ItemViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UILabel *weather_line;
    __weak IBOutlet UIView *marquee;
    CRGracieNote *worker;
    NSArray *all_offerings;
}

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    worker = [CRGracieNote new];
    self.itemOfferingsTableView.userInteractionEnabled = YES;
    self.itemLabel.text = self.searchItem.itemName;
    self.itemImageView.image = self.searchItem.itemImage;
    
    _itemImageView.image = [_itemImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_itemImageView setTintColor:[UIColor blackColor]];
    
    // fetch offerings from Parse
    PFQuery *query = [PFQuery queryWithClassName:@"Offering"];
    NSLog(@"%@", self.searchItem.itemName);
    [query whereKey:@"item" equalTo:self.searchItem.itemName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *offerings, NSError *error) {
        if (!error){
            all_offerings = [NSArray arrayWithArray:offerings];
            [self.itemOfferingsTableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

-(void)awakeFromNib
{
    self.data_model = [[CRWeather alloc] init_with_parent:self];
    [self.data_model do_pull_data:37.8 long_:-122.4];
}

-(void)weather_data:(NSDictionary *)j_data
{
    NSString *weather_string = [(NSDictionary*)[j_data objectForKey:@"current_observation"] objectForKey:@"feelslike_string"];
    NSNumber *current_temp = (NSNumber*)[(NSDictionary*)[j_data objectForKey:@"current_observation"] objectForKey:@"temp_f"];
    NSString *display_me = [NSString stringWithFormat:@"Right now: %@ %@",
                            current_temp.floatValue > 60 ? @"☀️" : @"☁️", weather_string];
    weather_line.text = display_me;
    MarqueeLabel *l = [[MarqueeLabel alloc] initWithFrame:marquee.frame duration:30.0 andFadeLength:10.0];

    l.text = [worker artist_data];
    [self.view addSubview:l];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OfferingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OfferingCell"];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return all_offerings.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Clicked");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(OfferingTableViewCell *)sender
{
    ItemDetailViewController *vc = segue.destinationViewController;
    vc.item = [all_offerings objectAtIndex:[[self.itemOfferingsTableView indexPathForCell:sender] row]];

//    //used to add user to offerings/requests manually added to Parse
//    PFUser *user = [PFUser currentUser];
//    PFRelation *relation = [vc.item relationForKey:@"user"];
//    [relation addObject:user];
//
//    [vc.item saveInBackground];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
