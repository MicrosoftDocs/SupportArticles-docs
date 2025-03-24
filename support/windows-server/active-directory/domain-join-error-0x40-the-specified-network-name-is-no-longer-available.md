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

:::image type="content" source="media/domain-join-error-0x40-the-specified-network-name-is-no-longer-available/domain-join-error-message.png" alt-text="Screenshot of the dialog box showing the error message for error code 0x40.":::

You review the *netsetup.log* log and found error messages that resemble the following:

```output
mm/dd/yyyy hh:mm:ss:ms NetUseAdd to \\<dc_fqdn>\IPC$ returned 64
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: status of connecting to dc '\\<dc_fqdn>': 0x40
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: Function exits with status of: 0x40
mm/dd/yyyy hh:mm:ss:ms NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on '<domain_name>' returned 0x0
mm/dd/yyyy hh:mm:ss:ms NetpJoinDomainOnDs: NetpResetIDNEncoding on '<domain_name>': 0x0
mm/dd/yyyy hh:mm:ss:ms NetpDoDomainJoin: status: 0x40
```

### Error detail

|HEX error|Decimal error|Symbolic Error String|Friendly Error|
|---|---|---|---|
|0x40|64|ERROR_NETNAME_DELETED|The specified network name is no longer available.|

## Cause

This error is logged when the client computer lacks network connectivity on TCP port 88 between the client and the DC, which is used for Key Distribution Center (KDC) request packet. For example, the error could be caused if some firewall device between the client and the DC.

## Troubleshoot

### Test the connection

To troubleshoot this issue, you can run the following command to test the connection:

```PowerShell
Test-NetConnection <IP_address_of_the_DC> -Port 88
```

Expected Output:

:::image type="content" source="media/domain-join-error-0x40-the-specified-network-name-is-no-longer-available/test-netconnection-output-88.png" alt-text="Screenshot that shows the Test-NetConnection command for TCP port 88 output.":::

The output indicates that the Kerberos Port TCP 88 is open between the client and the DC.

### Network trace

The issue is related to Server Message Block (SMB).

1. Use the `net use` command to access the same Universal Naming Convention (UNC) path and reproduce the issue.
2. Collect a network trace of the "net use" command execution.

