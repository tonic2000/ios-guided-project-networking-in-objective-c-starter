//
//  LSIFirstResponder.m
//  Quakes-Objc
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIFirstResponder.h"

// Class Extension
@interface LSIFirstResponder() {
    // Private instance variables
//    NSString *_name;
}

// Private properties

// Private methods

@end


@implementation LSIFirstResponder

@synthesize name = _name; // create a private instance variable

// Swift
//var name: String {
//    didSet {
//        updateViews()
//    }
//}

- (void)setName:(NSString *)name {
    // willSet
    
    // set value
    _name = [name copy];
    // Convention: property declaration creates a contract, so we need to copy, if it states copy
    
    // didSet
    // Save to database
}

- (NSString *)name {
    return _name;
}




@end
