//
//  LSIFirstResponder.h
//  Quakes-Objc
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIFirstResponder : NSObject

// readwrite is default, so you don't need to specify
@property (nonatomic, readwrite, copy) NSString *name;

// Compiler Default to creating 3 items (unless we override them)
// 1. setter
//- (void)setName:(NSString *)name;

// 2. getter
//- (NSString *)name;

// 3. instance variable (backing store)
// NSString *_name;

// Property Rule: If you define all of the getters/setters that are available, you need to
// provide the backing variable (computed property)

@end


NS_ASSUME_NONNULL_END
