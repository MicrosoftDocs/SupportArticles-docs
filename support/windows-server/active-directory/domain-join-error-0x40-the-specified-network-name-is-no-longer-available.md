---
title: Domain join error 0x40 "The specified network name is no longer available"
description: Addresses the error "The specified network name is no longer available" encountered during domain join operations.
ms.date: 03/26/2025
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

The following error messages occur when you try to join the computer to the domain:

> The specified network name is no longer available

You review the *netsetup.log* log and found error messages that resemble the following:

```output
NetUseAdd to \\<dc_fqdn>\IPC$ returned 64
NetpJoinDomainOnDs: status of connecting to dc '\\<dc_fqdn>': 0x40
NetpJoinDomainOnDs: Function exits with status of: 0x40
NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on '<domain_name>' returned 0x0
NetpJoinDomainOnDs: NetpResetIDNEncoding on '<domain_name>': 0x0
NetpDoDomainJoin: status: 0x40
```

### Error detail

|HEX error|Decimal error|Symbolic Error String|Friendly Error|
|---|---|---|---|
|0x40|64|ERROR_NETNAME_DELETED|The specified network name is no longer available.|

## Cause

This error is logged when the client computer lacks network connectivity on TCP port 88 between the client and the Domain Controller (DC), which is used for Key Distribution Center (KDC) request packet. For example, the error could be caused if some firewall device between the client and the DC.

## Troubleshoot

### Test the connection

To troubleshoot this issue, you can run the following command to test the connection:

```PowerShell
Test-NetConnection <IP_address_of_the_DC> -Port 88
```

Expected Output:

```output
ComputerName           : <ip_address>
RemoteAddress          : <ip_address>
RemotePort             : 88
SourceAddress          : <ip_address>
PingSucceeded          : False
PingReplyDetails (RTT) : 0 ms
TcpTestSucceeded       : False
```

The output indicates that the Kerberos Port TCP 88 is open between the client and the DC.

### Network trace

The issue is related to Server Message Block (SMB).

1. Use the `net use` command to access the same Universal Naming Convention (UNC) path and reproduce the issue.
2. Collect a network trace of the "net use" command execution.

#### Example

The following is an example of a network trace:

```output
Source             Destination       Protocol Info
CLIENT1            DC1.ADATUM.COM    TCP        59259 → 88 [SYN] Seq=1299628969 Win=8192 Len=0
DC1.ADATUM.COM     CLIENT1           TCP        88 → 59259 [SYN, ACK] Seq=2785282675 Ack=1299628970 Win=8192 Len=0
CLIENT1            DC1.ADATUM.COM    TCP        59259 → 88 [ACK] Seq=1299628970 Ack=2785282676 Win=64240 Len=0
CLIENT1            DC1.ADATUM.COM    Kerberos   TGS-REQ Realm: ADATUM.COM Sname: cifs/DC1.ADATUM.COM
DC1.ADATUM.COM     CLIENT1           TCP        88 → 59259 [ACK] Seq=2785282676 Ack=1299628970 Win=64240 Len=0
CLIENT1            DC1.ADATUM.COM    TCP        [ReTransmit] 59259 → 88 [ACK] Seq=1299628970 Ack=2785282676 Win=64240 Len=1460
CLIENT1            DC1.ADATUM.COM    TCP        [ReTransmit] 59259 → 88 [ACK] Seq=1299628970 Ack=2785282676 Win=64240 Len=1460
CLIENT1            DC1.ADATUM.COM    TCP        [ReTransmit] 59259 → 88 [ACK] Seq=1299628970 Ack=2785282676 Win=64240 Len=536
DC1.ADATUM.COM     CLIENT1           TCP        88 → 59259 [ACK] Seq=2785282676 Ack=1299629506 Win=63704 Len=0
CLIENT1            DC1.ADATUM.COM    TCP        [Continuation] 59259 → 88 [ACK] Seq=1299629506 Ack=2785282676 Win=64240 Len=536
CLIENT1            DC1.ADATUM.COM    TCP        [Continuation] 59259 → 88 [ACK] Seq=1299630042 Ack=2785282676 Win=64240 Len=536
DC1.ADATUM.COM     CLIENT1           TCP        88 → 59259 [ACK] Seq=2785282676 Ack=1299630042 Win=63168 Len=0
CLIENT1            DC1.ADATUM.COM    TCP        [Continuation] 59259 → 88 [PSH, ACK] Seq=1299630578 Ack=2785282676 Win=64240 Len=536
DC1.ADATUM.COM     CLIENT1           TCP        88 → 59259 [ACK] Seq=2785282676 Ack=1299630738 Win=64240 Len=0
CLIENT1            DC1.ADATUM.COM    Kerberos   KerberosV5 Message 
DC1.ADATUM.COM     CLIENT1           TCP        [Continuation] 88 → 59259 [PSH, ACK] Seq=2785284136 Ack=1299630738 Win=64240 Len=290
CLIENT1            DC1.ADATUM.COM    TCP        59259 → 88 [ACK] Seq=1299632186 Ack=2785282676 Win=64240 Len=0
DC1.ADATUM.COM     CLIENT1           TCP        88 → 59259 [ACK] Seq=2785284426 Ack=1299631114 Win=63864 Len=0
CLIENT1            DC1.ADATUM.COM    TCP        [Continuation] 59259 → 88 [PSH, ACK] Seq=1299632186 Ack=2785282676 Win=64240 Len=320
DC1.ADATUM.COM     CLIENT1           TCP        88 → 59259 [ACK] Seq=2785284426 Ack=1299632186 Win=62792 Len=0
DC1.ADATUM.COM     CLIENT1           TCP        88 → 59259 [ACK] Seq=2785284426 Ack=1299632506 Win=64240 Len=0
CLIENT1            DC1.ADATUM.COM    TCP        59259 → 88 [FIN, ACK] Seq=1299632506 Ack=2785282676 Win=64240 Len=0
DC1.ADATUM.COM     CLIENT1           TCP        88 → 59259 [ACK] Seq=2785284136 Ack=1299632507 Win=64240 Len=0
DC1.ADATUM.COM     CLIENT1           TCP        88 → 59259 [RST, ACK] Seq=2785284136 Ack=1299632507 Win=0 Len=0
```

From the trace, we can find the Domain Controller (DC) doesn't respond to the Ticket Granting Service (TGS) request from the client for the Service Principal Name (SPN) CIFS/DC1.ADATUM.COM. It sends back a Transmission Control Protocol (TCP) acknowledgment, which suggests the DC received the TGS request. However, it doesn't reply with a valid TGS Response. Finally, the client terminates the TCP connection.
