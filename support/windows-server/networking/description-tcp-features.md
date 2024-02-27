---
title: Description of Windows TCP features
description: Describes the TCP features in Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Description of Windows TCP features

This article describes the TCP features in Windows.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 224829

## Summary

This article describes the following TCP features in Windows:  

- TCP window size
- TCP options now supported
- Windows scaling - RFC 1323
- Timestamp - RFC 1323
- Protection against Wrapped Sequence Numbers (PAWS)
- Selective Acknowledgments (SACKS) - RFC 2018
- TCP retransmission behavior and fast retransmit

The TCP features can be changed by changing the entries in the registry.

> [!IMPORTANT]
> The following sections, methods, or tasks contain steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

## TCP window size

The TCP receive window size is the amount of receive data (in bytes) that can be buffered during a connection. The sending host can send only that amount of data before it must wait for an acknowledgment and window update from the receiving host. The Windows TCP/IP stack is designed to self-tune itself in most environments, and uses larger default window sizes than earlier versions.

Instead of using a hard-coded default receive window size, TCP adjusts to even increments of the maximum segment size (MSS). The MSS is negotiated during connection setup. Adjusting the receive window to even increments of the MSS increases the percentage of full-sized TCP segments used during bulk data transmissions.

The receive window size is determined in the following manner:  

1. The first connection request sent to a remote host advertises a receive window size of 16K (16,384 bytes).
2. When the connection is established, the receive window size is rounded up to an even increment of the MSS.
3. The window size is adjusted to four times the MSS, to a maximum size of 64 K, unless the window scaling option (RFC 1323) is used.

> [!NOTE]
> See the "Windows scaling" section.

For Ethernet connections, the window size will normally be set to 17,520 bytes (16K rounded up to twelve 1460-byte segments). The window size may reduce when a connection is established to a computer that supports extended TCP head options, such as Selective Acknowledgments (SACKS) and Timestamps. These two options increase the TCP header size to more than 20 bytes, which results in less room for data.

In previous versions of Windows NT, the window size for an Ethernet connection was 8,760 bytes, or six 1460-byte segments.

To set the receive window size to a specific value, add the TcpWindowSize value to the registry subkey specific to your version of Windows. To do so, follow these steps:  

1. Select **Start** > **Run**, type *`Regedit`*, and then select **OK**.
2. Expand the registry subkey specific to your version of Windows:
    - For Windows 2000, expand the following subkey:
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces`

    - For Windows Server 2003, expand the following subkey:
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`  

3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
4. Type *`TcpWindowSize`* in the **New Value** box, and then press Enter
5. Select **Modify** on the **Edit** menu.
6. Type the desired window size in the **Value data** box.

    > [!NOTE]
    > The valid range for window size is 0-0x3FFFC000 Hexadecimal.

This value isn't present by default. When you add the TcpWindowSize value, it overrides the default window size algorithm discussed above.

> [!NOTE]
> TcpWindowSize can also be added to the Parameters key to set the window size globally for all interfaces.

## TCP options now supported

Previously, TCP options were used primarily for negotiating maximum segment sizes. In Windows, TCP options are used for Window Scaling, Time Stamp, and Selective ACK.

There are two types of TCP options:

1. A single octet TCP option, which is used to indicate a specific option kind.
2. A multiple octet TCP option, which consists of an option kind, an option length and a series of option octets.

The following list shows each TCP option kind, length, name, and description.

Kind: 0  
Length: 1  
Option: End of Option List  
Description: Used when padding is needed for the last TCP option.  

Kind: 1  
Length: 1  
Option: No Operation  
Description: Used when padding is needed and more TCP options follow within the same packet.

Kind: 2  
Length: 4  
Option: Maximum Segment Size  
Description: Indicates the maximum size for a TCP segment that can be sent across the network.

Kind: 3  
Length: 3  
Option: Window Scale Option  
Description: Identifies the scaling factor to be used when using window sizes larger than 64k.

Kind: 8  
Length: 10  
Option: Time Stamp Option  
Description: Used to help calculate the Round Trip Time (RTT) of packets transmitted.

Kind: 4  
Length: 2  
Option: TCP SACK permitted  
Description: Informs other hosts that Selective Acks are permitted.

