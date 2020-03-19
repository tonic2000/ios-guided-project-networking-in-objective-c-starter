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
- (instancetype)initWithMagnitude:(NSNumber *)magnitude
                            place:(NSString *)place
                             time:(NSDate *)time
                         latitude:(double)latitude
                        longitude:(double)longitude {
    self = [super init];
    if (self) {
        _magnitude = magnitude;
        _place = [place copy];
        _time = time;
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
        
    NSDictionary *geometry = dictionary[@"geometry"];
    NSArray *coordinates = geometry[@"coordinates"];
    
    NSNumber *latitudeNumber = nil;
    NSNumber *longitudeNumber = nil;
    
    if (coordinates.count >= 2) {
        longitudeNumber = coordinates[0];
        latitudeNumber = coordinates[1]; // longitude is before latitude in array
    }
    
    // check if required properties are non-nil, otherwise return nil
    
    // API Decision: Discard any null magnitudes, but print it out for investigation
    if ([magnitudeNumber isKindOfClass:[NSNull class]]) {
        magnitudeNumber = nil;
        NSLog(@"Mag is null: %@", dictionary);
    }
    
    // magnitude is optional
    if (!(place || timeNumber || latitudeNumber || longitudeNumber)) {
        return nil;  // failable init if missing required
    }
    
    // return the object using the default init
    self = [self initWithMagnitude:magnitudeNumber
                             place:place
                              time:time
                          latitude:latitudeNumber.doubleValue
                         longitude:longitudeNumber.doubleValue];
    
    return self;
    
}

@end
