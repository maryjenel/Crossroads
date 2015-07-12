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


@end

@implementation ItemGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addingSearchItems];

    
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
    ItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
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