Kind: 5  
Length: Varies  
Option: TCP SACK Option  
Description: Used by hosts to identify whether out-of-order packets were received.

## Windows scaling

For more efficient use of high-bandwidth networks, a larger TCP window size may be used. The TCP window size field controls the flow of data and is limited to 2 bytes, or a window size of 65,535 bytes.

Since the size field can't be expanded, a scaling factor is used. TCP window scale is an option used to increase the maximum window size from 65,535 bytes to 1 Gigabyte.

The window scale option is used only during the TCP three-way handshake. The window scale value represents the number of bits to left-shift the 16-bit window size field. The window scale value can be set from 0 (no shift) to 14.

To calculate the true window size, multiply the window size by 2^S where S is the scale value.

For Example:

If the window size is 65,535 bytes with a window scale factor of 3.  
True window size = 65535*2^3

True window size = 524280  

The following Network Monitor trace shows how the window scale option is used:

```output
TCP: ....S., len:0, seq:725163-725163, ack:0, win:65535, src:1217 dst:139(NBT Session)  
TCP: Source Port = 0x04C1  
TCP: Destination Port = NETBIOS Session Service  
TCP: Sequence Number = 725163 (0xB10AB)  
TCP: Acknowledgement Number = 0 (0x0)  
TCP: Data Offset = 44 (0x2C)  
TCP: Reserved = 0 (0x0000)  
+ TCP: Flags = 0x02 : ....S.  
TCP: Window = 65535 (0xFFFF)  
TCP: Checksum = 0x8565  
TCP: Urgent Pointer = 0 (0x0)  
TCP: Options  
+ TCP: Maximum Segment Size Option  
TCP: Option Nop = 1 (0x1)  
TCP: Window Scale Option  
TCP: Option Type = Window Scale  
TCP: Option Length = 3 (0x3)  
TCP: Window Scale = 3 (0x3)  
TCP: Option Nop = 1 (0x1)  
TCP: Option Nop = 1 (0x1)  
+ TCP: Timestamps Option  
TCP: Option Nop = 1 (0x1)  
TCP: Option Nop = 1 (0x1)  
+ TCP: SACK Permitted Option  
```

The window size used in the actual three-way handshake isn't the window size that's scaled, per RFC 1323 section 2.2:

"The Window field in a SYN (for example, a [SYN] or [SYN,ACK]) segment itself is never scaled."

It means that the first data packet sent after the three-way handshake is the actual window size. If there's a scaling factor, the initial window size of 65,535 bytes is always used. The window size is then multiplied by the scaling factor identified in the three-way handshake. The table below represents the scaling factor boundaries for various window sizes.

|Scale Factor|Scale Value|Initial Window|Window Scaled|
|---|---|---|---|
|0|1|65535 or less|65535 or less|
|1|2|65535|131,070|
|2|4|65535|262,140|
|3|8|65535|524,280|
|4|16|65535|1,048,560|
|5|32|65535|2,097,120|
|6|64|65535|4,194,240|
|7|128|65535|8,388,480|
|8|256|65535|16,776,960|
|9|512|65535|33,553,920|
|10|1024|65535|67,107,840|
|11|2048|65535|134,215,680|
|12|4096|65535|268,431,360|
|13|8192|65535|536,862,720|
|14|16384|65535|1,073,725,440|
  
For example:

If the window size in the registry is entered as 269000000 (269M) in decimal, the scaling factor during the three-way handshake is 13. A scaling factor of 12 only allows a window size up to 268,431,360 bytes (268M).

The initial window size in this example would be calculated as follows:  
65,535 bytes with a window scale factor of 13.  
True window size = 65535*2^13  
True window size = 536,862,720  

When the value for window size is added to the registry, and its size is larger than the default value, Windows attempts to use a scale value that accommodates the new window size.

