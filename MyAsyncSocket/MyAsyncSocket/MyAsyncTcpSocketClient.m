//
//  MyAsyncSocket.m
//  MyAsyncSocket
//
//  Created by 紫冬 on 13-7-31.
//  Copyright (c) 2013年 qsji. All rights reserved.
//

#import "MyAsyncTcpSocketClient.h"

@implementation MyAsyncTcpSocketClient

//创建socket，开始连接
-(void)start
{
    //第一：创建socket，设置代理
    mSocket = [[AsyncSocket alloc] initWithDelegate:self];
    
    //第二：连接服务器，设置所要连接的服务器的地址和端口号
    //下面是几个常用的连接服务器的函数
    /*
    NSData *data = [[NSData alloc] init];
    NSError *error = nil;
    [mSocket connectToAddress:data error:&error];
    [mSocket connectToAddress:data viaInterfaceAddress:data withTimeout:0 error:&error];
    [mSocket connectToAddress:data withTimeout:0 error:&error];
    [mSocket connectToHost:@"192.168.1.12" onPort:9999 withTimeout:0 error:&error];
    */
    
    NSError *error = nil;
    if (![mSocket connectToHost:@"192.168.1.13" onPort:9999 error:&error])
    {
        NSLog(@"Error is: %@", error);
    }
    
    //所以我们通过mSocket可以取得服务器的地址，端口号，是否是ipv4或ipv6
    /*
    NSData *mmdata = [mSocket connectedAddress];;
    NSString *host = [mSocket connectedHost];
    int port = [mSocket connectedPort];
     */
    
    //断开socket
    [mSocket disconnect];
    [mSocket disconnectAfterReading];
    [mSocket disconnectAfterReadingAndWriting];
    [mSocket disconnectAfterWriting];
}


//发送数据，我们需要调用writeData函数
-(void)sendData:(NSData *)data withTimerout:(NSTimeInterval)timeout tag:(long)tag
{
    //设置数据，超时时长
    [mSocket writeData:data withTimeout:5 tag:0];
}

//下面是一些常用的回调函数

//当这个socket是连接的时候，这个方法将会返回一个YES继续或者一个NO停止。
//-(BOLL)onSocketWillConnect:(AsyncSocket *)sock;
//当socket连接并准备读和写。
//这个host参数是一个IP不是一个域名。
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    
}

//接收数据，我们需要实现回调函数
//当pocket已经完成到读取内存中的数据请求。
//如果发生错误将不会访问。
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    //当我们接收到服务器的数据以后，我们需要将NSData转化成原来的数据类型，如果原来的数据类型是NSString
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收服务器的数据是：%@", result);
}

//当socket完成写数据请求的时候。
-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
}

//当Socket接受一个连接的时候被调用。
//另一个socket来处理它。
//这个新的socket有同样的代理并且将会调用"onSocket:didConnectToHost:port;"
-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
    
}

//在socket连结发生错误的时候，socket被关闭。
//在断开之前你可以读取断开之前最后的bit数据
//当连接的时候，这个代理的方法可能被执行。
-(void) onSocket:(AsyncSocket *) sock willDisConnectWithError:(NSError *)err
{
    
}

//当socket断开或者没有错误的时候，被调用。
//如果你想在socket断开之后释放socket就在这个方法中在进行。
//在“onSocket:willDisconnectWithError”中是不安全的。
//如果你在socket没真正断开，调用该方法，该方法在断开连接方法返回之前将会被调用。
-(void) onSocketDidDisconnect:(AsyncSocket *) sock
{
    
}

//一个新的socket来处理这个连接的时候被调用。
//在这个新的socket中这个方法应该返回一个run－loop的线程这个代理应该管理。
-(NSRunLoop *)onSocket:(AsyncSocket *)sock wantsRunLoopForNewSocket:(AsyncSocket *)newSocket
{
    return [NSRunLoop currentRunLoop];
}

//当socket读取数据并且没有完成。
//如果使用readToData:或者是 readToLength方法将会发生。
//它在进度条更新的时候可能被使用。
-(void)onSocket:(AsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
    
}


//当socket写数据但是没完成的时候会被调用，可适用于进度条更新的时候。
-(void)onSocket:(AsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
    
}

-(NSTimeInterval)onSocket:(AsyncSocket *)sock shouldTimeroutReadWithTag:(long)tag  elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
{
    return 0;
}


@end
