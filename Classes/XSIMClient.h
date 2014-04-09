//
//  XSIMClient.h
//  XSTestProject
//
//  Created by SAIC_Zhangss on 14-4-9.
//
//

#import <Foundation/Foundation.h>
#import "CRVStompClient.h"

@interface XSIMClient : NSObject <CRVStompClientDelegate>
{
    CRVStompClient *service;
}


@end
