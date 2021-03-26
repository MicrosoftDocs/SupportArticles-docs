---
title: The three-way handshake via TCP/IP
description: Discusses the process of the Transmission Control Protocol (TCP) three-way handshake between a client and server when starting or ending a TCP connection.
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: ralphc, kaushika
ms.prod-support-area-path: TCP/IP communications
ms.technology: networking
---
# Explanation of the three-way handshake via TCP/IP

This article discusses the Transmission Control Protocol (TCP) three-way handshake process between a client and server when starting or ending a TCP connection.

_Original product version:_ &nbsp;  Windows Server 2012 R2  
_Original KB number:_ &nbsp; 172983

## Summary

This article is intended for audiences who are familiar with Transmission Control Protocol/Internet Protocol (TCP/IP). It discusses the process of the TCP three-way handshake between a client and server when starting or ending a TCP connection.

## More information

The TCP level of the TCP/IP transport protocol is connection-oriented. Connection-oriented means that, before any data can be transmitted, a reliable connection must be obtained and acknowledged. TCP level data transmissions, connection establishment, and connection termination maintain specific control parameters that govern the entire process. The control bits are listed as follows:

URG: Urgent Pointer field significant  
ACK: Acknowledgment field significant  
PSH: Push Function  
RST: Reset the connection  
SYN: Synchronize sequence numbers  
FIN: No more data from sender  

There are two scenarios where a three-way handshake will take place:

- Establishing a connection (an active open)

- Ending a connection (an active close)

The following sample information was obtained from a Network Monitor capture. Network Monitor is a protocol analyzer that can be obtained from Microsoft Systems Management Server.

### Establishing a connection

The following sequence shows the process of a TCP connection being established:

Frame 1:

As you see in the first frame, the client, NTW3, sends a SYN segment (`TCP ....S.`). It's a request to the server to synchronize the sequence numbers. It specifies its initial sequence number (ISN). The ISN is incremented by 1 (8221821+1=8221822), and is sent to the server. To start a connection, the client and server must synchronize each other's sequence numbers. There's also an option for the Maximum Segment Size (MSS) to be set, which is defined by the length (len: 4). This option communicates the MSS the sender wants to receive. The Acknowledgment field (ack: 0) is set to zero because it's the first part of the three-way handshake.

```console

1 2.0785 NTW3 --> BDC3 TCP ....S., len: 4, seq: 8221822-8221825, ack: 0,
win: 8192, src: 1037 dst: 139 (NBT Session) NTW3 --> BDC3 IP

TCP: ....S., len: 4, seq: 8221822-8221825, ack: 0, win: 8192, src: 1037
dst: 139 (NBT Session)

TCP: Source Port = 0x040D
 TCP: Destination Port = NETBIOS Session Service
 TCP: Sequence Number = 8221822 (0x7D747E)
 TCP: Acknowledgement Number = 0 (0x0)
 TCP: Data Offset = 24 (0x18)
 TCP: Reserved = 0 (0x0000)
 TCP: Flags = 0x02 : ....S.

TCP: ..0..... = No urgent data
 TCP: ...0.... = Acknowledgement field not significant
 TCP: ....0... = No Push function
 TCP: .....0.. = No Reset
 TCP: ......1. = Synchronize sequence numbers
 TCP: .......0 = No Fin

TCP: Window = 8192 (0x2000)
 TCP: Checksum = 0xF213
 TCP: Urgent Pointer = 0 (0x0)
 TCP: Options

TCP: Option Kind (Maximum Segment Size) = 2 (0x2)
 TCP: Option Length = 4 (0x4)
 TCP: Option Value = 1460 (0x5B4)

TCP: Frame Padding

00000: 02 60 8C 9E 18 8B 02 60 8C 3B 85 C1 08 00 45 00 .`.....`.;....E.
00010: 00 2C 0D 01 40 00 80 06 E1 4B 83 6B 02 D6 83 6B .,..@....K.k...k
00020: 02 D3 04 0D 00 8B 00 7D 74 7E 00 00 00 00 60 02 .......}t~....`.
00030: 20 00 F2 13 00 00 02 04 05 B4 20 20 .........