The Tcp1323Opts value in the following registry key can be added to control scaling windows and timestamp:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters`

1. On the toolbar, select **Start** > **Run**, and then type *`Regedit`* to start the Registry Editor.
2. In the Registry Editor, select **Edit**, point to **New**, and then select **DWORD Value**.
3. In the New Value box, type *`Tcp1323Opts`*, press ENTER, and then on the **Edit** menu, select **Modify**.  

    > [!NOTE]
    > The valid range is 0, 1, 2 or 3 where:  
    0 (disable RFC 1323 options)  
    1 (window scale enabled only)  
    2 (timestamps enabled only)  
    3 (both options enabled)  

This registry entry controls RFC 1323 timestamps and window scaling options. Timestamps and Window scaling are enabled by default, but can be manipulated with flag bits. Bit **0** controls window scaling. Bit **1** controls timestamps.

## Timestamps

Previously, the TCP/IP stack used one sample per window of data sent to calculate the round-trip time (RTT). A timer (retransmit timer) was set when the packet was sent, until the acknowledgment was received. For example, if the window size was 64,240 bytes (44 full segments) on an Ethernet network, only one of every 44 packets were used to recalculate the round-trip time. With a maximum window size of 65,535 bytes, this sampling rate was sufficient. Using window scaling, and a maximum window size of 1 Gigabyte, this RTT sampling rate isn't sufficient.

The TCP Timestamp option can now be used on segments (data and ACK) considered appropriate by the stack, to do operations such as:

- RTT computation
- PAWS check

Using this data, the RTT can be accurately calculated with large window sizes. RTT is used to calculate retransmission intervals. Accurate RTT and retransmission time-outs are needed for optimum throughput.

When TCP time stamp is used in a TCP session, the originator of the session sends the option in its first packet of the TCP three-way handshake (SYN packet). Either side can then use the TCP option during the session.

TCP Timestamps Option (TSopt):

|Kind = 8|Length = 10|TS Value (Tsval)|TS Echo Reply (Tsecr)|
|---|---|---|---|
|1 byte|1 byte|4 bytes|4 bytes|
  
The timestamp option field can be viewed in a Network Monitor trace by expanding the TCP options field, as shown below:  

```output
TCP: Timestamps Option  
TCP: Option Type = Timestamps  
TCP: Option Length = 10 (0xA)  
TCP: Timestamp = 2525186 (0x268802)  
TCP: Reply Timestamp = 1823192 (0x1BD1D8)
```

## Protection against Wrapped Sequence Numbers (PAWS)

The TCP sequence number field is limited to 32 bits, which limits the number of sequence numbers available. With high capacity networks and a large data transfer, it's possible to wrap sequence numbers before a packet traverses the network. If sending data on a one Giga-byte per second (Gbps) network, the sequence numbers could wrap in as little as 34 seconds. If a packet is delayed, a different packet could potentially exist with the same sequence number. To avoid confusion of duplicate sequence numbers, the TCP timestamp is used as an extension to the sequence number. Packets have current and progressing time stamps. An old packet has an older time stamp and is discarded.

## Selective Acknowledgments (SACKs)

Windows introduces support for a performance feature known as Selective Acknowledgment, or SACK. SACK is especially important for connections that use large TCP window sizes. Before SACK, a receiver could only acknowledge the latest sequence number of a contiguous data stream that had been received, or the "left edge" of the receive window. With SACK enabled, the receiver continues to use the ACK number to acknowledge the left edge of the receive window, but it can also acknowledge other blocks of received data individually. SACK uses TCP header options, as shown below.

SACK uses two types of TCP Options.

The TCP Sack-Permitted Option is used only in a SYN packet (during the TCP connection establishment) to indicate that it can do selective ACK.

The second TCP option, TCP Sack Option, contains acknowledgment for one or more blocks of data. The data blocks are identified using the sequence number at the start and at the end of that block of data. It's also known as the left and right edge of the block of data.

Kind 4 is TCP Sack-Permitted Option. Kind 5 is TCP Sack Option. Length is the length in bytes of this TCP option.

Tcp SACK Permitted:

|Kind = 4|Length = 2|
|---|---|
|1 byte|1 byte|
  
Tcp SACK Option:

|Kind = 5|Length = Variable|
|---|---|
|1 byte|Left edge of first block to Right edge of first block<br/>...<br/>Left edge of Nth block to Right edge of Nth block|
  
With SACK enabled (default), a packet or series of packets can be dropped. The receiver informs the sender which data has been received, and where there may be "holes" in the data. The sender can then selectively retransmit the missing data without a retransmission of blocks of data that have already been received successfully. SACK is controlled by the SackOpts registry parameter.

The SackOpts value in the following registry key can be edited to control the use of selective acknowledgments:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`

