---
title: Send data segment over TCP by using Winsock
description: This article provides a series of recommendations for sending small data packets efficiently from a Winsock application.
ms.date: 02/27/2020
ms.custom: sap:Networking development
ms.technology: windows-dev-apps-networking-dev
---
# Design issues - Sending small data segments over TCP with Winsock

When you need to send small data packets over TCP, the design of your Winsock application is especially critical. A design that doesn't take into account the interaction of delayed acknowledgment, the Nagle algorithm, and Winsock buffering can drastically affect performance. This article discusses these issues by using a couple of cases studies. It also derives a series of recommendations for sending small data packets efficiently from a Winsock application.

_Original product version:_ &nbsp; Winsock  
_Original KB number:_ &nbsp; 214397

## Background

When a Microsoft TCP stack receives a data packet, a 200-ms delay timer goes off. When an ACK is sent, the delay timer is reset and will start another 200 ms delay when the next data packet is received. To increase the efficiency in both Internet and the intranet applications, TCP stack uses the following criteria to decide when to send one ACK on received data packets:

- If the second data packet is received before the delay timer expires, the ACK is sent.
- If there are data to be sent in the same direction as the ACK before the second data packet is received and the delay timer expires, the ACK is piggybacked with the data segment and sent immediately.
- When the delay timer expires, the ACK is sent.
  
To avoid having small data packets congest the network, TCP stack enables the Nagle algorithm by default, which coalesces a small data buffer from multiple send calls and delays sending it until an ACK for the previous data packet sent is received from the remote host. The following are two exceptions to the Nagle algorithm:

- If the stack has coalesced a data buffer larger than the Maximum Transmission Unit (MTU), a full-sized packet is sent immediately without waiting for the ACK from the remote host. On an Ethernet network, the MTU for TCP/IP is 1460 bytes.

- The `TCP_NODELAY` socket option is applied to disable the Nagle algorithm so that the small data packets are delivered to the remote host without delay.

