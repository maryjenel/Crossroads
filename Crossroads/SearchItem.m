//
//  SearchItem.m
//  Crossroads
//
//  Created by Mary Jenel Myers on 7/11/27 H.
//  Copyright (c) 27 Heisei Mary Jenel Myers. All rights reserved.
//

#import "SearchItem.h"

@implementation SearchItem
-(instancetype)initWithName: (NSString *)itemName itemImage:(UIImage *)itemImage

{
    self = [super init];
    if (self) {
        _itemImage = itemImage;
        _itemName = itemName;
    }
    return self;
}

+(void)isRequestWanted:(BOOL)wanted
{
    [[NSUserDefaults standardUserDefaults]setBool:wanted forKey:@"isWanted"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(BOOL)isRequestWanted
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isWanted"];
}
@end
