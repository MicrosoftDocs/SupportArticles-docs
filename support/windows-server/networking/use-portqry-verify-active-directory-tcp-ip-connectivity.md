---
title: How to use PortQry to troubleshoot Active Directory connectivity issues
description: Describes how to use the PortQry command-line utility to troubleshoot TCP/IP connectivity used by Windows components and features.
ms.date: 11/09/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# How to use PortQry to troubleshoot Active Directory connectivity issues

This article describes how to run PortQry to test network connectivity for any Windows component or scenario on any version of Windows.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 816103

## Introduction  

PortQry is a command-line utility that you can use to troubleshoot TCP/IP connectivity used by Windows components and features. The utility reports the port status of Transition Control Protocol (TCP) and User Datagram Protocol (UDP) ports on a remote computer. You can run PortQry to test network connectivity for any Windows component or scenario on any version of Windows.

This article describes how to use portqry to verify basic TCP/IP connectivity for Active Directory and Active Directory related components including:

- Active Directory Domain Services (ADDS)
- Active Directory for Lightweight Directory Access Protocol (LDAP)
- Remote procedure call (RPC)
- Domain Name Service (DNS)
- Other ADDS-related components
- Other components on which ADDS is dependent

Verifying network connectivity over the required ports and protocols is especially useful when domain controllers are deployed across intermediate devices including firewalls.

## Install PortQry

### Download Portqry.exe

PortQry .exe is available for download from the Microsoft Download Center. To download the PortQry .exe, visit the following Microsoft Web site:

