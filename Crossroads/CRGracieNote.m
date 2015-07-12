//
//  CRGracieNote.m
//  Crossroads
//
//  Created by Edgar Aroutiounian on 7/12/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "CRGracieNote.h"

static NSString *base_url = @"https://c14680320.web.cddbp.net/webapi/xml/1.0/";
// Should be good to go by time of usage
static NSString *user_id;

@implementation CRGracieNote
{
    NSMutableURLRequest *request_horse;
}

-(instancetype)init
{
    if (self = [super init]) {
        request_horse = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:base_url]];
        
    }
    return self;
}

+(void)register_with_gracie
{
    NSMutableURLRequest *the_request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:base_url]];
    [the_request setHTTPMethod:@"POST"];
    NSData *as_buffer =
    [@"<QUERIES><QUERY CMD=\"REGISTER\"><CLIENT>14680320-8C45B27A9AE81B04DB55F79AEF1465F8</CLIENT></QUERY></QUERIES>" dataUsingEncoding:NSUTF8StringEncoding];
    [the_request setHTTPBody:as_buffer];
    [NSURLConnection sendAsynchronousRequest:the_request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               NSRange start = [s rangeOfString:@"<USER>"];
                               NSRange end = [s rangeOfString:@"</USER>"];
                               NSRange payload = NSMakeRange(start.location + 6, end.location - start.location - 6);
                               user_id = [s substringWithRange:payload];
                           }];
}

@end
