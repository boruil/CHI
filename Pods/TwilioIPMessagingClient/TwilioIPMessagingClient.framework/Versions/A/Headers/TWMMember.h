//
//  TWMMember.h
//  Twilio IP Messaging Client
//
//  Copyright (c) 2011-2016 Twilio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TWMUserInfo.h"

/** Representation of a Member on an IP Messaging channel. */
@interface TWMMember : NSObject

/** Returns the username.
 
 @return The username for this member.
 @deprecated Please use userInfo.identity instead.
 */
- (NSString *)identity DEPRECATED_MSG_ATTRIBUTE("Please use userInfo.identity");

/** The info for this member. */
@property (nonatomic, strong, readonly) TWMUserInfo *userInfo;

/** Index of the last Message the Member has consumed in this Channel. */
@property (nonatomic, copy, readonly) NSNumber *lastConsumedMessageIndex;

/** Timestamp the last consumption updated for the Member in this Channel. */
@property (nonatomic, copy, readonly) NSString *lastConsumptionTimestamp;

@end
