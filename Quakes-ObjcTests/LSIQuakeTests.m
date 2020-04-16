//
//  LSIQuakeTests.m
//  Quakes-ObjcTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIFileHelper.h"
#import "LSILog.h"
#import "LSIQuake.h"
#import "LSIQuakeResults.h"

@interface LSIQuakeTests : XCTestCase

@end

@implementation LSIQuakeTests

- (void)testQuakeParsing {
    
    NSData *quakeData = loadFile(@"Quake.json", [LSIQuakeTests class]);
    //    NSLog(@"quake: %@", quakeData); // Remove print statements in final code, only for "sanity check" when implementing
    
    NSError *jsonError = nil;
    NSDictionary *quakeDictionary = [NSJSONSerialization JSONObjectWithData:quakeData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }
    
    // Parse the dictionary and turn it into a Quake object
    //    NSLog(@"JSON: %@", quakeDictionary);  // Remove or comment out print statements in final test
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1388620296020 / 1000.0];
    LSIQuake *quake = [[LSIQuake alloc] initWithDictionary:quakeDictionary];
    
    XCTAssertEqualWithAccuracy(1.29, quake.magnitude.doubleValue, 0.0001);
    XCTAssertEqualObjects(@"10km SSW of Idyllwild, CA", quake.place);
    XCTAssertEqualObjects(time, quake.time);
    XCTAssertEqualWithAccuracy(33.663333299999998, quake.latitude, 0.0001);
    XCTAssertEqualWithAccuracy(-116.7776667, quake.longitude, 0.0001);
}

- (void)testQuakeParsingNilMagnitudeIsNil {
    
    NSData *quakeData = loadFile(@"QuakeWithNullMag.json", [LSIQuakeTests class]);
    //    NSLog(@"quake: %@", quakeData); // Remove print statements in final code, only for "sanity check" when implementing
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581846000490 / 1000.0];
    
    NSError *jsonError = nil;
    NSDictionary *quakeDictionary = [NSJSONSerialization JSONObjectWithData:quakeData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }
    
    LSIQuake *quake = [[LSIQuake alloc] initWithDictionary: quakeDictionary];
    NSLog(@"quake: %@", quake);
    
    XCTAssertNil(quake.magnitude);
    XCTAssertEqualObjects(@"10km NW of The Geysers, CA", quake.place);
    XCTAssertEqualObjects(time, quake.time);
    XCTAssertEqualWithAccuracy(38.837499999999999, quake.latitude, 0.0001);
    XCTAssertEqualWithAccuracy(-122.8368333, quake.longitude, 0.0001);
}

@end
