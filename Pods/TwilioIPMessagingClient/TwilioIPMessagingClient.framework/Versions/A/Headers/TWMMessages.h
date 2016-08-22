//
//  TWMMessages.h
//  Twilio IP Messaging Client
//
//  Copyright (c) 2011-2016 Twilio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TWMConstants.h"
#import "TWMMessage.h"

/** Representation of an IP Messaging channel's message list. */
@interface TWMMessages : NSObject

/** Index of the last Message the User has consumed in this Channel. */
@property (nonatomic, copy, readonly) NSNumber *lastConsumedMessageIndex;

/** Creates a place-holder message which can be populated and sent with sendMessage:completion:

 @param body Body for new message.
 @return Place-holder TWMMessage instance
 */
- (TWMMessage *)createMessageWithBody:(NSString *)body;

/** Sends a message to the channel.
 
 @param message The message to send.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)sendMessage:(TWMMessage *)message
         completion:(TWMCompletion)completion;

/** Removes the specified message from the channel.
 
 @param message The message to remove.
 @param completion Completion block that will specify the result of the operation.
 */
- (void)removeMessage:(TWMMessage *)message
           completion:(TWMCompletion)completion;

/** Returns messages received so far from backend, messages are loaded asynchronously so this may not fully represent all history available for channel.
 
 @return Messages received by IP Messaging Client so far for the given channel.
 */
- (NSArray<TWMMessage *> *)allObjects;

/** Returns the message with the specified index.
 
 @param index The index of the message.
 @return The requested message or nil if no such message exists.
 */
- (TWMMessage *)messageWithIndex:(NSNumber *)index;

/** Returns the oldest message starting at index.  If the message at index exists, it will be returned otherwise the next oldest message that presently exists will be returned.
 
 @param index The index of the last message reported as read (may refer to a deleted message).
 @return Message at or prior to the specified index.
 */
- (TWMMessage *)messageForConsumptionIndex:(NSNumber *)index;

/** Set the last consumed index for this Member and Channel.  Allows you to set any value, including smaller than the current index.
 
 @param index The new index.
 */
- (void)setLastConsumedMessageIndex:(NSNumber *)index;

/** Update the last consumed index for this Member and Channel.  Only update the index if the value specified is larger than the previous value.
 
 @param index The new index.
 */
- (void)advanceLastConsumedMessageIndex:(NSNumber *)index;

/** Update the last consumed index for this Member and Channel to the max message currently on this device.
 */
- (void)setAllMessagesConsumed;

@end