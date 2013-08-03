//
//  MyAsyncUdpSocket.h
//  MyAsyncSocket
//
//  Created by 紫冬 on 13-7-31.
//  Copyright (c) 2013年 qsji. All rights reserved.
//

/*
 udp和tcp是不同的，udp是无连接的，tcp是有连接得，所以udp是不分什么客户端和服务器端的，两端是平等的
 */

#import <Foundation/Foundation.h>
#import "AsyncUdpSocket.h"

@interface MyAsyncUdpSocketClient1 : NSObject<AsyncUdpSocketDelegate>
{
    AsyncUdpSocket *mUdpSocket1;
}

//创建udp，开始工作
-(void)start;

@end