```

Frame 2:

As you see in the second frame, the server, BDC3, sends an ACK and SYN segment (`TCP .A..S.`). In this segment, the server is acknowledging the request of the client for synchronization. Meanwhile, the server is also sending its request to the client for synchronization of its sequence numbers. There's one major difference in this segment. The server transmits an acknowledgment number (8221823) to the client. The acknowledgment is just proof to the client that the ACK is specific to the SYN the client initiated. The process of acknowledging the client's request allows the server to increment the client's sequence number by one and uses it as its acknowledgment number.

```console

2 2.0786 BDC3 --> NTW3 TCP .A..S., len: 4, seq: 1109645-1109648, ack:
8221823, win: 8760, src: 139 (NBT Session) dst: 1037 BDC3 --> NTW3 IP

TCP: .A..S., len: 4, seq: 1109645-1109648, ack: 8221823, win: 8760,
src: 139 (NBT Session) dst: 1037

TCP: Source Port = NETBIOS Session Service
 TCP: Destination Port = 0x040D
 TCP: Sequence Number = 1109645 (0x10EE8D)
 TCP: Acknowledgement Number = 8221823 (0x7D747F)
 TCP: Data Offset = 24 (0x18)
 TCP: Reserved = 0 (0x0000)
 TCP: Flags = 0x12 : .A..S.

TCP: ..0..... = No urgent data
 TCP: ...1.... = Acknowledgement field significant
 TCP: ....0... = No Push function
 TCP: .....0.. = No Reset
 TCP: ......1. = Synchronize sequence numbers
 TCP: .......0 = No Fin

TCP: Window = 8760 (0x2238)
 TCP: Checksum = 0x012D
 TCP: Urgent Pointer = 0 (0x0)
 TCP: Options

TCP: Option Kind (Maximum Segment Size) = 2 (0x2)
 TCP: Option Length = 4 (0x4)
 TCP: Option Value = 1460 (0x5B4)

TCP: Frame Padding

00000: 02 60 8C 3B 85 C1 02 60 8C 9E 18 8B 08 00 45 00 .`.;...`......E.
00010: 00 2C 5B 00 40 00 80 06 93 4C 83 6B 02 D3 83 6B .,[.@....L.k...k
00020: 02 D6 00 8B 04 0D 00 10 EE 8D 00 7D 74 7F 60 12 ...........}t`.
00030: 22 38 01 2D 00 00 02 04 05 B4 20 20 "8.-......

```

Frame 3:

As you see in the third frame, the client sends an ACK segment (`TCP .A....`). In this segment, the client is acknowledging the request from the server for synchronization. The client uses the same algorithm the server implemented in providing an acknowledgment number. The client's acknowledgment of the server's request for synchronization completes the process of establishing a reliable connection and the three-way handshake.

```console

3 2.787 NTW3 --> BDC3 TCP .A...., len: 0, seq: 8221823-8221823, ack:
1109646, win: 8760, src: 1037 dst: 139 (NBT Session) NTW3 --> BDC3 IP

TCP: .A...., len: 0, seq: 8221823-8221823, ack: 1109646, win: 8760,
src: 1037 dst: 139 (NBT Session)

TCP: Source Port = 0x040D
 TCP: Destination Port = NETBIOS Session Service
 TCP: Sequence Number = 8221823 (0x7D747F)
 TCP: Acknowledgement Number = 1109646 (0x10EE8E)
 TCP: Data Offset = 20 (0x14)
 TCP: Reserved = 0 (0x0000)
 TCP: Flags = 0x10 : .A....

TCP: ..0..... = No urgent data
 TCP: ...1.... = Acknowledgement field significant
 TCP: ....0... = No Push function
 TCP: .....0.. = No Reset
 TCP: ......0. = No Synchronize
 TCP: .......0 = No Fin

TCP: Window = 8760 (0x2238)
 TCP: Checksum = 0x18EA
 TCP: Urgent Pointer = 0 (0x0)
 TCP: Frame Padding

00000: 02 60 8C 9E 18 8B 02 60 8C 3B 85 C1 08 00 45 00 .`.....`.;....E.
00010: 00 28 0E 01 40 00 80 06 E0 4F 83 6B 02 D6 83 6B .(..@....O.k...k
00020: 02 D3 04 0D 00 8B 00 7D 74 7F 00 10 EE 8E 50 10 .......}t....P.
00030: 22 38 18 EA 00 00 20 20 20 20 20 20 "8....

```

