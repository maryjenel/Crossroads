//
//  ItemViewController.m
//  Crossroads
//
//  Created by Yi-Chin Sun on 7/11/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "ItemViewController.h"
#import "OfferingTableViewCell.h"
#import "ItemDetailViewController.h"
#import "SearchItem.h"

@interface ItemViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *itemLabel;
@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UITableView *itemOfferingsTableView;
@property NSArray *offeringUsersArray;


@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.itemLabel.text = self.searchItem.itemName;
    self.itemImageView.image = self.searchItem.itemImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OfferingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OfferingCell"];
    //cell.userAvatarImageView.image = image from imvu
    //cell.offeringDistanceLabel.text = distance from user
    //cell.offeringTextLabel.text = description
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.offeringUsersArray.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(OfferingTableViewCell *)sender
{
    ItemDetailViewController *vc = segue.destinationViewController;
    vc.user = [self.offeringUsersArray objectAtIndex:[[self.itemOfferingsTableView indexPathForCell:sender] row]];
    vc.item = self.itemLabel.text;
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
