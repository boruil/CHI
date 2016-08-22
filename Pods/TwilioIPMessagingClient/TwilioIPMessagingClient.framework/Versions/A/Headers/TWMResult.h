//
//  TWMResult.h
//  Twilio IP Messaging Client
//
//  Copyright (c) 2011-2016 Twilio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TWMError.h"

/** Result class passed via completion blocks.  Contains a boolean property, -isSuccessful, which
 indicates the result of the operation and an error object if the operation failed.
 */
@interface TWMResult : NSObject

/** The result's TWMError if the operation failed. */
@property (nonatomic, strong, readonly) TWMError *error;

/** Indicates the success or failure of the given operation.
 
 @return Boolean YES if the operation was successful, NO otherwise.
 */
- (BOOL)isSuccessful;

@end
