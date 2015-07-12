//
//  SearchItem.h
//  Crossroads
//
//  Created by Mary Jenel Myers on 7/11/27 H.
//  Copyright (c) 27 Heisei Mary Jenel Myers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SearchItem : NSObject

@property NSString *itemName;
@property UIImage *itemImage;

-(instancetype)initWithName: (NSString *)itemName itemImage:(UIImage *)itemImage;
+(void)isRequestWanted:(BOOL)wanted;
+(BOOL)isRequestWanted;
@end
