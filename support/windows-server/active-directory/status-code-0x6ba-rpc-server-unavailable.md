---
title: Status Code 0x6ba And The RPC Server Is Unavailable
description: Provides troubleshooting steps for resolving the remote procedure call (RPC) status code 0x6ba when you join a workgroup computer to a domain.
ms.date: 04/18/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, raviks, herbertm, dennhu, eriw, v-lianna
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Status code 0x6ba: The RPC server is unavailable

This article provides troubleshooting steps for resolving the remote procedure call (RPC) status code 0x6ba when you join a workgroup computer to a domain.

When you join a workgroup computer to a domain, you receive the following error message:

> Changing the Primary Domain DNS name of this computer to "" failed. The name will remain "\<DomainName\>".
> The error was:
> The RPC service is unavailable.

Here's more information about the error code:

|Hexadecimal error |Decimal error  |Symbolic error string  |Error description  |
|---------|---------|---------|---------|
|0x6ba     |1722         |RPC_S_SERVER_UNAVAILABLE         |The RPC server is unavailable.         |

When you check the **NetSetup.log** file, you see the following entries. For example: 

```output
NetpGetComputerObjectDn: Unable to bind to DS on '\\DCNAME': 0x6ba
NetpCreateComputerObjectInDs: NetpGetComputerObjectDn failed: 0x6ba
NetpProvisionComputerAccount: LDAP creation failed: 0x6ba
ldap_unbind status: 0x0
NetpJoinCreatePackagePart: status:0x6ba.
NetpJoinDomainOnDs: Function exits with status of: 0x6ba
NetpJoinDomainOnDs: status of disconnecting from '\\DCNAME': 0x0
NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on 'DOMAINNAME' returned 0x0
NetpJoinDomainOnDs: NetpResetIDNEncoding on 'DOMAINNAME': 0x0
NetpDoDomainJoin: status: 0x6ba
``` 

## Troubleshoot the connection issue

To troubleshoot this issue, use the following steps:

1. Check the **NetSetup.log** file (**C:\\Windows\\Debug\\NetSetup.log**) on the client machine, and confirm if the domain controller (DC) locator process has successfully located a DC. However, the client machine fails to bind to the DC with status code 0x6ba. For example:

    ```output
    NetpJoinDomainOnDs: status of connecting to dc '\\DCNAME': 0x0
    NetpGetComputerObjectDn: Unable to bind to DS on '\\DCNAME': 0x6ba
    ```

2. Make sure the network ports aren't blocked by a firewall or third-party application which is listening on the required ports of the DC (identified in step 1).

    The endpoint mapper (listening on port 135) tells the client which randomly assigned port a service is listening on. Check the following ports:

    |Server port  |Service/Protocol  |
    |---------|---------|
    |Transmission Control Protocol (TCP) 135     |RPC Endpoint Mapper         |
    |TCP 49152 - 65535     |RPC (dynamic ports allocation)         |
    |TCP 445     |Server Message Block (SMB)         |
    |User Datagram Protocol (UDP)/TCP 389     |Lightweight Directory Access Protocol (LDAP)         |

    Refer to the list of required ports in [How to configure a firewall for Active Directory domains and trusts](config-firewall-for-ad-domains-and-trusts.md).

3. Identify if a port is blocked on a DC by using the [PortQry](https://www.microsoft.com/download/details.aspx?id=17148) command-line tool. For more information, see [Using the PortQry command-line tool](../networking/portqry-command-line-port-scanner-v2.md).

    Here are some example syntaxes:

    > [!NOTE]
    > Replace \<problem_server\> with the DC name identified in step 1.

    - `portqry -n <problem_server> -e 135`
    - `portqry -n <problem_server> -e 445`
    - `portqry -n <problem_server> -e 389`
    - `portqry -n <problem_server> -p UDP -e 389`
    - `portqry -n <problem_server> -r 49152:65535`

    Here are some example outputs:

    If the connection to TCP 135 port on the DC is blocked, you see the following output:

    ```output
    C:\PortQryV2>portqry -n dc2 -e 135
    Querying target system called:
    Dc2
    Attempting to resolve name to IP address…
    Name resolved to 192.168.1.2
    querying...
    TCP port 135 <epmap service>: FILTERED
    ```
    If the connection to TCP 389 port on the DC is successful, you see the following output:

    ```output
    C:\PortQryV2>portqry -n dc2 -e 389
    Querying target system called:
    Dc2
    Attempting to resolve name to IP address…
    Name resolved to 192.168.1.2
    querying...
    TCP port 389 <ldap service>: LISTENING
    ```

4. Collect [network monitor](https://www.microsoft.com/download/details.aspx?id=4865) trace when reproducing the issue to double check the network connectivity.

    For example, the following network trace collected by the PortQry command-line tool might indicate there's a network connectivity issue from the client machine to the DC's TCP 135 port (RPC).

    ```output
    PortQry.exe	CLIENT	DC	TCP	TCP:Flags=CE....S., SrcPort=51542, DstPort=DCE endpoint resolution(135), PayloadLen=0, Seq=4232829278, Ack=0, Win=8192 ( Negotiating scale factor 0x8 ) = 8192	{TCP:16, IPv4:15}
    PortQry.exe	CLIENT	DC	TCP	TCP:[SynReTransmit #50]Flags=CE....S., SrcPort=51542, DstPort=DCE endpoint resolution(135), PayloadLen=0, Seq=4232829278, Ack=0, Win=8192 ( Negotiating scale factor 0x8 ) = 8192	{TCP:16, IPv4:15}
    PortQry.exe	CLIENT	DC	TCP	TCP:[SynReTransmit #50]Flags=......S., SrcPort=51542, DstPort=DCE endpoint resolution(135), PayloadLen=0, Seq=4232829278, Ack=0, Win=8192 ( Negotiating scale factor 0x8 ) = 8192	{TCP:16, IPv4:15}
    In the network trace collected on the client side, you see the retransmit package of TCP SYN to DC's TCP 135 port. And no response is received from DC.
    In the network trace collected on the DC side, you might not see the TCP SYN package from the client. It might be blocked by a firewall or middle device.
    ```

5. Check the network device and firewall between the client and the DC to further investigate the network connectivity issue if necessary.

## More information

- [How to configure a firewall for Active Directory domains and trusts](config-firewall-for-ad-domains-and-trusts.md)
- [Locating Active Directory domain controllers in Windows and Windows Server](/windows-server/identity/ad-ds/manage/dc-locator?tabs=dns-based-discovery)
- [Troubleshoot domain controller location issues in Windows](../windows-security/troubleshoot-domain-controller-location-issues.md)