1. On the toolbar, select **Start** > **Run**, and then type *`Regedit`* to start the Registry Editor.
2. Locate and select the above key in the Registry Editor, and then select **Modify** on the **Edit** menu.
3. Type the desired value in the **Value data** box.  

> [!NOTE]
> The valid binary value is 0 or 1, the default value is 1. This parameter controls whether or not Selective ACK (SACK - RFC 2018) support is enabled.

The following Network Monitor trace illustrates a host acknowledging all data up to sequence number 54857341, plus the data from sequence number 54858789-54861685. The missing data is from 54857341 to 54858788.

```output
TCP: .A...., len:0, seq:925104-925104, ack:54857341, win:32722, src:1242 dst:139  
TCP: Source Port = 0x04DA  
TCP: Destination Port = NETBIOS Session Service  
TCP: Sequence Number = 925104 (0xE1DB0)  
TCP: Acknowledgement Number = 54857341 (0x3450E7D)  
TCP: Data Offset = 44 (0x2C)  
TCP: Reserved = 0 (0x0000)  
+ TCP: Flags = 0x10 : .A....  
TCP: Window = 32722 (0x7FD2)  
TCP: Checksum = 0x4A72  
TCP: Urgent Pointer = 0 (0x0)  
TCP: Options  
TCP: Option Nop = 1 (0x1)  
TCP: Option Nop = 1 (0x1)  
+ TCP: Timestamps Option  
TCP: Option Nop = 1 (0x1)  
TCP: Option Nop = 1 (0x1)  
TCP: SACK Option  
TCP: Option Type = 0x05  
TCP: Option Length = 10 (0xA)  
TCP: Left Edge of Block = 54858789 (0x3451425)  
TCP: Right Edge of Block = 54861685 (0x3451F75)
```

## TCP retransmission behavior and fast retransmit

### TCP retransmission

As a review of normal retransmission behavior, TCP starts a retransmission timer when each outbound segment is handed down to the Internet Protocol (IP). If no acknowledgment has been received for the data in a given segment before the timer expires, then the segment is retransmitted.

The retransmission timeout (RTO) is adjusted continuously to match the characteristics of the connection using Smoothed Round Trip Time (SRTT) calculations as described in RFC 793. The timer for a given segment is doubled after each retransmission of that segment. Using this algorithm, TCP tunes itself to the normal delay of a connection.

### Fast retransmit

TCP retransmits data before the retransmission timer expires under some circumstances. The most common cause is a feature known as fast retransmit. When a receiver that supports fast retransmit receives data with a sequence number beyond the current expected one, some data was likely dropped. To help inform the sender of this event, the receiver immediately sends an ACK, with the ACK number set to the sequence number that it was expecting. It will continue to do so for each additional TCP segment that arrives. When the sender starts to receive a stream of ACKs that's acknowledging the same sequence number, a segment may have been dropped. The sender will immediately resend the segment that the receiver is expecting, without waiting for the retransmission timer to expire. This optimization greatly improves performance when packets are frequently dropped.

By default, Windows resends a segment under the following conditions:

- It receives three ACKs for the same sequence number: one ACK and two duplicates.
- The sequence number lags the current one.

This behavior is controllable with the `TcpMaxDupAcks` registry parameter.

The TcpMaxDupAcks value in the following registry key can be edited to control the number of ACKs necessary to start a fast retransmits:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`

1. On the toolbar, select **Start** > **Run**, and then type *`Regedit`* to start the Registry Editor.
2. Locate and select the above key in the Registry Editor, and then select **Modify** on the **Edit** menu.
3. Type the desired value in the **Value data** box.  

> [!NOTE]
> The valid range is 1-3, the default value is 2.

This parameter determines the number of duplicate ACKs that must be received for the same sequence number of sent data before `fast retransmit` is triggered to resend the segment that has been dropped in transit.