### Ending a connection

Although the three-way handshake only requires three packets to be transmitted over our networked media, the termination of this reliable connection needs to transmit four packets. Because a TCP connection is full-duplex (data can flow in each direction independent of the other), each direction must be terminated independently.

Frame 4:

In this session of frames, you see the client sending a FIN that's accompanied by an ACK (`TCP .A...F`). This segment has two basic functions. First, when the FIN parameter is set, it will inform the server that it has no more data to send. Second, the ACK is essential in identifying the specific connection they've established.

```console

4 16.0279 NTW3 --> BDC3 TCP .A...F, len: 0, seq: 8221823-8221823,
ack:3462835714, win: 8760, src: 2337 dst: 139 (NBT Session) NTW3 --> BDC3
IP

TCP: .A...F, len: 0, seq: 8221823-8221823, ack: 1109646, win: 8760, src:
1037 dst: 139 (NBT Session)

TCP: Source Port = 0x040D
 TCP: Destination Port = NETBIOS Session Service
 TCP: Sequence Number = 8221823 (0x7D747F)
 TCP: Acknowledgement Number = 1109646 (0x10EE8E)
 TCP: Data Offset = 20 (0x14)
 TCP: Reserved = 0 (0x0000)
 TCP: Flags = 0x11 : .A...F

TCP: ..0..... = No urgent data
 TCP: ...1.... = Acknowledgement field significant
 TCP: ....0... = No Push function
 TCP: .....0.. = No Reset
 TCP: ......0. = No Synchronize
 TCP: .......1 = No more data from sender

TCP: Window = 8760 (0x2238)
 TCP: Checksum = 0x236C
 TCP: Urgent Pointer = 0 (0x0)

00000: 00 20 AF 47 93 58 00 A0 C9 22 F5 39 08 00 45 00 . .G.X...".9..E.
00010: 00 28 9B F5 40 00 80 06 21 4A C0 5E DE 7B C0 5E .(..@...!J.^.{.^
00020: DE 57 09 21 05 48 0B 20 96 AC CE 66 AE 02 50 11 .W.!.H. ...f..P.
00030: 22 38 23 6C 00 00 "8#l..

```

Frame 5:

In this frame, you don't see anything special except for the server acknowledging the FIN that was transmitted from the client.

```console

5 16.0281 BDC3 --> NTW3 TCP .A...., len: 0, seq: 1109646-1109646,
ack: 8221824, win:28672, src: 139 dst: 2337 (NBT Session) BDC3 --> NTW3
IP

TCP: .A...., len: 0, seq: 1109646-1109646, ack: 8221824, win:28672, src:
139 dst: 2337 (NBT Session)

TCP: Source Port = 0x040D
 TCP: Destination Port = NETBIOS Session Service
 TCP: Sequence Number = 1109646 (0x10EE8E)
 TCP: Acknowledgement Number = 8221824 (0x7D7480)
 TCP: Data Offset = 20 (0x14)
 TCP: Reserved = 0 (0x0000)
 TCP: Flags = 0x10 : .A....

TCP: ..0..... = No urgent data
 TCP: ...1.... = Acknowledgement field significant
 TCP: ....0... = No Push function
 TCP: .....0.. = No Reset
 TCP: ......0. = No Synchronize
 TCP: .......0 = No Fin

TCP: Window = 28672 (0x7000)
 TCP: Checksum = 0xD5A3
 TCP: Urgent Pointer = 0 (0x0)
 TCP: Frame Padding

00000: 00 A0 C9 22 F5 39 08 00 02 03 BA 84 08 00 45 00 ...".9........E.
00010: 00 28 D2 82 00 00 3F 06 6B BD C0 5E DE 57 C0 5E .(....?.k..^.W.^
00020: DE 7B 05 48 09 21 CE 66 AE 02 0B 20 96 AD 50 10 .{.H.!.f... ..P.
00030: 70 00 D5 A3 00 00 90 00 01 00 86 00 p...........

```

