//
//  MyAsyncTcpSocketServer.m
//  MyAsyncSocket
//
//  Created by 紫冬 on 13-8-3.
//  Copyright (c) 2013年 qsji. All rights reserved.
//

#import "MyAsyncTcpSocketServer.h"

@implementation MyAsyncTcpSocketServer

//创建socket，开始连接
-(void)start
{
    //创建一个服务器端的socket，设置代理
    mServerSocket = [[AsyncSocket alloc] initWithDelegate:self];
    
    NSError *err = nil;    
    if ([mServerSocket acceptOnPort:4322 error:&err])     //服务器端监听该端口，是否由数据来
    {
        NSLog(@"accept ok.");
    }
    else
    {
        NSLog(@"accept failed.");
    }
}

//发送数据
-(void)sendData:(NSData *)data withTimerout:(NSTimeInterval)timeout tag:(long)tag
{
    [mServerSocket writeData:data withTimeout:timeout tag:tag];
}

//回调函数

//创建了新的Socket用于处理和客户端的请求，如果这个新socket实例你不打算保留（retain），那么将拒绝和该客户端连接
- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
    if (!mServerSocket)
    {
        mServerSocket=[newSocket retain];
        NSLog(@"did accept new socket");
    }
}

//提供线程的runloop实例给AsyncSocket，后者将使用这个runloop执行socket通讯的操作
- (NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket
{
    NSLog(@"wants runloop for new socket.");
    return [NSRunLoop currentRunLoop];
}

//将要建立连接，这时可以做一些准备工作，如果需要的话
- (BOOL)onSocketWillConnect:(AsyncSocket *)sock
{
    NSLog(@"will connect");
    return YES;
}

//这个方法是建立连接后执行的，一般会在这里调用写入或者读取socket的操作
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"did connect to host");
    [mServerSocket readDataWithTimeout:-1 tag:1];
}

//读取从客户端发来的数据数据
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"did read data");
    NSString* message = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"message is: \n%@",message);
    [mServerSocket writeData:data withTimeout:2 tag:1];
}

//发送完了数据以后执行
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"message did write");
    [mServerSocket readDataWithTimeout:-1 tag:1];
}

//当socket将要失去连接的时候执行
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"onSocket:%p willDisconnectWithError:%@", sock, err);
}

//当socket失去连接以后执行
- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"socket did disconnect");
    [mServerSocket release];
    mServerSocket = nil;
}

@end
