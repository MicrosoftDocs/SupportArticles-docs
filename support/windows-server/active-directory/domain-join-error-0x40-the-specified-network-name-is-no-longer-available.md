---
title: Error 0x40 The Specified Network Name Is No Longer Available
description: Addresses the error The specified network name is no longer available encountered during domain join operations.
ms.date: 03/28/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: raviks, eriw, dennhu
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Domain join error 0x40 "The specified network name is no longer available"

This article addresses the error code 0x40 encountered during domain join operations.

## Symptoms

When you try to join a computer to a domain, you receive the following error message:

> The specified network name is no longer available.

When you review the **netsetup.log** file, you find error messages that resemble the following entries:

```output
NetUseAdd to \\dc1.adatum.com\IPC$ returned 64
NetpJoinDomain: status of connecting to dc '\\dc1.adatum.com': 0x40
NetpJoinDomainOnDs: Function exits with status of: 0x40
```

### Error detail

|Hexadecimal error|Decimal error|Symbolic error string|Friendly error|
|---|---|---|---|
|0x40|64|ERROR_NETNAME_DELETED|The specified network name is no longer available.|

## Cause

This issue occurs when either of the following conditions is met:

- A WAN accelerator device responds to acknowledge the TGS request package, but the response does not arrives at the Key Distribution Center (KDC). Generally, IP Time to Live (TTL) frame fields have values of 64 or lower because this is the TTL used by Unix-like devices, and WAN accelerators are generally based on Linux.
- A network device such as a firewall between the client and the Domain Controller (DC) dropped the KDC response. You can find more details in the concurrent network trace of the DC traffic.

## Troubleshooting

The issue is related to getting Kerberos Tickets for a Server Message Block (SMB) session. Troubleshoot this issue based on the network trace:

1. Use the `net use` command to access the same Universal Naming Convention (UNC) path and reproduce the issue.
2. Collect a network trace of the `net use` command execution.

### Example

Here's an example of a network trace:

```output
1534 CLIENT1         DC1.ADATUM.COM  TCP        TCP:Flags=......S., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=0, Seq=1299628969, Ack=0, Win=8192 (  ) = 8192           {TCP:267, IPv4:5}
1537 DC1.ADATUM.COM         CLIENT1  TCP        TCP:Flags=...A..S., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282675, Ack=1299628970, Win=8192 ( Scale factor not supported ) = 8192           {TCP:267, IPv4:5}
1538 CLIENT1         DC1.ADATUM.COM  TCP        TCP:Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=0, Seq=1299628970, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1539 CLIENT1         DC1.ADATUM.COM  KerberosV5 KerberosV5:TGS Request Realm: ADATUM.COM Sname: cifs/DC1.ADATUM.COM {TCP:267, IPv4:5}
1540 DC1.ADATUM.COM         CLIENT1  TCP        TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282676, Ack=1299628970, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1541 CLIENT1         DC1.ADATUM.COM  TCP        TCP:[ReTransmit #1539]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=1460, Seq=1299628970 - 1299630430, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1542 CLIENT1         DC1.ADATUM.COM  TCP        TCP:[ReTransmit #1539]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=1460, Seq=1299628970 - 1299630430, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1545 CLIENT1         DC1.ADATUM.COM  TCP        TCP:[ReTransmit #1539]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=536, Seq=1299628970 - 1299629506, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1546 DC1.ADATUM.COM         CLIENT1  TCP        TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282676, Ack=1299629506, Win=63704 (scale factor 0x0) = 63704   {TCP:267, IPv4:5}
1547 CLIENT1         DC1.ADATUM.COM  TCP        TCP:[Continuation to #0]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=536, Seq=1299629506 - 1299630042, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1548 CLIENT1         DC1.ADATUM.COM  TCP        TCP:[Continuation to #0]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=536, Seq=1299630042 - 1299630578, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1549 DC1.ADATUM.COM         CLIENT1  TCP        TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282676, Ack=1299630042, Win=63168 (scale factor 0x0) = 63168   {TCP:267, IPv4:5}
1550 CLIENT1         DC1.ADATUM.COM  TCP        TCP:[Continuation to #0]Flags=...AP..., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=536, Seq=1299630578 - 1299631114, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1551 DC1.ADATUM.COM         CLIENT1  TCP        TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282676, Ack=1299630738, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1552 CLIENT1         DC1.ADATUM.COM  KerberosV5 KerberosV5:     {TCP:267, IPv4:5}
1553 DC1.ADATUM.COM         CLIENT1  TCP        TCP:[Continuation to #0]Flags=...AP..., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=290, Seq=2785284136 - 2785284426, Ack=1299630738, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1554 CLIENT1         DC1.ADATUM.COM  TCP        TCP:Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=0, Seq=1299632186, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1555 DC1.ADATUM.COM         CLIENT1  TCP        TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284426, Ack=1299631114, Win=63864 (scale factor 0x0) = 63864   {TCP:267, IPv4:5}
1556 CLIENT1         DC1.ADATUM.COM  TCP        TCP:[Continuation to #1552]Flags=...AP..., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=320, Seq=1299632186 - 1299632506, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240     {TCP:267, IPv4:5}
1557 DC1.ADATUM.COM         CLIENT1  TCP        TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284426, Ack=1299632186, Win=62792 (scale factor 0x0) = 62792   {TCP:267, IPv4:5}
1558 DC1.ADATUM.COM         CLIENT1  TCP        TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284426, Ack=1299632506, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1559 CLIENT1         DC1.ADATUM.COM  TCP        TCP:Flags=...A...F, SrcPort=59259, DstPort=Kerberos(88), PayloadLen=0, Seq=1299632506, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1563 DC1.ADATUM.COM         CLIENT1  TCP        TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284136, Ack=1299632507, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1564 DC1.ADATUM.COM         CLIENT1  TCP        TCP:Flags=...A.R.., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284136, Ack=1299632507, Win=0 (scale factor 0x0) = 0           {TCP:267, IPv4:5}
```

From the trace, you can find the DC doesn't respond to the Ticket Granting Service (TGS) request from the client for the Service Principal Name (SPN) `CIFS/DC1.ADATUM.COM`. It sends back a TCP acknowledgment, which suggests the DC received the TGS request. However, it doesn't reply with a valid TGS response. Finally, the client terminates the TCP connection.

#### Analysis of the network traffic

> [!NOTE]
> A full understanding of the behavior needs a trace from the DC network, it might also clarify why the client does not reset the session earlier. The following analysis is based on the failure in the trace.

In frames 1541, 1542, and 1545, the client first retransmits the TCP segment and then reduces the size of the frame. The data in frame 1545 is acknowledged in frame 1546.

The client continues to send data until the last segment in frame 1550, which includes the Push bit and ends with the last byte 1299631114. This segment is acknowledged by the server in frame 1555.

Meanwhile, the client sends another request to the server in frames 1552 and 1556, with the last byte 1299632506. This request is acknowledged by the server in frame 1558.

However, until the client decides to terminate the session, there is only a single message from the server (frame 1553). The sequence numbers that reach the client indicate that the server does send other data, as evidenced by the sequence numbers:

```output
2785282676 first in frame 1540
2785284426 first in frame 1555
2785284136 first in frame 1563
```

The last sequence number is lower than the one the server sends in frame 1555. The client never sees this data and thus acknowledge 2785282676 throughout the network trace. This discrepancy directly indicates issues with the correct flow of network traffic.