Frame 6:

After receiving the FIN from the client computer, the server will ACK. Even though TCP has established connections between the two computers, the connections are still independent of one another. So the server must also transmit a FIN (`TCP .A...F`) to the client.

```console

6 17.0085 BDC3 --> NTW3 TCP .A...F, len: 0, seq: 1109646-1109646, ack:
8221824, win:28672, src: 139 dst: 2337 (NBT Session) BDC3 --> NTW3 IP

TCP: .A...F, len: 0, seq: 1109646-1109646, ack: 8221824, win:28672, src:
139 dst: 2337 (NBT Session)

TCP: Source Port = 0x0548
 TCP: Destination Port = 0x0921
 TCP: Sequence Number = 1109646 (0x10EE8E)
 TCP: Acknowledgement Number = 8221824 (0x7D7480)
 TCP: Data Offset = 20 (0x14)
 TCP: Reserved = 0 (0x0000)
 TCP: Flags = 0x11 : .A...F

TCP: ..0..... = No urgent data
 TCP: ...1.... = Acknowledgement field significant
 TCP: ....0... = No Push function
 TCP: .....0.. = No Reset
 TCP: ......0. = No Synchronize
 TCP: .......1 = No more data from sender

TCP: Window = 28672 (0x7000)
 TCP: Checksum = 0xD5A2
 TCP: Urgent Pointer = 0 (0x0)
 TCP: Frame Padding

00000: 00 A0 C9 22 F5 39 08 00 02 03 BA 84 08 00 45 00 ...".9........E.
00010: 00 28 D2 94 00 00 3F 06 6B AB C0 5E DE 57 C0 5E .(....?.k..^.W.^
00020: DE 7B 05 48 09 21 CE 66 AE 02 0B 20 96 AD 50 11 .{.H.!.f... ..P.
00030: 70 00 D5 A2 00 00 02 04 05 B4 86 00 p...........

```

Frame 7:

The client responds in the same format as the server, by ACKing the server's FIN and incrementing the sequence number by 1.

```console

7 17.0085 NTW3 --> BDC3 TCP .A...., len: 0, seq: 8221824-8221824, ack:
1109647, win: 8760, src: 2337 dst: 139 (NBT Session) NTW3 --> BDC3 IP

TCP: .A...., len: 0, seq: 8221824-8221824, ack: 1109647, win: 8760, src:
2337 dst: 139 (NBT Session)

TCP: Source Port = 0x0921
 TCP: Destination Port = 0x0548
 TCP: Sequence Number = 8221824 (0x7D7480)
 TCP: Acknowledgement Number = 1109647 (0x10EE8F)
 TCP: Data Offset = 20 (0x14)
 TCP: Reserved = 0 (0x0000)
 TCP: Flags = 0x10 : .A....

TCP: ..0..... = No urgent data
 TCP: ...1.... = Acknowledgement field significant
 TCP: ....0... = No Push function
 TCP: .....0.. = No Reset
 TCP: ......0. = No Synchronize
 TCP: .......0 = No Fin

TCP: Window = 8760 (0x2238)
 TCP: Checksum = 0x236B
 TCP: Urgent Pointer = 0 (0x0)

00000: 00 20 AF 47 93 58 00 A0 C9 22 F5 39 08 00 45 00 . .G.X...".9..E.
00010: 00 28 BA F5 40 00 80 06 02 4A C0 5E DE 7B C0 5E .(..@....J.^.{.^
00020: DE 57 09 21 05 48 0B 20 96 AD CE 66 AE 03 50 10 .W.!.H. ...f..P.
00030: 22 38 23 6B 00 00 "8#k..

```

The client ACKing the FIN notification from the server identifies a graceful close of a TCP connection.

## References

Obtain RFC 793.

RFCs may be obtained through the Internet as follows:

Paper copies of all RFCs are available from the NIC, either individually or on a subscription basis (for more information contact NIC@NIC.DDN.MIL). Online copies are available through FTP or Kermit from NIC.DDN.MIL as rfc/rfc####.txt or rfc/rfc####.PS (#### is the RFC number without leading zeros).