```output
1534   hh:mm:ss mm/dd/yyyy         105.5039440  0.0000000      lsass.exe          CLIENT1    DC1.ADATUM.COM           TCP      TCP:Flags=......S., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=0, Seq=1299628969, Ack=0, Win=8192 (  ) = 8192           {TCP:267, IPv4:5}
1537   hh:mm:ss mm/dd/yyyy         105.9602003  0.4562563      lsass.exe          DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A..S., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282675, Ack=1299628970, Win=8192 ( Scale factor not supported ) = 8192           {TCP:267, IPv4:5}
1538   hh:mm:ss mm/dd/yyyy         105.9602435  0.0000432      lsass.exe          CLIENT1    DC1.ADATUM.COM           TCP      TCP:Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=0, Seq=1299628970, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1539   hh:mm:ss mm/dd/yyyy         105.9602944  0.0000509      lsass.exe          CLIENT1    DC1.ADATUM.COM           KerberosV5      KerberosV5:TGS Request Realm: ADATUM.COM Sname: cifs/DC1.ADATUM.COM {TCP:267, IPv4:5}
1540   hh:mm:ss mm/dd/yyyy         106.4165365  0.4562421      lsass.exe          DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282676, Ack=1299628970, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1541   hh:mm:ss mm/dd/yyyy         107.3125167  0.8959802      lsass.exe          CLIENT1    DC1.ADATUM.COM           TCP      TCP:[ReTransmit #1539]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=1460, Seq=1299628970 - 1299630430, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1542   hh:mm:ss mm/dd/yyyy         110.0116060  2.6990893      lsass.exe          CLIENT1    DC1.ADATUM.COM           TCP      TCP:[ReTransmit #1539]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=1460, Seq=1299628970 - 1299630430, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1545   hh:mm:ss mm/dd/yyyy         115.4248882  5.4132822      lsass.exe          CLIENT1    DC1.ADATUM.COM           TCP      TCP:[ReTransmit #1539]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=536, Seq=1299628970 - 1299629506, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1546   hh:mm:ss mm/dd/yyyy         115.8823956  0.4575074      lsass.exe          DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282676, Ack=1299629506, Win=63704 (scale factor 0x0) = 63704   {TCP:267, IPv4:5}
1547   hh:mm:ss mm/dd/yyyy         115.8824392  0.0000436      lsass.exe          CLIENT1    DC1.ADATUM.COM           TCP      TCP:[Continuation to #0]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=536, Seq=1299629506 - 1299630042, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1548   hh:mm:ss mm/dd/yyyy         115.8824392  0.0000000      lsass.exe          CLIENT1    DC1.ADATUM.COM           TCP      TCP:[Continuation to #0]Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=536, Seq=1299630042 - 1299630578, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1549   hh:mm:ss mm/dd/yyyy         116.3402661  0.4578269      lsass.exe          DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282676, Ack=1299630042, Win=63168 (scale factor 0x0) = 63168   {TCP:267, IPv4:5}
1550   hh:mm:ss mm/dd/yyyy         116.3402990  0.0000329      lsass.exe          CLIENT1    DC1.ADATUM.COM           TCP      TCP:[Continuation to #0]Flags=...AP..., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=536, Seq=1299630578 - 1299631114, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1551   hh:mm:ss mm/dd/yyyy         116.3404218  0.0001228      lsass.exe          DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785282676, Ack=1299630738, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1552   hh:mm:ss mm/dd/yyyy         116.3404573  0.0000355      lsass.exe          CLIENT1    DC1.ADATUM.COM           KerberosV5      KerberosV5:     {TCP:267, IPv4:5}
1553   hh:mm:ss mm/dd/yyyy         116.3423782  0.0019209      lsass.exe          DC1.ADATUM.COM         CLIENT1            TCP      TCP:[Continuation to #0]Flags=...AP..., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=290, Seq=2785284136 - 2785284426, Ack=1299630738, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1554   hh:mm:ss mm/dd/yyyy         116.3424124  0.0000342      lsass.exe          CLIENT1    DC1.ADATUM.COM           TCP      TCP:Flags=...A...., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=0, Seq=1299632186, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1555   hh:mm:ss mm/dd/yyyy         116.7977071  0.4552947      lsass.exe          DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284426, Ack=1299631114, Win=63864 (scale factor 0x0) = 63864   {TCP:267, IPv4:5}
1556   hh:mm:ss mm/dd/yyyy         116.7977456  0.0000385      lsass.exe          CLIENT1    DC1.ADATUM.COM           TCP      TCP:[Continuation to #1552]Flags=...AP..., SrcPort=59259, DstPort=Kerberos(88), PayloadLen=320, Seq=1299632186 - 1299632506, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240     {TCP:267, IPv4:5}
1557   hh:mm:ss mm/dd/yyyy         116.7984454  0.0006998      lsass.exe          DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284426, Ack=1299632186, Win=62792 (scale factor 0x0) = 62792   {TCP:267, IPv4:5}
1558   hh:mm:ss mm/dd/yyyy         117.4632982  0.6648528      lsass.exe          DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284426, Ack=1299632506, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1559   hh:mm:ss mm/dd/yyyy         125.9861065  8.5228083      lsass.exe          CLIENT1    DC1.ADATUM.COM           TCP      TCP:Flags=...A...F, SrcPort=59259, DstPort=Kerberos(88), PayloadLen=0, Seq=1299632506, Ack=2785282676, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1563   hh:mm:ss mm/dd/yyyy         126.4418165  0.4557100      lsass.exe          DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A...., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284136, Ack=1299632507, Win=64240 (scale factor 0x0) = 64240   {TCP:267, IPv4:5}
1564   hh:mm:ss mm/dd/yyyy         126.4420244  0.0002079      lsass.exe          DC1.ADATUM.COM         CLIENT1            TCP      TCP:Flags=...A.R.., SrcPort=Kerberos(88), DstPort=59259, PayloadLen=0, Seq=2785284136, Ack=1299632507, Win=0 (scale factor 0x0) = 0 
```

From the trace, we can find the Domain Controller (DC) does not respond to the Ticket Granting Service (TGS) request from the client for the Service Principal Name (SPN) CIFS/DC1.ADATUM.COM. It sends back a Transmission Control Protocol (TCP) acknowledgment, which suggests the DC has received the TGS request. However, it does not reply with a valid TGS Response. Finally, the client terminates the TCP connection.
