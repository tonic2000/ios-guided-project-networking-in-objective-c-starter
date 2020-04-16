//
//  LSIQuakeFetcher.m
//  Quakes-Objc
//
//  Created by Nick Nguyen on 4/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuakeFetcher.h"
#import "LSIQuake.h"
#import "LSIQuakeResults.h"
#import "LSIErrors.h"
#import "LSILog.h"

static NSString *baseURLString = @"https://earthquake.usgs.gov/fdsnws/event/1/query";

@implementation LSIQuakeFetcher


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)fetchQuakesInTimeInterval:(NSDateInterval *)interval
                  completionBlock:(LSIQuakeFetcherCompletionBlock)completionBlock {
    NSURLComponents * urlComponents = [[NSURLComponents alloc] initWithString:baseURLString];
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    NSString *startTimeString = [formatter stringFromDate:interval.startDate];
    NSString *endTimeString = [formatter stringFromDate:interval.endDate];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"startTime" value:startTimeString],
        [NSURLQueryItem queryItemWithName:@"endTime" value:endTimeString],
        [NSURLQueryItem queryItemWithName:@"format" value:@"geojson"],
    ];
    
    
    NSURL *url = urlComponents.URL; // FIXME: Can add error handling if value is nil

    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
            NSLog(@"url: %@",url);
        
    }];
    
    
    
    
    
    
    [task resume];
    
    
    
    
}

@end




