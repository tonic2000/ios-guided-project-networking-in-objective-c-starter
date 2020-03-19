//
//  LSIQuakeResults.m
//  Quakes-Objc
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIQuakeResults.h"
#import "LSIQuake.h"

@implementation LSIQuakeResults

- (instancetype)initWithQuakes:(NSArray<LSIQuake *> *)quakes {
    self = [super init];
    if (self) {
        _quakes = quakes;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    // To parse an array you need to iterate over the array of dictionaries
    
    NSArray *quakeDictionaries = dictionary[@"features"];
    NSMutableArray *quakes = [[NSMutableArray alloc] init];
    
    for (NSDictionary *quakeDictionary in quakeDictionaries) {
        LSIQuake *quake = [[LSIQuake alloc] initWithDictionary: quakeDictionary];
        if (quake) { // store it if it's valid, ignore it if it's not
            [quakes addObject: quake];
        } else {
            // TODO: One of our "required" fields might be optional and we may need to debug this with real data
            NSLog(@"Unable to parse quake dictionary: %@", quakeDictionary);
        }
    }
    
    self = [self initWithQuakes:quakes];
    return self;
}

@end