To optimize performance at the application layer, Winsock copies data buffers from application send calls to a Winsock kernel buffer. Then, the stack uses its own heuristics (such as Nagle algorithm) to determine when to actually put the packet on the wire. You can change the amount of Winsock kernel buffer allocated to the socket using the `SO_SNDBUF` option (it's 8K by default). If necessary, Winsock can buffer more than the `SO_SNDBUF` buffer size. In most cases, the send completion in the application only indicates the data buffer in an application send call is copied to the Winsock kernel buffer and doesn't indicate that the data has hit the network medium. The only exception is when you disable the Winsock buffering by setting `SO_SNDBUF` to 0.

Winsock uses the following rules to indicate a send completion to the application (depending on how the send is invoked, the completion notification could be the function returning from a blocking call, signaling an event, or calling a notification function, and so forth):

- If the socket is still within SO_SNDBUF quota, Winsock copies the data from the application send and indicates the send completion to the application.

- If the socket is beyond `SO_SNDBUF` quota and there's only one previously buffered send still in the stack kernel buffer, Winsock copies the data from the application send and indicates the send completion to the application.
  
- If the socket is beyond `SO_SNDBUF` quota and there's more than one previously buffered send in the stack kernel buffer, Winsock copies the data from the application send. Winsock doesn't indicate the send completion to the application until the stack completes enough sends to put back the socket within `SO_SNDBUF` quota or only one outstanding send condition.

## Case study 1

A Winsock TCP client needs to send 10000 records to a Winsock TCP server to store in a database. The size of the records varies from 20 bytes to 100 bytes long. To simplify the application logic, the design is as follows:

- The client does blocking send only. The server does blocking `recv` only.
- The client socket sets the `SO_SNDBUF` to 0 so that each record goes out in a single data segment.
- The server calls `recv` in a loop. The buffer posted in `recv` is 200 bytes so that each record can be received in one `recv` call.

### Performance

During testing, the developer finds the client could only send five records per second to the server. The total 10000 records, maximum at 976 kb of data (10000 * 100 / 1024), takes more than half an hour to send to the server.

### Analysis

Because the client doesn't set the `TCP_NODELAY` option, the Nagle algorithm forces the TCP stack to wait for an ACK before it can send another packet on the wire. However, the client has disabled the Winsock buffering by setting the `SO_SNDBUF` option to 0. Therefore, the 10000 send calls have to be sent and ACK'ed individually. Each ACK is delayed 200 ms because the following occurs on the server's TCP stack:

- When the server gets a packet, its 200-ms delay timer goes off.
- The server does not need to send anything back, so the ACK cannot be piggybacked.
- The client will not send another packet unless the previous packet is acknowledged.
- The delay timer on the server expires and the ACK is sent back.

### How to improve

There are two problems with this design. First, there is the delay timer issue. The client needs to be able to send two packets to the server within 200 ms. Because the client uses the Nagle algorithm by default, it should just use the default Winsock buffering and not set `SO_SNDBUF` to 0. Once the TCP stack has coalesced a buffer larger than the Maximum Transmission Unit (MTU), a full-sized packet is sent immediately without waiting for the ACK from the remote host.

Secondly, this design calls one send for each record of such small size. Sending this small of a size is not efficient. In this case, the developer might want to pad each record to 100 bytes and send 80 records at a time from one client send call. To let the server know how many records will be sent in total, the client might want to start off the communication with a fix-sized header containing the number of records to follow.

## Case study 2

A Winsock TCP client application opens two connections with a Winsock TCP server application providing stock quotes service. The first connection is used as a command channel to send the stock symbol to the server. The second connection is used as a data channel to receive the stock quote. After the two connections have been established, the client sends a stock symbol to the server through the command channel and waits for the stock quote to come back through the data channel. It sends the next stock symbol request to the server only after the first stock quote has been received. The client and the server do not set the `SO_SNDBUF` and `TCP_NODELAY` option.

- **Performance**

    During testing, the developer finds the client could only get five quotes per second.

- **Analysis**

    This design only allows one outstanding stock quote request at a time. The first stock symbol is sent to the server through the command channel (connection) and a response is immediately sent back from the server to the client over the data channel (connection). Then, the client immediately sends the second stock symbol request and the send returns immediately as the request buffer in the send call is copied to the Winsock kernel buffer. However, the client TCP stack cannot send the request from its kernel buffer immediately because the first send over the command channel is not acknowledged yet. After the 200-ms delay timer at the server command channel expires, the ACK for the first symbol request comes back to the client. Then, the second quote request is successfully sent to the server after being delayed for 200 ms. The quote for the second stock symbol comes back immediately through the data channel because, at this time, the delay timer at the client data channel has expired. An ACK for the previous quote response is received by the server. (Remember that the client could not send a second stock quote request for 200 ms, thus giving time for the delay timer on the client to expire and send an ACK to the server.) As a result, the client gets the second quote response and can issue another quote request, which is subject to the same cycle.

- **How to improve**

    The two connection (channel) design is unnecessary here. If you use only one connection for the stock quote request and response, the ACK for the quote request can be piggybacked on the quote response and come back immediately. To further improve the performance, the client could *multiplex* multiple stock quote requests into one send call to the server and the server could also *multiplex* multiple quote responses into one send call to the client. If the two unidirectional channel design is necessary for some reason, both sides should set the `TCP_NODELAY` option so that the small packets can be sent immediately without having to wait for an ACK for the previous packet.

## Recommendations

While these two case studies are fabricated, they help to illustrate some worst case scenarios. When you design an application that involves extensive small data segment sends and `recvs`, you should consider the following guidelines:

- If the data segments are not time critical, the application should coalesce them into a larger data block to pass to a send call. Because the send buffer is likely to be copied to the Winsock kernel buffer, the buffer should not be too large. Slightly less than 8K is effective. As long as the Winsock kernel gets a block larger than the MTU, it will send out multiple full-sized packets and a last packet with whatever is left. The sending side, except the last packet, will not be hit by the 200-ms delay timer. The last packet, if it happens to be an odd-numbered packet, is still subject to the delayed acknowledgment algorithm. If the sending end stack gets another block larger than the MTU, it can still bypass the Nagle algorithm.
  
- If possible, avoid socket connections with unidirectional data flow. Communications over unidirectional sockets are more easily impacted by the Nagle and delayed acknowledgment algorithms. If the communication follows a request and a response flow, you should use a single socket to do both sends and `recvs` so that the ACK can be piggybacked on the response.

- If all the small data segments have to be sent immediately, set `TCP_NODELAY` option on the sending end.

- Unless you want to guarantee a packet is sent on the wire when a send completion is indicated by Winsock, you should not set the `SO_SNDBUF` to zero. In fact, the default 8K buffer has been heuristically determined to work well for most situations and you should not change it unless you have tested that your new Winsock buffer setting gives you better performance than the default. Also, setting `SO_SNDBUF` to zero is mostly beneficial for applications that do bulk data transfer. Even then, for maximum efficiency you should use it in conjunction with double buffering (more than one outstanding send at any given time) and overlapped I/O.

- If the data delivery does not have to be guaranteed, use UDP.

## References

For more information about Delayed Acknowledgment and the Nagle algorithm, see the following:

Braden, R.[1989], RFC 1122, Requirements for Internet Hosts--Communication Layers, Internet Engineering Task Force.
