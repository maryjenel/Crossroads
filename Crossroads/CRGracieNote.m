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
static NSString *query_info = @"<QUERIES><LANG>eng</LANG><AUTH><CLIENT>%@</CLIENT><USER>%@</USER></AUTH><QUERY CMD=\"ALBUM_SEARCH\"><TEXT TYPE=\"ARTIST\">\
                                %@</TEXT><TEXT TYPE=\"TRACK_TITLE\">all in</TEXT></QUERY></QUERIES>";

@implementation CRGracieNote
{
    NSMutableURLRequest *request_horse;
}

-(instancetype)init
{
    if (self = [super init]) {
        request_horse = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:base_url]];
        [request_horse setHTTPMethod:@"POST"];
    }
    return self;
}

-(NSString *)artist_data
{
    NSString *formmated = [NSString stringWithFormat:query_info, @"14680320-8C45B27A9AE81B04DB55F79AEF1465F8", user_id, @"The black keys"];
    [request_horse setHTTPBody:[formmated dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *raw = [[NSString alloc] initWithData: [NSURLConnection sendSynchronousRequest:request_horse
                                                                          returningResponse:nil
                                                                                      error:nil]
                                          encoding: NSUTF8StringEncoding];
    raw = [raw stringByReplacingOccurrencesOfString:@"&" withString:@""];
    raw = [raw stringByReplacingOccurrencesOfString:@"amp" withString:@""];
    raw = [raw stringByReplacingOccurrencesOfString:@";" withString:@""];

    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"<TITLE>(.*)</TITLE>" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matches = [regex matchesInString:raw options:0 range:NSMakeRange(0, raw.length)];
    NSMutableArray *hits = [NSMutableArray new];
    for (NSTextCheckingResult *i in matches) {
        NSRange match_range = [i rangeAtIndex:1];
        NSString *a_match = [raw substringWithRange:match_range];
        [hits addObject:a_match];
    }
    return [hits componentsJoinedByString:@"  🎶  "];
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
