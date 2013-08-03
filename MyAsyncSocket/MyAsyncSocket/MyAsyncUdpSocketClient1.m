//
//  MyAsyncUdpSocket.m
//  MyAsyncSocket
//
//  Created by 紫冬 on 13-7-31.
//  Copyright (c) 2013年 qsji. All rights reserved.
//

#import "MyAsyncUdpSocketClient1.h"

@implementation MyAsyncUdpSocketClient1

//创建udp，开始工作
-(void)start
{
    //创建udpSocket
    mUdpSocket1 = [[AsyncUdpSocket alloc] initWithDelegate:self];
    
    //设置超时，表示发送数据以后，收到回应数据的时间
    [mUdpSocket1 receiveWithTimeout:10 tag:0];
    
    //如果你发送广播，这里必须先enableBroadcast
    /*
    [mUdpSocket1 enableBroadcast:YES error:nil];
     */
    
    //发送数据
    [mUdpSocket1 sendData:nil toHost:@"192.168.3.4" port:9999 withTimeout:10 tag:0];
    /*
     如果发送的是广播，那么host要写成@"255.255.255.255"，发送的时候，port写成0，意思是系统自动选择端口号
     [mUdpSocket1 sendData:nil toHost:@"255.255.255.255" port:0 withTimeout:10 tag:0];
     */
    
    //断开udp
    [mUdpSocket1 close];
    [mUdpSocket1 closeAfterReceiving];
    [mUdpSocket1 closeAfterSending];
    [mUdpSocket1 closeAfterSendingAndReceiving];
}

//常用的回调函数

//当发送了数据以后调用
-(void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    
}

//发送数据失败以后失败
-(void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    
}

//接收到数据以后调用，在该函数中处理接收到的数据
-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    //处理接收到的数据
    //......
    //......
    
    return true;
}

//如果超过设置的超时时长，调用
-(void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error
{
    
}

//关闭udpSocket的时候调用
-(void)onUdpSocketDidClose:(AsyncUdpSocket *)sock
{
    
}


@end
