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
    
    NSLog(@"quake: %@", quake);
    
    XCTAssertEqualWithAccuracy(1.29, quake.magnitude, 0.0001);
    XCTAssertEqualObjects(@"10km SSW of Idyllwild, CA", quake.place);
    XCTAssertEqualObjects(time, quake.time);
    
    // For now we'll just set the alert to nil, you may want to use @"" instead
    XCTAssertNil(quake.alert);
    
    XCTAssertEqualObjects(@"earthquake", quake.type);
    XCTAssertEqualWithAccuracy(33.663333299999998, quake.latitude, 0.0001);
    XCTAssertEqualWithAccuracy(-116.7776667, quake.longitude, 0.0001);
}

- (void)testQuakesParsing {
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1388620296020 / 1000.0];

    NSData *quakeData = loadFile(@"Quakes.json", [LSIQuakeTests class]);
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
    
    XCTAssertEqualWithAccuracy(1.29, quake.magnitude, 0.0001);
    XCTAssertEqualObjects(@"10km SSW of Idyllwild, CA", quake.place);
    XCTAssertEqualObjects(time, quake.time);
    
    // For now we'll just set the alert to nil, you may want to use @"" instead
    XCTAssertNil(quake.alert);
    
    XCTAssertEqualObjects(@"earthquake", quake.type);
    XCTAssertEqualWithAccuracy(33.663333299999998, quake.latitude, 0.0001);
    XCTAssertEqualWithAccuracy(-116.7776667, quake.longitude, 0.0001);

}


@end
