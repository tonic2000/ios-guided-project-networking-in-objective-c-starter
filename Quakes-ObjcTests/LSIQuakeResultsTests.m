//
//  LSIQuakeResultsTests.m
//  Quakes-ObjcTests
//
//  Created by Paul Solt on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSIQuakeResults.h"
#import "LSIFileHelper.h"
#import "LSIQuake.h"
#import "LSILog.h"

@interface LSIQuakeResultsTests : XCTestCase

@end

@implementation LSIQuakeResultsTests

- (void)testQuakeResultsParsing {
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1388620296020 / 1000.0];
    
    NSData *quakeData = loadFile(@"Quakes.json", [LSIQuakeResultsTests class]);
    NSLog(@"quake: %@", quakeData); // Remove print statements in final code, only for "sanity check" when implementing
    
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:quakeData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }
    
    LSIQuakeResults *quakeResults = [[LSIQuakeResults alloc] initWithDictionary:json];
    XCTAssertNotNil(quakeResults);
    XCTAssertEqual(2, quakeResults.quakes.count);
    
    NSLog(@"Quake Results: %@", quakeResults.quakes);
    
    LSIQuake *quake = quakeResults.quakes[0];
    
    XCTAssertEqualWithAccuracy(1.29, quake.magnitude.doubleValue, 0.0001);
    XCTAssertEqualObjects(@"10km SSW of Idyllwild, CA", quake.place);
    XCTAssertEqualObjects(time, quake.time);
    
    XCTAssertEqualWithAccuracy(33.663333299999998, quake.latitude, 0.0001);
    XCTAssertEqualWithAccuracy(-116.7776667, quake.longitude, 0.0001);
    
}

@end
