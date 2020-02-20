//
//  LSIQuake.m
//  Quakes-Objc
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuake.h"

@implementation LSIQuake

// Control + I = reindent
- (instancetype)initWithMagnitude:(double)magnitude
                            place:(NSString *)place
                             time:(NSDate *)time
                            alert:(NSString *)alert
                             type:(NSString *)type
                         latitude:(double)latitude
                        longitude:(double)longitude {
    self = [super init];
    if (self) {
        _magnitude = magnitude;
        _place = [place copy];
        _time = time;
        _alert = [alert copy];
        _type = [type copy];
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSDictionary *properties = dictionary[@"properties"];
    
    // All Objective-C collections must store objects (int, long, float are wrapped in NSNumber)
    NSNumber *magnitudeNumber = properties[@"mag"];
    
    NSString *place = properties[@"place"];
    
    // How to parse time as a date?
    // NSNumber
    NSNumber *timeNumber = properties[@"time"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeNumber.longValue / 1000.0];
    
    // Alert can be "green", "yellow", "red", or null
    NSString *alert = properties[@"alert"]; // not required! (may be NSNull)
    if ([alert isKindOfClass:[NSNull class]]) {
        alert = nil; // Note: You may want to use an @"" instead of nil
    }
    NSString *type = properties[@"type"];
    
    NSDictionary *geometry = dictionary[@"geometry"];
    NSArray *coordinates = geometry[@"coordinates"];
    
    NSNumber *latitudeNumber = nil;
    NSNumber *longitudeNumber = nil;
    
    if (coordinates.count >= 2) {
        longitudeNumber = coordinates[0];
        latitudeNumber = coordinates[1]; // longitude is before latitude in array
    }
    
    // check if required properties are non-nil, otherwise return nil
    
    // alert is optional (can be null)
    if (!(magnitudeNumber || place || timeNumber || type || latitudeNumber || longitudeNumber)) {
        return nil;  // failable init if missing required
    }
    
    // return the object using the default init
    self = [self initWithMagnitude:magnitudeNumber.doubleValue place:place time:time alert:alert type:type latitude:latitudeNumber.doubleValue longitude:longitudeNumber.doubleValue];
    
    return self;
    
}

@end
