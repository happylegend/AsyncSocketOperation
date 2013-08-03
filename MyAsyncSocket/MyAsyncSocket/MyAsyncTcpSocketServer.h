//
//  MyAsyncTcpSocketServer.h
//  MyAsyncSocket
//
//  Created by 紫冬 on 13-8-3.
//  Copyright (c) 2013年 qsji. All rights reserved.
//

/*
 服务器端的流程和客户端的原理类似，不同的是，初始化服务器端的socket的时候，只需要指定端口号即可;
 然后只需要accept该端口即可，不同于客户端需要连接connectToHost，因为服务器等待客户端的请求
 注意：
 服务器端和客户端将建立长连接。直至客户端断开连接，服务器端才释放相应的socket。
 timeout设置为-1，这样就可以保持长连接状态。
 
 我们发现无论是客户端还是服务器端都是使用的是AsyncSocket对象，那么就说明其实客户端和服务器端在结构上是相同的，只是逻辑是不同的，而实现逻辑不同的就是调用不同的函数
 */

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@interface MyAsyncTcpSocketServer : NSObject<AsyncSocketDelegate>
{
    AsyncSocket *mServerSocket;
}

//创建socket，开始连接
-(void)start;

//发送数据
-(void)sendData:(NSData *)data withTimerout:(NSTimeInterval)timeout tag:(long)tag;

@end
