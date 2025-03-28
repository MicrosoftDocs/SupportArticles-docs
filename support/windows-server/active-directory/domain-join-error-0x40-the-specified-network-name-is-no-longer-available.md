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
NetUseAdd to \\<dc_fqdn>\IPC$ returned 64
NetpJoinDomainOnDs: status of connecting to dc '\\<dc_fqdn>': 0x40
NetpJoinDomainOnDs: Function exits with status of: 0x40
NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on '<domain_name>' returned 0x0
NetpJoinDomainOnDs: NetpResetIDNEncoding on '<domain_name>': 0x0
NetpDoDomainJoin: status: 0x40
```

### Error detail

|Hexadecimal error|Decimal error|Symbolic error string|Friendly error|
|---|---|---|---|
|0x40|64|ERROR_NETNAME_DELETED|The specified network name is no longer available.|

## Cause

This error is logged when the client computer lacks network connectivity on Transmission Control Protocol (TCP) port 88 between the client and the domain controller (DC), which is used for the Key Distribution Center (KDC) request packet. For example, the error might be caused by some firewall device between the client and the DC.

## Troubleshoot

### Test the connection

To troubleshoot this issue, you can run the following command to test the connection:

```PowerShell
Test-NetConnection <IP_address_of_the_DC> -Port 88
```

Expected output:

```output
ComputerName           : <ip_address>
RemoteAddress          : <ip_address>
RemotePort             : 88
SourceAddress          : <ip_address>
PingSucceeded          : False
PingReplyDetails (RTT) : 0 ms
TcpTestSucceeded       : False
```

The output indicates that the Kerberos port TCP 88 isn't open between the client and the DC.

### Network trace

The issue is related to Server Message Block (SMB).

1. Use the `net use` command to access the same Universal Naming Convention (UNC) path and reproduce the issue.
2. Collect a network trace of the `net use` command execution.

#### Example

Here's an example of a network trace:

```output
CLIENT1    DC1.ADATUM.COM           TCP      TCP:Flags=......S., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=0, Seq=1299628969, Ack=0, Win=8192 (  ) = 8192           {TCP:267, IPv4:5}
DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A..S., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282675, Ack=1299628970, Win=8192 ( Scale factor not supported ) = 8192           {TCP:267, IPv4:5}
CLIENT1    DC1.ADATUM.COM           TCP      TCP:Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=0, Seq=1299628970, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
CLIENT1    DC1.ADATUM.COM           KerberosV5      KerberosV5:TGS Request Realm: ADATUM.COM Sname: cifs/DC1.ADATUM.COM {TCP:267, IPv4:5}
DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282676, Ack=1299628970, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
CLIENT1    DC1.ADATUM.COM           TCP      TCP:[ReTransmit #1539]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=1460, Seq=1299628970 - 1299630430, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
CLIENT1    DC1.ADATUM.COM           TCP      TCP:[ReTransmit #1539]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=1460, Seq=1299628970 - 1299630430, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
CLIENT1    DC1.ADATUM.COM           TCP      TCP:[ReTransmit #1539]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=536, Seq=1299628970 - 1299629506, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282676, Ack=1299629506, Win=63704 (scale factor 0x0) = 63704   {TCP:267, IPv4:5}
CLIENT1    DC1.ADATUM.COM           TCP      TCP:[Continuation to #0]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=536, Seq=1299629506 - 1299630042, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
CLIENT1    DC1.ADATUM.COM           TCP      TCP:[Continuation to #0]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=536, Seq=1299630042 - 1299630578, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282676, Ack=1299630042, Win=63168 (scale factor 0x0) = 63168   {TCP:267, IPv4:5}
CLIENT1    DC1.ADATUM.COM           TCP      TCP:[Continuation to #0]Flags=...AP..., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=536, Seq=1299630578 - 1299631114, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282676, Ack=1299630738, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
CLIENT1    DC1.ADATUM.COM           KerberosV5      KerberosV5:     {TCP:267, IPv4:5}
DC1.ADATUM.COM         CLIENT1            TCP      TCP:[Continuation to #0]Flags=...AP..., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=290, Seq=2785284136 - 2785284426, Ack=1299630738, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
CLIENT1    DC1.ADATUM.COM           TCP      TCP:Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=0, Seq=1299632186, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284426, Ack=1299631114, Win=63864 (scale factor 0x0) = 63864   {TCP:267, IPv4:5}
CLIENT1    DC1.ADATUM.COM           TCP      TCP:[Continuation to #1552]Flags=...AP..., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=320, Seq=1299632186 - 1299632506, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240     {TCP:267, IPv4:5}
DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284426, Ack=1299632186, Win=62792 (scale factor 0x0) = 62792   {TCP:267, IPv4:5}
DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284426, Ack=1299632506, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
CLIENT1    DC1.ADATUM.COM           TCP      TCP:Flags=...A...F, SrcPort=59259, DstPort=Kerberos(88), PayloadLen=0, Seq=1299632506, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284136, Ack=1299632507, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A.R.., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284136, Ack=1299632507, Win=0 (scale factor 0x0) = 0 
```

From the trace, you can find the DC doesn't respond to the Ticket Granting Service (TGS) request from the client for the Service Principal Name (SPN) `CIFS/DC1.ADATUM.COM`. It sends back a TCP acknowledgment, which suggests the DC received the TGS request. However, it doesn't reply with a valid TGS response. Finally, the client terminates the TCP connection.
