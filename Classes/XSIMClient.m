//
//  XSIMClient.m
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-4-9.
//
//

#import "XSIMClient.h"

#define kUserName @"name"
#define kPassword @"pwd"
#define kQueueName @"/topic/systemMessagesTopic"

@implementation XSIMClient

- (void)registerService{
    service = [[CRVStompClient alloc] initWithHost:@"localhost" port:61613 login:kUserName passcode:kPassword delegate:self autoconnect:YES];
    [service connect];
    
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"client",@"ack",
                             @"true",@"activemq.dispatchAsync",
                             @"1",@"activemq.prefetchSize"
                             ,nil];
    [service subscribeToDestination:kQueueName withHeader:headers];
}


#pragma mark CRVStompClientDelegate
- (void)stompClient:(CRVStompClient *)stompService messageReceived:(NSString *)body withHeader:(NSDictionary *)messageHeader
{
    //收到信息之后 反馈给服务器
    [stompService ack:[messageHeader valueForKey:@"message-id"]];
}

- (void)stompClientDidDisconnect:(CRVStompClient *)stompService
{

}
- (void)stompClientWillDisconnect:(CRVStompClient *)stompService withError:(NSError*)error
{

}
- (void)stompClientDidConnect:(CRVStompClient *)stompService
{
    
}
- (void)serverDidSendReceipt:(CRVStompClient *)stompService withReceiptId:(NSString *)receiptId
{

}

- (void)serverDidSendError:(CRVStompClient *)stompService withErrorMessage:(NSString *)description detailedErrorMessage:(NSString *) theMessage
{

}


@end
