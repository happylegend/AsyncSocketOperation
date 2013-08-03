//
//  MyAsyncSocket.h
//  MyAsyncSocket
//
//  Created by 紫冬 on 13-7-31.
//  Copyright (c) 2013年 qsji. All rights reserved.
//

/*
 简介：
 CocoaAsyncSocket支持tcp和udp。该类库是进行异步操作的
 其中：
 
 AsyncSocket类是支持TCP的
 
 AsyncUdpSocket是支持UDP的
 
 AsyncSocket是封装了CFSocket和CFSteam的TCP/IP socket网络库。它提供了异步操作，本地cocoa类的基于delegate的完整支持。主要有以下特性：
 
 队列的非阻塞的读和写，而且可选超时。你可以调用它读取和写入，它会当完成后告知你
 
 自动的socket接收。如果你调用它接收连接，它将为每个连接启动新的实例，当然，也可以立即关闭这些连接
 
 委托（delegate）支持。错误、连接、接收、完整的读取、完整的写入、进度以及断开连接，都可以通过委托模式调用
 
 基于run loop的，而不是线程的。虽然可以在主线程或者工作线程中使用它，但你不需要这样做。它异步的调用委托方法，使用NSRunLoop。委托方法包括 socket的参数，可让你在多个实例中区分
 
 自包含在一个类中。你无需操作流或者socket，这个类帮你做了全部
 
 支持基于IPV4和IPV6的TCP流
 
 AsyncUdpSocket是UDP/IP socket网络库，包装自CFSocket。它的工作很像TCP版本，只不过是用于处理UDP的。它包括基于非阻塞队列的发送接收操作，完整的委托支 持，基于runloop，自包含的类，以及支持IPV4和IPV6
 */

/*
 该类主要是用来测试利用socket发送tcp请求：
 一般步骤：
 首先我们需要引入ASyncSocket库，然后添加CFNetwork框架
 第一：实现AsyncSocketDelegate协议
 第二：创建一个socket对象，设置代理对象
 第三：连接服务器connectToHost，同时设置连接的服务器网址和端口
 
 注意：发送和接收数据是异步的，不一定要按照这样的步骤顺序执行的
 第四：发送数据writeData:(NSData *)data withTimeout:(NSTimeInterval)timeout tag:(long)，可以设置超时时长
 第五：接收数据：(void) onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag 
 第六：其他不同时段的的回调函数
 
 无论SOCKET接收或者发送数据都采用NSData对象
 
 */

/*
 发送数据时候可能出现的问题，和arc相关的：
 前几天写了一篇asyncsocket使用说明的文章，几天研究之后，又有新的心得了，于是赶紧发问分享一下。如果你下载的是7.1.x版本的asyncsocket，那么你在使用它的过程中可能就会遇到问题了。
 问题在发送数据这儿，先看代码
 NSString *requestString=@"123";
 
 NSData *requestData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
 
 [asyncSocket writeData:requestData withTimeout:-1 tag:0];
 nsdata没有alloc，所以不用release，但是程序会卡死在doSendBytes这个方法里面，具体停在NSUInteger bytesRemaining = [theCurrentWrite->buffer length] - theCurrentWrite->bytesDone;网上有人说这个是要发送bytes数据，所以把发送的代码修改成
 NSString *requestString=@"123";  
 NSData *data=[[NSData alloc]initWithBytes:[requestString UTF8String] length:[requestString lengthOfBytesUsingEncoding:NSUTF8StringEncoding]]; 
 [asyncSocket writeData:data withTimeout:-1 tag:0]; 
 那么就可以正常发送数据了，但是你可能已经发现了代码中使用了initWithByte，但是后面没有release，这样就会造成内存泄露。发送的数据越多，泄漏的越多。
 原因就是7.1.X版本的asyncsocket是基于arc的，arc是xcode 4.2之后才有的一个机制，它可以自动管理内存，由于你的项目没有开启arc，所以每次都卡死在那个地方。
 
 
 */


#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@interface MyAsyncTcpSocketClient : NSObject<AsyncSocketDelegate>
{
    //定义一个socket对象
    AsyncSocket *mSocket;
}

//创建socket，开始连接
-(void)start;

//发送数据
-(void)sendData:(NSData *)data withTimerout:(NSTimeInterval)timeout tag:(long)tag;

@end
