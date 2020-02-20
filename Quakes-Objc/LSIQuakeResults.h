//
//  LSIQuakeResults.h
//  Quakes-Objc
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIQuake;

NS_ASSUME_NONNULL_BEGIN

@interface LSIQuakeResults : NSObject

@property (nonatomic, readonly, copy) NSArray<LSIQuake *> *quakes;

- (instancetype)initWithQuakes:(NSArray<LSIQuake *> *)quakes;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
