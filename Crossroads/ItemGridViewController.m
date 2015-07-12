//
//  ItemGridViewController.m
//  Crossroads
//
//  Created by Yi-Chin Sun on 7/11/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "ItemGridViewController.h"
#import "ItemViewController.h"
#import "SearchItem.h"
#import "ItemCollectionViewCell.h"

@interface ItemGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *itemCollectionView;
@property NSMutableArray *itemArray;

@property (weak, nonatomic) IBOutlet UIButton *otherBtn;

//@property UIColor* bgcolor;


@end

@implementation ItemGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addingSearchItems];
    [self.itemCollectionView reloadData];
    //UIColor *red = [UIColor colorWithRed:238 green:88 blue:44 alpha:1];
    //UIColor *blue = [UIColor colorWithRed:73 green:213 blue:213 alpha:1];
    //_itemCollectionView.backgroundColor = self.bgcolor;
}

- (void)addingSearchItems
{
    _itemArray = [NSMutableArray new];
    SearchItem *sunglasses = [[SearchItem alloc]initWithName:@"Sunglasses" itemImage:[UIImage imageNamed:@"Sunglasses"]];
    SearchItem *hat = [[SearchItem alloc]initWithName:@"Hat" itemImage:[UIImage imageNamed:@"Hat"]];
    SearchItem *battery =[[SearchItem alloc]initWithName:@"Battery" itemImage:[UIImage imageNamed:@"Battery"]];
    SearchItem *earphones = [[SearchItem alloc]initWithName:@"Earphones" itemImage:[UIImage imageNamed:@"Earphones"]];
    SearchItem *water = [[SearchItem alloc]initWithName:@"Water" itemImage:[UIImage imageNamed:@"Water"]];
    SearchItem *umbrella = [[SearchItem alloc]initWithName:@"Umbrella" itemImage:[UIImage imageNamed:@"Umbrella"]];
    SearchItem *cigs = [[SearchItem alloc]initWithName:@"Cigarettes" itemImage:[UIImage imageNamed:@"Cigarettes"]];
    SearchItem *paperRoll = [[SearchItem alloc]initWithName:@"Toilet Paper" itemImage:[UIImage imageNamed:@"Toilet Paper"]];
    SearchItem *sunscreen = [[SearchItem alloc]initWithName:@"Sunscreen" itemImage:[UIImage imageNamed:@"Sunscreen"]];

    self.itemArray = [NSMutableArray arrayWithObjects:sunglasses,hat,battery,earphones,water,umbrella,cigs,paperRoll,sunscreen, nil];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
    SearchItem *item = [self.itemArray objectAtIndex:indexPath.row];
    cell.itemImageView.image = item.itemImage;
    cell.itemLabel.text = item.itemName;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(SearchItem *)sender
{
    ItemViewController *vc = segue.destinationViewController;
    vc.searchItem = sender;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"itemSelectedSegue" sender: [self.itemArray objectAtIndex:indexPath.row]];
}

- (IBAction)otherBtnClicked:(id)sender {
    [self setUpModal ];
}

- (void)setUpModal {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Other" message:@"Enter Item Name" preferredStyle: UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Item Name";
    }];
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             UITextField *textField = alertController.textFields[0];
                             [self sendOtherItemWithName:textField.text];
                         }];
    
    UIAlertAction* cancel = [UIAlertAction
                         actionWithTitle:@"Cancel"
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             
                             
                         }];
    
    [alertController addAction:cancel];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)sendOtherItemWithName:(NSString*)name {
    SearchItem *other = [[SearchItem alloc]initWithName:name itemImage:[UIImage imageNamed:@"Other"]];
    [self performSegueWithIdentifier:@"itemSelectedSegue" sender:other];
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