[Download PortQry Command Line Port Scanner Version 2.0](https://www.microsoft.com/download/details.aspx?id=17148)

For more information about how to download Microsoft Support files, see following the Microsoft Knowledge Base:

[119591](https://support.microsoft.com/help/119591) How to Obtain Microsoft Support Files from Online Services  

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help to prevent any unauthorized changes to the file.

A graphical version of the PortQry tool, called PortQueryUI, contains additional features that can make using PortQry easier to use. To download the PortQueryUI tool, visit the following Microsoft Web site:

[Download PortQryUI - User Interface for the PortQry Command Line Port Scanner](https://www.microsoft.com/download/details.aspx?id=24009)

## More information

PortQry reports the status of a port in one of three ways:

- Listening: A process is listening on the target port on the target system. PortQry received a response from the port.
- Not Listening: No process is listening on the target port on the target system. PortQry received an Internet Control Message Protocol (ICMP)"Destination Unreachable - Port Unreachable" message back from the target UDP port. Or, if the target port is a TCP port, Portqry received a TCP acknowledgment packet with the Reset flag set.
- Filtered: The target port on the target system is being filtered. PortQry didn't receive a response from the target port. A process may or may not be listening on the port. By default, TCP ports are queried three times and UDP ports are queried one time before reporting the target port is filtered.

With PortQry, you can also query an LDAP service. It sends an LDAP query, using either UDP or TCP, and interprets the LDAP server's response to the query. The response from the LDAP server is parsed, formatted, and returned to the user.

RPC interfaces offered by Active Directory can use dynamic server ports (most are configurable.) Clients use the RPC Endpoint Mapper to find the server port of the RPC interface of a specific Active Directory service.

The RPC end point mapper database listens to port 135. This means that TCP port 135 a required port for most deployments that go beyond basic LDAP queries. It's also required for all clients that are member of a domain.

For more information about PortQry, see:

[310099](https://support.microsoft.com/help/310099) Description of the Portqry.exe command-line utility

You can find a list of ports and protocols that Windows uses including Active Directory, DFS, DFSR, Certificate Services, and all other services in the following knowledge base article:

[832017](https://support.microsoft.com/help/832017#method1) Service overview and network port requirements for Windows

> [!NOTE]
> Active Directory and other services that use ephemeral ports must have connectivity from port 135 to all the listed in the Service overview and network port requirements for Windows article.

Ports and protocols specific to AD can also be found in the article:

[179442](https://support.microsoft.com/help/179442) How to configure a firewall for domains and trusts

PortQry knows how to send a query to the RPC end point mapper (using UDP and TCP) and interpret the response. This query displays all of the end points that are registered with the RPC end point mapper. The response from the end point mapper is parsed, formatted, and returned to the user.

If PortQry isn't available, you can use LDP.EXE to connect to the Domain Controller on port 389 with the **Connectionless** check box activated.

Another alternative to PortQry is NLTEST, but it doesn't work for arbitrary servers. The server must be a Domain Controller in the same domain as the machine that you run the tool on. If this is the case, you can use Nltest /sc_reset **\<domain name>** \ **\<computer name>** to force a security channel onto a specific domain controller. For more information, see [Network Connectivity](/previous-versions/windows/it-pro/windows-2000-server/cc961803%28v=technet.10%29).

## Using portqry

### Example 1: Using Portqry to test connectivity over a specific port and protocol using UDP port 389 as an example

This example demonstrates how to use PortQry to determine if the LDAP service is responding. By examining the response, you can determine which LDAP service is listening on the port and some details about its configuration. This information can be useful in troubleshooting various problems.

By default, LDAP is configured to listen to port 389. The example call specifies the server to query using the UDP protocol:

`PortQry -n <fqdn> -p udp -e 389`

PortQry automatically resolves UDP port 389 using the %SystemRoot%\System32\Drivers\\...\Services file included in Windows Server 2003 and later computers. In the example output below, the port resolves to an LDAP service that is active and PortQry reports that the port is LISTENING or FILTERED.

PortQry then sends a formatted LDAP query to which it receives a response. It returns the whole response to the user and reports that the port is LISTENING. If PortQry doesn't received a response to the query, it reports that the port is FILTERED.

#### Sample output

> C:\\>portqry -n *\<fqdn>* -e 389 -p udp
>
> Querying target system called:
>
> *\<fqdn>*
>
> Attempting to resolve name to IP address...
>
> Name resolved to 169.254.0.14
>
> UDP port 389 (unknown service): LISTENING or FILTERED
>
> Sending LDAP query to UDP port 389...
>
> LDAP query response:
>
> currentdate: *\<DateTime>* (unadjusted GMT)  
subschemaSubentry:  
CN=Aggregate,CN=Schema,CN=Configuration,DC=reskit,DC=com  
dsServiceName: CN=NTDS  
Settings,CN=mydc,CN=Servers,CN=eu,CN=Sites,CN  
=Configuration,DC=reskit,DC=com  
namingContexts: DC=reskit,DC=com  
defaultNamingContext: DC=reskit,DC=com  
schemaNamingContext:  
CN=Schema,CN=Configuration,DC=reskit,DC=com  
configurationNamingContext:  
CN=Configuration,DC=reskit,DC=com  
rootDomainNamingContext: DC=reskit,DC=com  
supportedControl: 1.2.840.113556.1.4.319  
supportedLDAPVersion: 3  
supportedLDAPPolicies: MaxPoolThreads  
highestCommittedUSN: 815431405  
supportedSASLMechanisms: GSSAPI  
dnsHostName: *\<HostName>*  
ldapServiceName: *\<ServiceName>*  
serverName:  
CN=MYDC,CN=Servers,CN=EU,CN=Sites,CN=Configuration,DC=reskit,DC=com  
supportedCapabilities: 1.2.840.113556.1.4.800  
isSynchronized: TRUE  
isGlobalCatalogReady: TRUE  
>
> ======== End of LDAP query response ========  
UDP port 389 is LISTENING  

> [!NOTE]
> The LDAP test over UDP might not work against domain controllers that are running Windows Server 2008 and later. One reason for this can be that you have disabled IPv6 on the Domain Controller. To enable IPv6, set the value discussed in the article below to the default of **0**:  
[929852](https://support.microsoft.com/help/929852) Guidance for configuring IPv6 in Windows for advanced users

### Example 2: Identifying services that have registered with RPC endpoint mapper

This example demonstrates how to use PortQry to determine which services or applications are registered with the target server's RPC end point mapper database. The output includes each application's Universally Unique Identifier (UUID), annotated name (if one exists), the protocol the application uses, the network address that the application is bound to, and the application's end point (port number, named pipe in square brackets). This information can be useful in troubleshooting various problems.

By default, the RPC end point mapper database is configured to listen to port 135. The example call specifies the server to query using the UDP protocol:

`portqry -n <fqdn> -p udp -e 135`

#### Sample output

> Querying target system called:
>
> *\<fqdn>*
>
> Attempting to resolve name to IP address...
>
> Name resolved to 169.254.0.18
>
> UDP port 135 (epmap service): LISTENING or FILTERED  
Querying Endpoint Mapper Database...  
Server's response:  
>
> UUID: ecec0d70-a603-11d0-96b1-00a0c91ece30 NTDS Backup Interface  
ncacn_np:\\\\\\\MYDC[\\PIPE\\lsass]
>
> UUID: 16e0cf3a-a604-11d0-96b1-00a0c91ece30 NTDS Restore Interface  
ncacn_np:\\\\\\\MYDC[\\PIPE\\lsass]
>
> UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface  
ncacn_ip_tcp:169.254.0.18[1027]
>
> UUID: f5cc59b4-4264-101a-8c59-08002b2f8426 NtFrs Service  
ncacn_ip_tcp:169.254.0.18[1130]
>
> UUID: d049b186-814f-11d1-9a3c-00c04fc9b232 NtFrs API  
ncacn_ip_tcp:169.254.0.18[1130]
>
> UUID: d049b186-814f-11d1-9a3c-00c04fc9b232 NtFrs API  
ncacn_np:\\\\\\\MYDC[\\pipe\\00000580.000]
>
> Total endpoints found: 6  
>
> ==== End of RPC Endpoint Mapper query response ====
>
> UDP port 135 is LISTENING

PortQry can send a correctly formatted DNS query (using UDP or TCP). The utility sends a DNS query for "`portqry.microsoft.com`." PortQry then waits for a response from the target DNS server. Whether the DNS response to the query is negative or positive is irrelevant because any response indicates that the port is listening.
