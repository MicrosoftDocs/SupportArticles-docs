---
title: Status Code 0x3a
description: Provides troubleshooting steps for resolving the status code 0x3a when you join a workgroup computer to a domain.
ms.date: 04/17/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, raviks, herbertm, dennhu, eriw, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Status code 0x3a: The specified server cannot perform the requested operation

This article provides troubleshooting steps for resolving the status code 0x3a when you join a workgroup computer to a domain.

When you join a workgroup computer to a domain, you receive the following error message:

> The following error occurred when attempting to join the domain"\<DomainName\>":
>
> The specified server cannot perform the requested operation.

When you check the **NetSetup.log** file, you see the following entries. For example:

```output
NetpLdapBind: ldap_bind failed on <dc_fqdn>: 81: Server Down
NetpJoinCreatePackagePart: status:0x3a.
NetpJoinDomainOnDs: Function exits with status of: 0x3a
NetpJoinDomainOnDs: status of disconnecting from '\\<dc_fqdn>': 0x0
NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on '<domain_name>' returned 0x0
NetpJoinDomainOnDs: NetpResetIDNEncoding on '<domain_name>': 0x0
NetpDoDomainJoin: status: 0x3a
```

## The client computer lacks network connectivity on TCP 389 port

Status code 0x3a is logged when the client computer lacks network connectivity on Transmission Control Protocol (TCP) 389 port between the client computer and the domain controller (DC).

For example, incorrect maximum transmission unit (MTU) sizes on some network devices can lead to packet loss during the domain join process.

## Test and verify the connection

To troubleshoot this issue, use the following steps:

1. Run the following cmdlet to test the connection:

    ```powershell
    Test-NetConnection <IP_address_of_the_DC> -Port 389
    ```

    The expected output is:

    ```output
    ComputerName            : <ComputerName>
    RemoteAddress           : <RemoteAddress>
    RemotePort              : 389
    InterfaceAlias          : Ethernet 2
    SourceAddress           : <SourceAddress>
    TcpTestSucceeded        : True
    ```

    The output indicates that the Lightweight Directory Access Protocol (LDAP) port TCP 389 is open between the client and the DC.

2. Collect the network trace to verify the TCP 389 connection to the DC. For example, on the client machine, you might see TCP retransmissions which indicate there's no response received from DC's TCP 389 port.

    ```output
    CLIENT 	DC	TCP	TCP:Flags=CE....S., SrcPort=49300, DstPort=LDAP(389), PayloadLen=0, Seq=3537217409, Ack=0, Win=8192 ( Negotiating scale factor 0x8 ) = 8192 {TCP:58, IPv4:4}
    CLIENT 	DC	TCP	TCP:[SynReTransmit #177]Flags=CE....S., SrcPort=49300, DstPort=LDAP(389), PayloadLen=0, Seq=3537217409, Ack=0, Win=8192 ( Negotiating scale factor 0x8 ) = 8192	{TCP:58, IPv4:4}
    CLIENT 	DC	TCP	TCP:[SynReTransmit #177]Flags=......S., SrcPort=49300, DstPort=LDAP(389), PayloadLen=0, Seq=3537217409, Ack=0, Win=8192 ( Negotiating scale factor 0x8 ) = 8192	{TCP:58, IPv4:4}
    ```
