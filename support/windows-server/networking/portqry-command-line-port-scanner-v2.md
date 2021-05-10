---
title: PortQry version 2.0 features and functions
description: Discusses the new features and functionality available in PortQry Command Line Port Scanner version 2.0.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: TCP/IP communications
ms.technology: networking
---
# New features and functionality in PortQry version 2.0  

This article discusses the new features and functionality that are available in PortQry Command Line Port Scanner version 2.0.

_Original product version:_ &nbsp;Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp;832919

## Summary

PortQry version 1.22 is a TCP/IP connectivity testing utility that's included with the Microsoft Windows Server 2003 Support Tools. Microsoft has released a new version of PortQryV2.exe. This new version includes all the features and functionality of the earlier version and has new features and functionality.

> [!NOTE]
> PortQry Command Line Port Scanner version 2.0 is no longer available to download. This article only introduces the features and functionality of it in case you have already downloaded it.

## Overview

PortQry is a command-line utility that you can use to help troubleshoot TCP/IP connectivity issues. This utility reports the port status of target TCP and User Datagram Protocol (UDP) ports on a local computer or on a remote computer. PortQry version 2.0 also provides detailed information about the local computer's port usage. PortQry version 2.0 runs on all the following operating systems:

- Microsoft Windows Server 2003
- Microsoft Windows XP
- Microsoft Windows 2000

## Port status reporting

PortQry reports the status of a port in one of the following ways:

- **LISTENING**: This response indicates that a process is listening on the target port. PortQry received a response from the target port.
- **NOT LISTENING**: This response indicates that no process is listening on the target port. PortQry received one of the following Internet Control Message Protocol (ICMP) messages from the target port:

    Destination unreachable

    Port unreachable
- **FILTERED**: This response indicates that the target port is being filtered. PortQry didn't receive a response from the target port. A process may or may not be listening on the target port. By default, PortQry queries a TCP port three times before it returns a response of **FILTERED** and queries a UDP port one time before it returns a response of **FILTERED**.

## PortQry version 2.0 features

Depending on the process that listens on a UDP port, sometimes it may be difficult to determine the status of that UDP port. When an unformatted zero-length or fixed-length message is sent to a target UDP port, the port may or may not respond. If the port responds, it has a status of LISTENING. If you receive an ICMP "Destination unreachable" message from a UDP port, or if a TCP reset response is returned from a TCP port, the port has a status of **NOT LISTENING**.

Typical port scanning tools report that the port has a LISTENING status if the target UDP port doesn't return an ICMP "Destination unreachable" message. This result may not be accurate for one or both of the following reasons:

- When there's no response to a directed datagram, the target port may be **FILTERED**.
- Most services don't respond to an unformatted user datagram that's sent to them.

Typically, only one correctly formatted message that uses the session layer or that uses the application layer protocol that the listening service or the program understands elicits a response from the target port.

When you troubleshoot a connectivity problem, especially in an environment that contains one or more firewalls, it's useful to know if a port is being filtered or if it's listening. PortQry includes some special features to help make this determination on selected ports. If there's no response from a target UDP port, PortQry reports that the port is **LISTENING** or **FILTERED**. PortQry then sends a correctly formatted message that the listening service or program understands. PortQry uses the correct session layer or application layer protocol to determine if the port is listening. PortQry uses the Services file that's located in the %SYSTEMROOT%\System32\Drivers\Etc folder to determine which service listens on each port.

> [!NOTE]
> This file is stored on each Microsoft Windows Server 2003, Windows XP, and Windows 2000-based computer.

Because PortQry is intended as a troubleshooting tool, it's expected that users who use it to troubleshoot a particular problem have sufficient knowledge of their computing environment. PortQry version 2.0 supports the following session layer and application layer protocols:

- Lightweight Directory Access Protocol (LDAP)
- Remote Procedure Calls (RPC)
- Domain Name System (DNS)
- NetBIOS Name Service
- Simple Network Management Protocol (SNMP)
- Internet Security and Acceleration Server (ISA)
- SQL Server 2000 Named Instances
- Trivial File Transfer Protocol (TFTP)
- Layer Two Tunneling Protocol (L2TP)

Additionally, PortQry version 2.0 can accurately determine if more UDP ports are open than can PortQry version 1.22.

### LDAP support

PortQry can send an LDAP query by using both TCP and UDP and interpret an LDAP server's response to that query correctly. PortQry parses, formats, and then returns the response from the LDAP server to the user. For example, you type the following command, and then press Enter: `portqry -n myserver -p udp -e 389`.

PortQry then performs the following actions:

1. PortQry uses the Services file in the %SYSTEMROOT%\System32\Drivers\Etc folder to resolve the UDP port 389. If PortQry resolves the port to the LDAP service, PortQry sends an unformatted user datagram to UDP port 389 on the destination computer.
    PortQry doesn't receive a response from the target port because the LDAP service only responds to a correctly formatted LDAP query.
2. PortQry reports that the port is **LISTENING** or **FILTERED**.
3. PortQry sends a correctly formatted LDAP query to UDP port 389 on the destination computer.
4. If PortQry receives a response to this query, it returns the whole response to the user and reports that the port is **LISTENING**.
    If PortQry doesn't receive a response to this query, it reports that the port is **FILTERED**.

#### Sample output

```output
UDP port 389 (unknown service): LISTENING or FILTERED  
Sending LDAP query to UDP port 389...  

LDAP query response:  

currentdate: <DateTime> (unadjusted GMT)  
subschemaSubentry: CN=Aggregate,CN=Schema,CN=Configuration,DC=domain,DC=example,DC=com  
dsServiceName: CN=NTDS Settings,CN=myserver,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=domain,DC=example,DC=com  
namingContexts: DC=domain,DC=example,DC=com  
defaultNamingContext: DC=domain,DC=example,DC=com  
schemaNamingContext: CN=Schema,CN=Configuration,DC=domain,DC=example,DC=com  
configurationNamingContext: CN=Configuration,DC=domain,DC=example,DC=com  
rootDomainNamingContext: DC=domain,DC=example,DC=com  
supportedControl: 1.2.840.113556.1.4.319  
supportedLDAPVersion: 3  
supportedLDAPPolicies: MaxPoolThreads  
highestCommittedUSN: 4259431  
supportedSASLMechanisms: GSSAPI  
dnsHostName: myserver.domain.example.com  
ldapServiceName: domain.example.com:myserver$@domain.EXAMPLE.COM  
serverName: CN=myserver,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=domain,DC=example,DC=com  
supportedCapabilities: 1.2.840.113556.1.4.800  
isSynchronized: TRUE  
isGlobalCatalogReady: TRUE  
domainFunctionality: 0  
forestFunctionality: 0  
domainControllerFunctionality: 2  

======== End of LDAP query response ========

UDP port 389 is LISTENING
```

In this example, you determine that port 389 is listening. Additionally, you can determine which LDAP service is listening on port 389 and certain details about that service.

Be aware that the LDAP test over UDP may not work against domain controllers that are running Windows Server 2008. To check the availability of the service that's running on UDP 389, you can use NLTEST instead of the PortQry tool. For example, you can use Nltest /sc_reset **\<domain name>**\\**\<computer name>** to force a security channel onto a particular domain controller. For more information, visit the following Microsoft Web site:

[Network Connectivity](https://technet.microsoft.com/library/cc961803.aspx)

### RPC support

PortQry can send an RPC query by using both TCP and UDP and interpret the response to that query correctly. This query returns (dumps) all the end points that are currently registered with the RPC endpoint mapper. PortQry parses, formats, and then returns the response from the RPC endpoint mapper to the user. For example, you type the following command, and then press Enter: `portqry -n myserver -p udp -e 135`.

PortQry then performs the following actions:

1. PortQry uses the Services file in the %SYSTEMROOT%\System32\Drivers\Etc folder to resolve the UDP port 135. If PortQry resolves the port to the RPC End Point Mapper service (Epmap), PortQry sends an unformatted user datagram to UDP port 135 on the destination computer.
    PortQry doesn't receive a response from the target port because the RPC endpoint mapper service only responds to a correctly formatted RPC query.
2. PortQry reports that the port is **LISTENING** or the port is **FILTERED**.
3. PortQry sends a correctly formatted RDC query to UDP port 135 on the destination computer. This query returns all the endpoints that are currently registered with the RPC endpoint mapper.
4. If PortQry receives a response to this query, PortQry returns the whole response to the user and reports that the port is **LISTENING**.
    If PortQry doesn't receive a response to this query, it reports that the port is **FILTERED**.

#### Sample output

```output
UDP port 135 (epmap service): LISTENING or FILTERED  
Querying Endpoint Mapper Database...  
Server's response:  

UUID: 50abc2a4-574d-40b3-9d66-ee4fd5fba076
ncacn_ip_tcp:169.254.12.191[4144]

UUID: ecec0d70-a603-11d0-96b1-00a0c91ece30 NTDS Backup Interface
ncacn_np:\\MYSERVER[\PIPE\lsass]

UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface
ncacn_ip_tcp:169.254.12.191[1030]

UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface
ncadg_ip_udp:169.254.12.191[1032]

UUID: 12345678-1234-abcd-ef00-01234567cffb
ncacn_np:\\MYSERVER[\PIPE\lsass]

UUID: 12345678-1234-abcd-ef00-01234567cffb
ncacn_np:\\MYSERVER[\PIPE\POLICYAGENT]

Total endpoints found: 6

==== End of RPC Endpoint Mapper query response ====

UDP port 135 is LISTENING
```

In this example, you determine that port 135 is listening. Additionally, you can determine which services or programs are registered with the RPC endpoint mapper database on the destination computer. The output includes the universal unique identifier (UUID) for each program, the annotated name (if one exists), the protocol that each program uses, the network address that the program is bound to, and the program's endpoint in square brackets.

> [!NOTE]
> When you specify the **-r** option in the `PortQry.exe` command to scan a range of ports, the RPC End Point Mapper isn't queried. This makes the scan of a range of ports faster.

#### DNS support

PortQry can send a correctly formatted DNS query by using both TCP and UDP. PortQry sends a DNS query for the following fully qualified domain name (FQDN):

portqry.microsoft.com

PortQry then waits for a response from the destination DNS server. If the server returns a response, PortQry determines that the port is **LISTENING**.

> [!NOTE]
> It's not important whether the DNS server returns a negative response. Any response indicates that the port is listening.

### NetBIOS name service support

By default, the NetBIOS name service listens on UDP port 137. When PortQry determines that this port is **LISTENING** or **FILTERED**, PortQry performs the following actions to determine whether the port is actually listening:

1. If NetBIOS is available on the computer where you're running PortQry, PortQry sends a NetBIOS adapter status query to the destination computer.
2. If the destination computer responds to this query, PortQry reports that the target port is **LISTENING**, and then returns the destination computer's media access control (MAC) address to the user.

If NetBIOS isn't available on the computer where you're running PortQry, PortQry doesn't try to send a NetBIOS adapter status query to the destination computer.

### SNMP support

SNMP support is a new feature in PortQry version 2.0. By default, the SNMP service listens on UDP port 161. To determine whether port 161 is listening, PortQry sends a query that's formatted in the way that the SNMP service accepts. The SNMP service is configured with a community name or a string that you must know to obtain a response from the server. With PortQry, you can specify SNMP community names when you query this port. By default, PortQry uses the community name, "Public." To specify a different community name, use the **-cn** command-line option. When you specify a community name in the `PortQry.exe` command, enclose that community name in exclamation marks (!). For example, to specify a community name such as **secure123**, type a command that's similar to the following command: `portqry -n 127.0.0.1 -e 161 -p udp -cn !secure123!`.

#### Sample output

```output
Querying target system called:

127.0.0.1

querying...

UDP port 161 (snmp service): LISTENING or FILTERED

community name for query:

secure123

Sending SNMP query to UDP port 161...

UDP port 161 is LISTENING
```

### ISA Server support

Microsoft ISA Server support is a new feature in PortQry version 2.0. By default, ISA Server uses TCP port 1745 and UDP port 1745 to communicate with Winsock proxy clients and with firewall clients. Computers that have the Winsock proxy client program or the Firewall client program installed use these ports to request services from ISA Server and to download configuration information. Typically, these services include name resolution services and other services that aren't HTTP-based (for example, Winsock connections). To determine whether the port is listening, PortQry sends a query that's formatted in the way that ISA Server accepts.

#### Sample output

For example, you type a command that's similar to the following command: `portqry -n myproxy-server -p udp -e 1745`.

You receive the following output:

```output
Querying target system called:

myproxy-server

Attempting to resolve name to IP address...

Name resolved to 169.254.24.86

querying...

UDP port 1745 (unknown service): LISTENING or FILTERED

Sending ISA query to UDP port 1745...

UDP port 1745 is LISTENING
```

When PortQry queries TCP port 1745, PortQry downloads the Mspclnt.ini file from the ISA Server if the Mspclnt.ini file is available on that port. The Mspclnt.ini file contains configuration information that Winsock proxy clients and Firewall clients use.

#### Sample output

```output
TCP port 1745 (unknown service): LISTENING

Sending ISA query to TCP port 1745...

ISA query response:

10.0.0.0 10.255.255.255  
127.0.0.1 127.0.0.1  
169.254.0.0 169.254.255.255  
192.168.0.0 192.168.255.255  
127.0.0.0 127.255.255.255  

;  
; This file should not be edited.  
; Changes to the client configuration should only be made using ISA Management.  
;  
[Common]  
myproxy-server.example.com  
Set Browsers to use Auto Detect=1  
AutoDetect ISA Servers=1  
WebProxyPort=8080  
Port=1745  
Configuration Refresh Time (Hours)=2  
Re-check Inaccessible Server Time (Minutes)=10  
Refresh Give Up Time (Minutes)=15  
Inaccessible Servers Give Up Time (Minutes)=2  
[Servers Ip Addresses]  
Name=myproxy-server  
[My Config]  
Path1=\\myproxy-server\mspclnt\  

======== End of ISA query response ========
```

### SQL Server 2000 support

Microsoft SQL Server 2000 support is a new feature in PortQry version 2.0. PortQry queries UDP port 1434 to query all the SQL Server named instances that are running on a SQL Server 2000 computer. PortQry sends a query that's formatted in the way that SQL Server 2000 accepts to determines whether this port is listening.

#### Sample output

For example, you type a command that's similar to the following command: `portqry -n 192.168.1.20 -e 1434 -p udp`.

You receive the following output:

```output
Querying target system called:

192.168.1.20

querying...

UDP port 1434 (ms-sql-m service): LISTENING or FILTERED

Sending SQL Server query to UDP port 1434...

Server's response:

ServerName SQL-Server1  
InstanceName MSSQLSERVER  
IsClustered No  
Version 8.00.194  
tcp 1433  
np \SQL-Server1\pipe\sql\query

==== End of SQL Server query response ====

UDP port 1434 is LISTENING
```

### TFTP support

TFTP support is a new feature in PortQry version 2.0. By default, TFTP servers listen on UDP port 69. PortQry sends a query that's formatted in the way that the TFTP server accepts to determine whether this port is listening.

#### Sample output

For example, you type a command that's similar to the following command: `portqry -n myserver.example.com -p udp -e 69`.

You receive the following output:

```output
Querying target system called:

myserver.example.com

Attempting to resolve name to IP address...

Name resolved to 169.254.23.4

querying...

UDP port 69 (tftp service): LISTENING or FILTERED

Sending TFTP query to UDP port 69...

UDP port 69 is LISTENING
```

### L2TP support

L2TP support is a new feature in PortQry version 2.0. Routing and Remote Access servers and other virtual private networking (VPN) servers listen on UDP port 1701 for inbound L2TP connections. PortQry sends a query that's formatted in the way that the VPN server accepts to determine whether this port is listening.

#### Sample output

For example, you type a command that's similar to the following command: `portqry -n vpnserver.example.com -e 1701-p udp`.

You receive the following output:

```output
Querying target system called:

vpnserver

Attempting to resolve name to IP address...

Name resolved to 169.254.12.225

querying...

UDP port 1701 (l2tp service): LISTENING or FILTERED

Sending L2TP query to UDP port 1701...

UDP port 1701 is LISTENING
```

### Customize ports that queries use

By default, every Windows Server 2003, Windows XP, and Windows 2000-based computer has a Services file that's located in the %SYSTEMROOT%\System32\Drivers\Etc folder. PortQry uses this file to resolve port numbers to their corresponding service names. The content of this file dictates the ports where PortQry sends formatted messages when you use the `PortQry.exe` command. You can edit this file to direct PortQry to send formatted messages to an alternative port. For example, the following entry appears in a typical Services file:

```output
ldap              389/tcp                           #Lightweight Directory Access Protocol
```

You can edit this port entry or add an additional entry. To cause PortQry to send LDAP queries to port 1025, modify the entry to the following entry:

```output
ldap              1025/tcp                           #Lightweight Directory Access Protocol
```

### Additional service information returned

PortQry displays extended information that some ports may return. PortQry looks for this "extended information" on ports where the following services listen:

- Simple Mail Transfer Protocol (SMTP)
- Microsoft Exchange POP3
- Microsoft Exchange IMAP4
- FTP Publishing Service
- ISA Server services

For example, by default, the FTP service listens on TCP port 21. When PortQry determines that TCP port 21 on the destination computer is **LISTENING**, it uses the information from the Services file to determine that the FTP service is listening on this port.

> [!NOTE]
> You can change the service that PortQry determines is listening on a port by editing the Services file. For more information, see the "[Customize ports that queries use](#customize-ports-that-queries-use)" section of this article.

In this scenario, PortQry tries to use the Anonymous user account to log on to the FTP server. The result of this logon attempt indicates whether the destination FTP server accepts anonymous logons. PortQry returns the server's response.

**Example 1**: You type a command that's similar to the following command, and then press Enter: `portqry -n MyFtpServer -p tcp -e 21`.

You receive a response that's similar to the following response:

```output
TCP port 21 (ftp service): LISTENING

Data returned from port:  
220 Microsoft FTP Service

331 Anonymous access allowed, send identity (e-mail name) as password.
```

In Example 1, you can determine the type of FTP server that's listening on the target port and whether the FTP server is configured to permit anonymous user logons.

**Example 2**: You type a command that's similar to the following command, and then press Enter: `portqry -n MyMailServer -p tcp -e 25`.

You receive a response that's similar to the following response:

```output
TCP port 25 (smtp service): LISTENING

Data returned from port:  
220 MyMailServer.domain.example.com Microsoft ESMTP MAIL Service, Version: 6.0.3790.0 ready at Mon, 15 Dec 2003 10:24:50 -0800
```

In Example 2, you can determine the type of SMTP server that's listening on the target port.

### PortQry command-line options

You can use the following command-line options with PortQry:

- **-n** (name): This parameter is required. Use this parameter to specify the destination computer. You can specify a host name or a host IP address. However, you can't embed spaces in the host name or in the IP address. PortQry resolves the host name to an IP address. If PortQry can't resolve the host name to an IP address, the tool reports an error, and then exits. If you enter an IP address, PortQry resolves it to a host name. If the resolution is unsuccessful, PortQry reports an error, but continues to process the command.

   Examples
  
    portqry -n **myserver**  
  
    portqry -n `www.widgets.microsoft.com`
  
    portqry -n **192.168.1.10**  
  
- **-p** (protocol): This parameter is optional. Use this parameter to specify the type of port or protocol that's used to connect to the target port on the destination computer. If you don't specify a protocol, PortQry uses TCP as the protocol.

    Valid parameters

    - **TCP** (default): Specifies a TCP end point.
    - **UDP**: Specifies a UDP end point.
    - **BOTH**: Specifies both a TCP end point and a UDP end point. When you use this option, PortQry queries both the TCP end point and the UDP end point that you specify.

   Examples
  
    portqry -n **myDomainController.example.com** -p tcp
  
    portqry -n **myServer** -p udp
  
    portqry -n **192.168.1.20** -p both
  
    portqry -n `www.widgets.microsoft.com` (This command uses the default parameter tcp. )

- **-e** (endpoint): This parameter is optional. Use this parameter to specify the end point (or the port number) on the destination computer. This must be a valid port number between 1 and 65535 inclusive. You can't use this parameter together with the -o parameter or the -r parameter. If you don't specify a port number, PortQry queries port 80.

   Examples
  
    portqry -n **myserver** -p udp -e 139
  
    portqry -n **mail.example.com** -p tcp -e 25
  
    portqry -n **myserver** (This command uses the default parameter of port 80.)
  
    portqry -n **192.168.1.20** -p both -e 60897
  
- **-o** (order): This parameter is optional. Use this parameter to specify a certain number of ports to be queried in a particular order. You can't use this option together with the **-e** parameter or together with the **-r** parameter. When you use this parameter, use commas to delimit the port numbers. You can enter the port numbers in any order. However, you can't leave spaces between the port numbers and the comma delimiters.

    Examples
  
    portqry -n **myserver** -p udp -o 139,1025,135
  
    portqry -n **mail.widgets.microsoft.com** -p tcp -o 143,110,25
  
    portqry -n **192.168.1.20** -p both -o 100,1000,10000

- **-r** (range): This parameter is optional. Use this parameter to specify a range of port numbers to query in sequential order. You can't use this option together with the **-e** parameter or together with the **-o** parameter. When you use this parameter, use a semi-colon (;) to delimit the starting port number and the ending port number. Specify a starting port that's lower than the ending port. Additionally, you can't put spaces between the port numbers and the semi-colon. When you use this parameter, the RPC End Point Mapper isn't queried.

    Examples
  
    portqry -n **myserver** -p udp -r 135;139
  
    portqry-n `www.widgets.microsoft.com` -p tcp -r 10;20
  
    portqry -n **192.168.1.20** -p both -r 25;120

- **-l** (log file): This parameter is optional. Use this parameter to specify a log file to record the output generated by PortQry. When you use this parameter, specify a file name together with the file name extension. You can't type spaces in the log file name. The log file is created in the folder where PortQry runs. PortQry generates the log file output in text format. If an existing log file with the same name exists, you're prompted to overwrite it when you run the `PortQry` command.

    Examples
  
    portqry -n **myserver** -p udp -r 135;139 -l myserverlog.txt
  
    portqry -n **mail.widgets.microsoft.com** -p tcp -o 143,110,25 -l portqry.log
  
    portqry -n **192.168.1.20** -p both -e 500 -l ipsec.txt -y
  
- **-y** (yes, overwrite): This parameter is optional. Use this parameter together with the **-l** parameter to suppress the "overwrite" prompt when a log file exists that has the same name that you specify in the `PortQry` command. When you use this parameter, PortQry overwrites the existing log file without prompting you.

    Examples
  
    portqry -n **myserver** -p udp -r 135;139 -l myserverlog.txt -y
  
    portqry -n **mail.widgets.microsoft.com** -p tcp -o 143,110,25 -l portqry.log -y
  
- **-sl** (slow link): This parameter is optional. Use this parameter to cause PortQry to wait longer for responses from UDP queries. Because UDP is a connectionless protocol, PortQry can't determine whether the port is slow to respond or the port is filtered. This option doubles the time that PortQry waits for a response from a UDP port before PortQry determines that the port is NOT LISTENING or that it's FILTERED. Use this option when you query a UDP port across a slow or unreliable network link.

    Examples
  
    portqry -n **myserver** -p udp -r 135;139 -l **myserver.txt** -sl
  
    portqry -n **mail.widgets.microsoft.com** -p tcp -o 143,110,25 -sl
  
    portqry -n **192.168.1.20** -p both -e 500 -sl
  
- **-nr** (no reverse name lookup): This parameter is optional. Use this parameter to bypass the reverse name lookup that PortQry performs when you specify an IP address together with the **-n** parameter. By default, when you specify an IP address together with the **-n** parameter, PortQry tries to resolve the IP address to a host name. This process may be time-consuming, especially if PortQry can't resolve the IP address. When you specify the **-nr** parameter, PortQry doesn't look up the IP address to return the host name. Instead, PortQry queries the target ports immediately. The **-nr** parameter is ignored if you specify a host name together with the **-n** parameter.

    Examples
  
    portqry -n **192.168.22.21** -p udp -r 135:139 -l **myserver.txt** -s -nr
  
    portqry -n **10.1.1.10** -p tcp -o 143,110,25 -s -nr
  
    portqry -n **169.254.18.22** -p both -e 500 -s -nr
  
- **-q** (quiet mode): This parameter is optional. Use this parameter to cause PortQry to suppress all output to the screen except for error messages. This parameter is especially helpful when you configure PortQry for use in a batch file. Depending on the status of the port, this parameter returns the following outputs:

  - 0 (zero) is returned if the target port is **LISTENING**.
  - 1 is returned if the target port is **NOT LISTENING**.
  - 2 is returned if the target port is **LISTENING** or **FILTERED**.
  
    You can only use this parameter together with the **-e** parameter. You can't use this parameter together with the **-o** parameter or together with the **-r** parameter. Additionally, you can't use this parameter together with the **-p** parameter when you set the value of the **-p** parameter to **Both**.

    > [!IMPORTANT]
    > When you use the **-q** parameter together with the **-l** (log file) parameter, PortQry overwrites an existing log file that has the same name without first prompting you for permission to do so.

    Sample batch file

   ```console
    :Top  
    portqry -n 169.254.18.22 -e 135 -p tcp -q  
    if errorlevel = 2 goto filtered  
    if errorlevel = 1 goto failed  
    if errorlevel = 0 goto success  
    goto end

    :filtered  
    Echo Port is listening or filtered  
    goto end  

    :failed  
    Echo Port is not listening  
    Goto end  

    :success  
    Echo Port is listening  
    goto end  

    :end
   ```

- **-cn** (community name): This parameter is optional. Use this parameter to specify a community string or community name to use when you send an SNMP query. With this parameter, you must enclose the community string with exclamation marks (!). This parameter is ignored if you don't query a port where SNMP is listening.

    Examples
  
    portqry -n **myserver** -p udp -e 161 -l **myserver.txt** -cn ! **snmp string**!
  
    portqry -n `www.widgets.microsoft.com` -p both -r 150:170 -sl -cn ! **my_snmp_community_name**!

- **-sp** (source port): This parameter is optional. Use this parameter to specify the initial source port to use when you connect to the specified TCP and UDP ports on the destination computer. This functionality is useful to help you test firewall or router rules that filter ports based on their source ports.

    Example

    portqry -p udp -e 53 - sp 3001 -n 192.168.1.20

    In this example, PortQry uses UDP port 3001 on the local computer to send the query. Replies from this query go to UDP port 3001 on the local computer. PortQry can't use the specified source port if another process already has bound to the port. In this scenario, PortQry returns the following error message:
  
    > Cannot use specified source port.  
    > Port is already in use.  
    > Specify a port that is not in use and run the command again.
  
    PortQry uses the specified source port when it sends the initial query to the destination computer. PortQry also uses this specified source port if it tries to use protocols such as FTP, SMTP, POP, IMAP, DNS, SNMP, ISA Server, and other protocols to query the destination computer. There are only the following exceptions to this rule:
  
    RPC (TCP and UDP ports 135)
  
    LDAP (UDP port 389)
  
    NetBIOS Adapter status query (UDP port 137)
  
    Internet Security Association and Key Management Protocol (ISAKMP) (UDP port 500)
  
    In these exceptional cases, PortQry uses the specified source port for its initial query. When it tries to query the destination computer through one of the exceptional protocols, it queries the destination computer through an ephemeral source port. For example, if you specify the source port of 3000 when you query UDP port 389 (LDAP), PortQry uses UDP port 3000 if it's available for the initial UDP datagram that's sent to the LDAP port. When PortQry sends an LDAP query to the LDAP port, PortQry use an ephemeral port instead of the specified source port. (In this example, the specified source port is 3000). When PortQry uses an ephemeral port for specific queries, PortQry sends the following message:
  
    Using ephemeral source port
    With ISAKMP/IPSec, the IPSec policy agent may only send responses from queries back to UDP port 500. In this case, it is best for PortQry to use UDP port 500 as the source port for the query. If the IPSec policy agent is running on the computer where PortQry runs, UDP port 500 is unavailable because the policy agent is using the port. In this case, PortQry returns the following message:Cannot use source port 500, this port is already in use. Remote ISAKMP/IPSec services may only communicate with source port 500.
    Temporarily turn off the 'IPSEC Policy Agent' or the 'IPSEC Services' on the system you are running PortQry from and run the command again
  
    example: net stop PolicyAgent
  
    run Portqry to query ISAKMP
  
    net start PolicyAgent

## Additional features

PortQry version 2.0 includes the following new features:

- PortQry interactive mode
- PortQry local mode

### PortQry interactive mode

With PortQry version 1.22, users can query ports from the command line in a command prompt window. When you troubleshoot connectivity issues between computers, you may have to type many repetitive commands. With PortQry version 2.0, you can run commands this way, but PortQry version 2.0 also has an interactive mode. The interactive mode is similar to the interactive functionality in the Nslookup DNS utility or in the Nblookup WINS utility.

To start PortQry in interactive mode, use the **-i** option. For example, type portqry **-i**. When you do so, you receive the following output:

```output
Portqry Interactive Mode

Type 'help' for a list of commands

Default Node: 127.0.0.1

Current option values:  
end port= 80  
protocol= TCP  
source port= 0 (ephemeral)
```

You can use other parameters together with the **-i** parameter to change the settings that PortQry uses. For example, you type a command that's similar to the following command, and then press Enter: `portqry -i -e 53 -n 192.168.1.20 -p both -sp 2030`.

You receive the following output:

```output
Portqry Interactive Mode

Type 'help' for a list of commands

Default Node: 192.168.1.20

Current option values:
end port= 53
protocol= BOTH
source port= 2300
```

## PortQry local mode

The PortQry local mode of operation is designed to give you detailed information about the TCP ports and the UDP ports on the local computer where PortQry runs. PortQry has the following three basic commands available in local mode:

- **portqry.exe -local**: When you run this command, PortQry tries to enumerate all the TCP and UDP port mappings that are currently active on the local computer. This output is similar to the output that the `netstat.exe -an` command generates.

    Sample output

    ```output
    TCP/UDP Port Usage
    
    96 active ports found
    
    Port Local IPState Remote IP:Port  
    TCP 80 0.0.0.0 LISTENING 0.0.0.0:18510  
    TCP 80 169.254.149.9 TIME WAIT 169.254.74.55:3716  
    TCP 80 169.254.149.9 TIME WAIT 169.254.200.222:3885  
    TCP 135 0.0.0.0 LISTENING 0.0.0.0:10280  
    UDP 135 0.0.0.0 :  
    UDP 137 169.254.149.9 :  
    UDP 138 169.254.149.9 :  
    TCP 139 169.254.149.9 LISTENING 0.0.0.0:43065  
    TCP 139 169.254.149.9 ESTABLISHED 169.254.4.253:4310  
    TCP 139 169.254.149.9 ESTABLISHED 169.254.74.55:3714  
    UDP 161 0.0.0.0 :  
    TCP 445 0.0.0.0 LISTENING 0.0.0.0:34836  
    TCP 445 169.254.149.9 ESTABLISHED 169.254.53.54:4443  
    TCP 445 169.254.149.9 ESTABLISHED 169.254.112.122:2111  
    TCP 445 169.254.149.9 ESTABLISHED 169.254.112.199:1188  
    TCP 445 169.254.149.9 ESTABLISHED 169.254.113.96:1221  
    TCP 445 169.254.149.9 ESTABLISHED 169.254.200.222:3762  
    UDP 445 0.0.0.0 :  
    UDP 500 169.254.149.9 :  
    TCP 593 0.0.0.0 LISTENING 0.0.0.0:59532  
    UDP 1029 0.0.0.0 :  
    TCP 1040 127.0.0.1 LISTENING 0.0.0.0:18638  
    UDP 1045 0.0.0.0 :  
    TCP 1048 127.0.0.1 LISTENING 0.0.0.0:2240  
    TCP 1053 127.0.0.1 LISTENING 0.0.0.0:26649  
    TCP 1061 127.0.0.1 LISTENING 0.0.0.0:26874  
    TCP 1067 127.0.0.1 LISTENING 0.0.0.0:2288  
    TCP 1068 0.0.0.0 LISTENING 0.0.0.0:2048  
    TCP 1088 127.0.0.1 LISTENING 0.0.0.0:35004  
    UDP 1089 0.0.0.0 :  
    TCP 1091 127.0.0.1 LISTENING 0.0.0.0:43085  
    TCP 1092 0.0.0.0 LISTENING 0.0.0.0:2096  
    TCP 1094 127.0.0.1 LISTENING 0.0.0.0:51268  
    TCP 1097 127.0.0.1 LISTENING 0.0.0.0:2104  
    TCP 1098 0.0.0.0 LISTENING 0.0.0.0:43053  
    TCP 1108 0.0.0.0 LISTENING 0.0.0.0:2160  
    TCP 1108 169.254.149.9 ESTABLISHED 169.254.12.210:1811  
    TCP 1117 127.0.0.1 LISTENING 0.0.0.0:26819  
    TCP 1118 0.0.0.0 LISTENING 0.0.0.0:43121  
    TCP 1119 0.0.0.0 LISTENING 0.0.0.0:26795  
    TCP 1121 0.0.0.0 LISTENING 0.0.0.0:26646  
    UDP 1122 0.0.0.0 :  
    TCP 1123 0.0.0.0 LISTENING 0.0.0.0:35013  
    UDP 1126 0.0.0.0 :  
    TCP 1137 127.0.0.1 LISTENING 0.0.0.0:34820  
    TCP 1138 0.0.0.0 LISTENING 0.0.0.0:26696  
    TCP 1138 169.254.149.9 CLOSE WAIT 169.254.5.103:80  
    TCP 1170 127.0.0.1 LISTENING 0.0.0.0:34934  
    TCP 1179 127.0.0.1 LISTENING 0.0.0.0:59463  
    TCP 1228 127.0.0.1 LISTENING 0.0.0.0:2128  
    UDP 1352 0.0.0.0 :  
    TCP 1433 0.0.0.0 LISTENING 0.0.0.0:2064  
    UDP 1434 0.0.0.0 :  
    TCP 1670 0.0.0.0 LISTENING 0.0.0.0:2288  
    TCP 1670 169.254.149.9 ESTABLISHED 169.254.233.87:445  
    TCP 1686 127.0.0.1 LISTENING 0.0.0.0:51309  
    UDP 1687 127.0.0.1 :  
    TCP 1688 0.0.0.0 LISTENING 0.0.0.0:2135  
    TCP 1688 169.254.149.9 CLOSE WAIT 169.254.113.87:80  
    TCP 1689 0.0.0.0 LISTENING 0.0.0.0:51368  
    TCP 1689 169.254.149.9 CLOSE WAIT 169.254.113.87:80  
    TCP 1693 169.254.149.9 TIME WAIT 169.254.121.106:445  
    UDP 1698 0.0.0.0 :  
    TCP 1728 127.0.0.1 LISTENING 0.0.0.0:2077  
    TCP 1766 127.0.0.1 LISTENING 0.0.0.0:35061  
    TCP 2605 127.0.0.1 LISTENING 0.0.0.0:2069  
    TCP 3302 127.0.0.1 LISTENING 0.0.0.0:2048  
    TCP 3372 0.0.0.0 LISTENING 0.0.0.0:18612  
    TCP 3389 0.0.0.0 LISTENING 0.0.0.0:18542  
    TCP 3389 169.254.149.9 ESTABLISHED 169.254.112.67:2796  
    TCP 3389 169.254.149.9 ESTABLISHED 169.254.113.96:4603  
    TCP 3389 169.254.149.9 ESTABLISHED 169.254.201.100:3917  
    UDP 3456 0.0.0.0 :  
    TCP 3970 0.0.0.0 LISTENING 0.0.0.0:35012  
    TCP 3970 169.254.149.9 CLOSE WAIT 169.254.5.138:80  
    TCP 3972 0.0.0.0 LISTENING 0.0.0.0:51245  
    TCP 3972 169.254.149.9 CLOSE WAIT 169.254.5.138:80  
    TCP 4166 127.0.0.1 LISTENING 0.0.0.0:2208  
    UDP 4447 0.0.0.0 :  
    TCP 4488 127.0.0.1 LISTENING 0.0.0.0:10358  
    UDP 4500 169.254.149.9 :  
    TCP 4541 127.0.0.1 LISTENING 0.0.0.0:10442  
    TCP 4562 0.0.0.0 LISTENING 0.0.0.0:2192  
    TCP 4562 169.254.149.9 ESTABLISHED 169.254.0.40:1025  
    UDP 4563 0.0.0.0 :  
    UDP 4564 0.0.0.0 :  
    TCP 4566 0.0.0.0 LISTENING 0.0.0.0:51257  
    TCP 4566 169.254.149.9 ESTABLISHED 169.254.12.18:1492  
    TCP 4568 127.0.0.1 LISTENING 0.0.0.0:26665  
    TCP 4569 0.0.0.0 LISTENING 0.0.0.0:43186  
    TCP 4569 169.254.149.9 CLOSE WAIT 169.254.4.38:80  
    TCP 4756 0.0.0.0 LISTENING 0.0.0.0:51268  
    UDP 4758 0.0.0.0 :  
    TCP 8953 0.0.0.0 LISTENING 0.0.0.0:26667  
    TCP 42510 0.0.0.0 LISTENING 0.0.0.0:51323  
    UDP 43508 169.254.149.9 :  
    
    Port Statistics
    
    TCP mappings: 74  
    UDP mappings: 22
    
    TCP ports in a LISTENING state: 51 = 68.92%  
    TCP ports in a ESTABLISHED state: 14 = 18.92%  
    TCP ports in a CLOSE WAIT state: 6 = 8.11%  
    TCP ports in a TIME WAIT state: 3 = 4.05%
    ```  

    On computers that support Process ID (PID) to port mappings, the output includes the process ID of the process that's using the port on the local computer. If the verbose option is used (**-v**), the output also includes the names of the services that the process ID belongs to and lists all the modules that the process has loaded. Access to some information is restricted. For example, access to module information for the Idle and CSRSS processes is prohibited because their access restrictions prevent user-level code from opening them. PortQry reports as much information as it can access for each process. For best results, run the `Portqry -local` command in the context of the local Administrator or an account that has similar credentials. The following example log file excerpt illustrates the level of reporting that you may receive when you run the `Portqry -local` command:

    ```output
    TCP/UDP Port to Process Mappings
    
    55 mappings found
    
    PID:ProcessPortLocal IPState Remote IP:Port  
    0:System IdleTCP 4442 169.254.113.96 TIME WAIT 169.254.5.136:80  
    0:System IdleTCP 4456 169.254.113.96 TIME WAIT 169.254.5.44:445  
    4:SystemTCP 445 0.0.0.0 LISTENING 0.0.0.0:2160  
    4:SystemTCP 139 169.254.113.96 LISTENING 0.0.0.0:24793  
    4:SystemTCP 1475 169.254.113.96 ESTABLISHED 169.254.8.176:445  
    4:SystemUDP 445 0.0.0.0 :  
    4:SystemUDP 137 169.254.113.96 :  
    4:SystemUDP 138 169.254.113.96 :  
    424:winlogon.exeTCP 1200 169.254.113.96 CLOSE WAIT 169.254.5.44:389  
    424:winlogon.exeUDP 1100 0.0.0.0 :  
    484:lsass.exeTCP 1064 0.0.0.0 LISTENING 0.0.0.0:2064  
    484:lsass.exeUDP 500 0.0.0.0 :  
    484:lsass.exeUDP 1031 0.0.0.0 :  
    484:lsass.exeUDP 4500 0.0.0.0 :  
    668:svchost.exeTCP 135 0.0.0.0 LISTENING 0.0.0.0:16532  
    728:svchost.exeTCP 3389 0.0.0.0 LISTENING 0.0.0.0:45088  
    800UDP 1026 0.0.0.0 :  
    800UDP 1027 0.0.0.0 :  
    836:svchost.exeTCP 1025 0.0.0.0 LISTENING 0.0.0.0:43214  
    836:svchost.exeTCP 1559 169.254.113.96 CLOSE WAIT 169.254.5.44:389  
    836:svchost.exeUDP 1558 0.0.0.0 :  
    836:svchost.exeUDP 123 127.0.0.1 :  
    836:svchost.exeUDP 3373 127.0.0.1 :  
    836:svchost.exeUDP 123 169.254.113.96 :  
    1136:mstsc.exeTCP 2347 169.254.113.96 ESTABLISHED 172.30.137.221:3389  
    1136:mstsc.exeUDP 2348 0.0.0.0 :  
    1276:dns.exeTCP 53 0.0.0.0 LISTENING 0.0.0.0:2160  
    1276:dns.exeTCP 1087 0.0.0.0 LISTENING 0.0.0.0:37074  
    1276:dns.exeUDP 1086 0.0.0.0 :  
    1276:dns.exeUDP 2126 0.0.0.0 :  
    1276:dns.exeUDP 53 127.0.0.1 :  
    1276:dns.exeUDP 1085 127.0.0.1 :  
    1276:dns.exeUDP 53 169.254.113.96 :  
    1328:InoRpc.exeTCP 42510 0.0.0.0 LISTENING 0.0.0.0:220  
    1328:InoRpc.exeUDP 43508 169.254.113.96 :  
    1552:CcmExec.exeUDP 1114 0.0.0.0 :  
    1896:WINWORD.EXETCP 3807 169.254.113.96 CLOSE WAIT 169.254.237.37:3268  
    1896:WINWORD.EXEUDP 3806 0.0.0.0 :  
    1896:WINWORD.EXEUDP 1510 127.0.0.1 :  
    2148:IEXPLORE.EXETCP 4446 169.254.113.96 ESTABLISHED 169.254.113.92:80  
    2148:IEXPLORE.EXEUDP 4138 127.0.0.1 :  
    3200:program.exeTCP 1906 169.254.113.96 ESTABLISHED 169.254.0.40:1025  
    3200:program.exeTCP 4398 169.254.113.96 ESTABLISHED 169.254.209.96:1433  
    3200:program.exeTCP 4438 169.254.113.96 ESTABLISHED 169.254.209.96:1433  
    3592:OUTLOOK.EXETCP 1256 169.254.113.96 ESTABLISHED 169.254.1.105:1025  
    3592:OUTLOOK.EXETCP 2214 169.254.113.96 CLOSE WAIT 169.254.237.37:3268  
    3592:OUTLOOK.EXETCP 2971 169.254.113.96 ESTABLISHED 169.254.5.216:1434  
    3592:OUTLOOK.EXETCP 4439 169.254.113.96 ESTABLISHED 169.254.47.242:1788  
    3592:OUTLOOK.EXEUDP 1307 0.0.0.0 :  
    3592:OUTLOOK.EXEUDP 1553 0.0.0.0 :  
    3660:IEXPLORE.EXETCP 4452 169.254.113.96 ESTABLISHED 169.254.9.74:80  
    3660:IEXPLORE.EXETCP 4453 169.254.113.96 ESTABLISHED 169.254.9.74:80  
    3660:IEXPLORE.EXETCP 4454 169.254.113.96 ESTABLISHED 169.254.230.88:80  
    3660:IEXPLORE.EXEUDP 4451 127.0.0.1 :  
    4048:program2.exeUDP 3689 127.0.0.1 :  
    
    Port Statistics
    
    TCP mappings: 27
    UDP mappings: 28
    
    TCP ports in a LISTENING state: 9 = 33.33%  
    TCP ports in a ESTABLISHED state: 12 = 44.44%  
    TCP ports in a CLOSE WAIT state: 4 = 14.81%  
    TCP ports in a TIME WAIT state: 2 = 7.41%  
    
    Port and Module Information by Process
    
    Note: restrictions applied to some processes may
    prevent Portqry from accessing more information
    
    For best results run Portqry in the context of
    the local administrator
    
    ======================================================  
    Process ID: 0 (System Idle Process)
    
    PIDPortLocal IPState Remote IP:Port  
    0TCP 4442 169.254.113.96 TIME WAIT 169.254.5.136:80  
    0TCP 4456 169.254.113.96 TIME WAIT 169.254.5.44:445  
    
    Port Statistics
    
    TCP mappings: 2  
    UDP mappings: 0
    
    TCP ports in a TIME WAIT state: 2 = 100.00%
    
    Could not access module information for this process
    
    ======================================================
    
    Process ID: 4 (System Process)
    
    PIDPortLocal IPState Remote IP:Port  
    4TCP 445 0.0.0.0 LISTENING 0.0.0.0:2160  
    4TCP 139 169.254.113.96 LISTENING 0.0.0.0:24793  
    4TCP 1475 169.254.113.96 ESTABLISHED 169.254.8.176:445  
    4UDP 445 0.0.0.0 :  
    4UDP 137 169.254.113.96 :  
    4UDP 138 169.254.113.96 :  
    
    Port Statistics
    
    TCP mappings: 3  
    UDP mappings: 3
    
    TCP ports in a LISTENING state: 2 = 66.67%  
    TCP ports in a ESTABLISHED state: 1 = 33.33%
    
    Could not access module information for this process
    
    ======================================================
    
    Process ID: 352 (smss.exe)
    
    Process doesn't appear to be a service
    
    Port Statistics
    
    TCP mappings: 0  
    UDP mappings: 0
    
    Loaded modules:  
    \SystemRoot\System32\smss.exe (0x48580000)
    
    C:\WINDOWS\system32\ntdll.dll (0x77F40000)  
    
    ======================================================
    
    Process ID: 484 (lsass.exe)
    
    Service Name: Netlogon  
    Display Name: Net Logon  
    Service Type: shares a process with other services
    
    Service Name: PolicyAgent  
    Display Name: IPSEC Services  
    Service Type: shares a process with other services
    
    Service Name: ProtectedStorage  
    Display Name: Protected Storage
    
    Service Name: SamSs  
    Display Name: Security Accounts Manager  
    Service Type: shares a process with other services
    
    PIDPortLocal IPState Remote IP:Port  
    484TCP 1064 0.0.0.0 LISTENING 0.0.0.0:2064  
    484UDP 500 0.0.0.0 :  
    484UDP 1031 0.0.0.0 :  
    484UDP 4500 0.0.0.0 :
    
    Port Statistics
    
    TCP mappings: 1  
    UDP mappings: 3
    
    TCP ports in a LISTENING state: 1 = 100.00%
    
    Loaded modules:  
    C:\WINDOWS\system32\lsass.exe (0x01000000)  
    C:\WINDOWS\system32\ntdll.dll (0x77F40000)  
    C:\WINDOWS\system32\kernel32.dll (0x77E40000)  
    C:\WINDOWS\system32\ADVAPI32.dll (0x77DA0000)  
    C:\WINDOWS\system32\RPCRT4.dll (0x77C50000)  
    C:\WINDOWS\system32\LSASRV.dll (0x742C0000)  
    C:\WINDOWS\system32\msvcrt.dll (0x77BA0000)  
    C:\WINDOWS\system32\Secur32.dll (0x76F50000)  
    C:\WINDOWS\system32\USER32.dll (0x77D00000)  
    C:\WINDOWS\system32\GDI32.dll (0x77C00000)  
    C:\WINDOWS\system32\SAMSRV.dll (0x741D0000)  
    C:\WINDOWS\system32\cryptdll.dll (0x766E0000)  
    C:\WINDOWS\system32\DNSAPI.dll (0x76ED0000)  
    C:\WINDOWS\system32\WS2_32.dll (0x71C00000)  
    C:\WINDOWS\system32\WS2HELP.dll (0x71BF0000)  
    C:\WINDOWS\system32\MSASN1.dll (0x76190000)  
    C:\WINDOWS\system32\NETAPI32.dll (0x71C40000)  
    C:\WINDOWS\system32\SAMLIB.dll (0x5CCF0000)  
    C:\WINDOWS\system32\MPR.dll (0x71BD0000)  
    C:\WINDOWS\system32\NTDSAPI.dll (0x766F0000)  
    C:\WINDOWS\system32\WLDAP32.dll (0x76F10000)  
    C:\WINDOWS\system32\IMM32.DLL (0x76290000)  
    C:\WINDOWS\system32\LPK.DLL (0x62D80000)  
    
    ======================================================
    
    Process ID: 668 (svchost.exe)
    
    Service Name: RpcSs  
    Display Name: Remote Procedure Call (RPC)  
    Service Type: shares a process with other services
    
    PIDPortLocal IPState Remote IP:Port  
    668TCP 135 0.0.0.0 LISTENING 0.0.0.0:16532
    
    Port Statistics
    
    TCP mappings: 1  
    UDP mappings: 0
    
    TCP ports in a LISTENING state: 1 = 100.00%
    
    Loaded modules:  
    C:\WINDOWS\system32\svchost.exe (0x01000000)  
    C:\WINDOWS\system32\ntdll.dll (0x77F40000)  
    C:\WINDOWS\system32\kernel32.dll (0x77E40000)  
    C:\WINDOWS\system32\ADVAPI32.dll (0x77DA0000)  
    C:\WINDOWS\system32\RPCRT4.dll (0x77C50000)  
    c:\windows\system32\rpcss.dll (0x75700000)  
    C:\WINDOWS\system32\msvcrt.dll (0x77BA0000)  
    c:\windows\system32\WS2_32.dll (0x71C00000)  
    c:\windows\system32\WS2HELP.dll (0x71BF0000)  
    C:\WINDOWS\system32\USER32.dll (0x77D00000)  
    C:\WINDOWS\system32\GDI32.dll (0x77C00000)  
    c:\windows\system32\Secur32.dll (0x76F50000)  
    C:\WINDOWS\system32\IMM32.DLL (0x76290000)  
    C:\WINDOWS\system32\LPK.DLL (0x62D80000)  
    C:\WINDOWS\system32\USP10.dll (0x73010000)  
    C:\WINDOWS\system32\mswsock.dll (0x71B20000)  
    C:\Program Files\Microsoft Firewall Client\wspwsp.dll (0x55600000)  
    C:\WINDOWS\system32\iphlpapi.dll (0x76CF0000)  
    C:\WINDOWS\System32\wshqos.dll (0x57B60000)  
    C:\WINDOWS\system32\wshtcpip.dll (0x71AE0000)  
    C:\WINDOWS\system32\CLBCatQ.DLL (0x76F90000)  
    C:\WINDOWS\system32\OLEAUT32.dll (0x770E0000)  
    C:\WINDOWS\system32\ole32.dll (0x77160000)  
    C:\WINDOWS\system32\COMRes.dll (0x77010000)  
    C:\WINDOWS\system32\VERSION.dll (0x77B90000)  
    C:\WINDOWS\system32\msi.dll (0x76300000)  
    C:\WINDOWS\system32\WTSAPI32.dll (0x76F00000)  
    C:\WINDOWS\system32\WINSTA.dll (0x76260000)  
    C:\WINDOWS\system32\NETAPI32.dll (0x71C40000)  
    C:\WINDOWS\system32\USERENV.dll (0x75970000)  
    
    ========= end of log file =========
    ```

    You can use this information to determine which ports are associated with a particular program or service that's running on the computer. In some cases, Portqry may report that the System Idle process (PID 0) is using some TCP ports. This behavior may occur if a local program connects to a TCP port, and then stops. The program's TCP connection to the port may be left in a "Timed Wait" state even though the program is no longer running. In this case, Portqry may detect that the port is in use. However, Portqry can't identify the program that's using the port because the program has stopped. The PID was released. The port may be in a "Timed Wait" state for several minutes even though the process that was using the port has stopped. By default, the port remains in a "Timed Wait" state for twice as long as the maximum segment lifetime.

- **portqry.exe -wport port_number** (watch port): With the watch port command, PortQry can watch the specified port for changes. These changes may include an increase or decrease in the number of connections to the port or a change in the connection state of any one of the existing connections. For example, you type the following command, and then press Enter: `portqry -wport 53`.

    As a result, PortQry watches TCP and UDP port 53. PortQry reports when any new TCP connections are made to this port. PortQry also reports one or more of the following state changes for the specified TCP port:

    CLOSE_WAIT

    CLOSED

    ESTABLISHED

    FIN_WAIT_1

    LAST_ACK

    LISTEN

    SYN_RECEIVED

    SYN_SEND

    TIMED_WAIT

    For example, if a connection's state changes from ESTABLISHED to CLOSE_WAIT, a change in state has occurred. When the port's state changes, PortQry displays the port's connection table. Portqry reports if a program is bound to the UDP port, but it doesn't report if the UDP port receives datagrams.

    Optional parameters

    - **-v** (verbose): For additional state information, include the **-v** parameter in the PortQry command line. When you use this parameter, PortQry also displays the modules that are using the ports. For example, type `portqry.exe -wport 135 -v`.
    - **-wt** (watch time): By default, PortQry checks for changes in the specified port's connection table one time every 60 seconds. To configure this interval, use the **-wt** parameter. For example, you type the following command, and then press Enter: `portqry.exe -wport 135 -v -wt 2`.

        As a result, PortQry checks TCP port 135 and UDP port 135 for changes every 2 seconds. You can specify a time interval from 1 to 1200 (inclusive). With this parameter, you can watch for changes from every 1 second up to one time every 20 minutes.
    - **-l** (log file): To log the output from the watch port command, use the **-l** parameter. For example, you type the following command, and then press Enter: `portqry.exe -wport 2203 -v -wt 30 -l test.txt`.

        As a result, a log file that's similar to the following log file is generated:

        ```output
        Portqry Version 2.0 Log File
        
        System Date: <DateTime>
        
        Command run:  
        portqry -wport 135 -v -l test.txt
        
        Local computer name:
        
        host123
        
        Watching port: 135
        
        Checking for changes every 60 seconds
        
        verbose output requested
        
        ============  
        System Date: <DateTime>
        
        ======================================================
        
        Process ID: 952 (svchost.exe)
        
        Service Name: RpcSs  
        Display Name: Remote Procedure Call (RPC)  
        Service Type: shares a process with other services
        
        PIDPortLocal IPState Remote IP:Port  
        952TCP 135 0.0.0.0 LISTENING 0.0.0.0:45198  
        952UDP 135 0.0.0.0 :
        
        Port Statistics
        
        TCP mappings: 1  
        UDP mappings: 1
        
        TCP ports in a LISTENING state: 1 = 100.00%
    
        Loaded modules:  
        D:\WINDOWS\system32\svchost.exe (0x01000000)
        
        D:\WINDOWS\System32\ntdll.dll (0x77F50000)  
        D:\WINDOWS\system32\kernel32.dll (0x77E60000)  
        D:\WINDOWS\system32\ADVAPI32.dll (0x77DD0000)  
        D:\WINDOWS\system32\RPCRT4.dll (0x78000000)  
        d:\windows\system32\rpcss.dll (0x75850000)  
        D:\WINDOWS\system32\msvcrt.dll (0x77C10000)  
        d:\windows\system32\WS2_32.dll (0x71AB0000)  
        d:\windows\system32\WS2HELP.dll (0x71AA0000)  
        D:\WINDOWS\system32\USER32.dll (0x77D40000)  
        D:\WINDOWS\system32\GDI32.dll (0x77C70000)  
        d:\windows\system32\Secur32.dll (0x76F90000)  
        D:\WINDOWS\system32\userenv.dll (0x75A70000)  
        D:\WINDOWS\system32\mswsock.dll (0x71A50000)  
        D:\WINDOWS\System32\wshtcpip.dll (0x71A90000)  
        D:\WINDOWS\system32\DNSAPI.dll (0x76F20000)  
        D:\WINDOWS\system32\iphlpapi.dll (0x76D60000)  
        D:\WINDOWS\System32\winrnr.dll (0x76FB0000)  
        D:\WINDOWS\system32\WLDAP32.dll (0x76F60000)  
        D:\WINDOWS\system32\rasadhlp.dll (0x76FC0000)  
        D:\WINDOWS\system32\CLBCATQ.DLL (0x76FD0000)  
        D:\WINDOWS\system32\ole32.dll (0x771B0000)  
        D:\WINDOWS\system32\OLEAUT32.dll (0x77120000)  
        D:\WINDOWS\system32\COMRes.dll (0x77050000)  
        D:\WINDOWS\system32\VERSION.dll (0x77C00000)  
        System Date: <DateTime>
        
        ======================================================
        
        Process ID: 952 (svchost.exe)
        
        Service Name: RpcSs  
        Display Name: Remote Procedure Call (RPC)  
        Service Type: shares a process with other services
        
        PIDPortLocal IPState Remote IP:Port  
        952TCP 135 0.0.0.0 LISTENING 0.0.0.0:45198  
        952UDP 135 0.0.0.0 :  
        952UDP 135 0.0.0.0 :
        
        Port Statistics
        
        TCP mappings: 1  
        UDP mappings: 2
        
        TCP ports in a LISTENING state: 1 = 100.00%  
        Loaded modules:  
        D:\WINDOWS\system32\svchost.exe (0x01000000)  
        D:\WINDOWS\System32\ntdll.dll (0x77F50000)  
        D:\WINDOWS\system32\kernel32.dll (0x77E60000)  
        D:\WINDOWS\system32\ADVAPI32.dll (0x77DD0000)  
        D:\WINDOWS\system32\RPCRT4.dll (0x78000000)  
        d:\windows\system32\rpcss.dll (0x75850000)  
        D:\WINDOWS\system32\msvcrt.dll (0x77C10000)  
        d:\windows\system32\WS2_32.dll (0x71AB0000)  
        d:\windows\system32\WS2HELP.dll (0x71AA0000)  
        D:\WINDOWS\system32\USER32.dll (0x77D40000)  
        D:\WINDOWS\system32\GDI32.dll (0x77C70000)  
        d:\windows\system32\Secur32.dll (0x76F90000)  
        D:\WINDOWS\system32\userenv.dll (0x75A70000)  
        D:\WINDOWS\system32\mswsock.dll (0x71A50000)  
        D:\WINDOWS\System32\wshtcpip.dll (0x71A90000)  
        D:\WINDOWS\system32\DNSAPI.dll (0x76F20000)  
        D:\WINDOWS\system32\iphlpapi.dll (0x76D60000)  
        D:\WINDOWS\System32\winrnr.dll (0x76FB0000)  
        D:\WINDOWS\system32\WLDAP32.dll (0x76F60000)  
        D:\WINDOWS\system32\rasadhlp.dll (0x76FC0000)  
        D:\WINDOWS\system32\CLBCATQ.DLL (0x76FD0000)  
        D:\WINDOWS\system32\ole32.dll (0x771B0000)  
        D:\WINDOWS\system32\OLEAUT32.dll (0x77120000)  
        D:\WINDOWS\system32\COMRes.dll (0x77050000)  
        D:\WINDOWS\system32\VERSION.dll (0x77C00000)  
        
        escape key pressed: stopped watching port 135  
        System Date: <DateTime>
        
        ========= end of log file =========
        ```

- **portqry.exe -wpid process_number** (watch PID): With the watch PID command, PortQry watches the specified process ID (PID) for changes. These changes may include an increase or a decrease in the number of connections to the port or a change in the connection state of any one of the existing connections. This command supports the same optional parameters as the watch port command. For example, you type the following command, and then press Enter: `portqry.exe -wpid 1276 -wt 2 -v -l pid.txt`.  

    As a result, a log file that's similar to the following log file is generated:

    ```output
    PortQry Version 2.0 Log File
    
    System Date: <DateTime>
    
    Command run:  
    portqry -wpid 1276 -wt 2 -v -l pid.txt
    
    Local computer name:
    
    host123
    
    Watching PID: 1276
    
    Checking for changes every 2 seconds
    
    verbose output requested
    
    Service Name: DNS  
    Display Name: DNS Server  
    Service Type: runs in its own process
    
    ============  
    System Date: <DateTime>
    
    ======================================================
    
    Process ID: 1276 (dns.exe)
    
    Service Name: DNS  
    Display Name: DNS Server  
    Service Type: runs in its own process
    
    PIDPortLocal IPState Remote IP:Port  
    1276TCP 53 0.0.0.0 LISTENING 0.0.0.0:2160  
    1276TCP 1087 0.0.0.0 LISTENING 0.0.0.0:37074  
    1276UDP 1086 0.0.0.0 :  
    1276UDP 2126 0.0.0.0 :  
    1276UDP 53 127.0.0.1 :  
    1276UDP 1085 127.0.0.1 :  
    1276UDP 53 169.254.11.96 :
    
    Port Statistics
    
    TCP mappings: 2  
    UDP mappings: 5
    
    TCP ports in a LISTENING state: 2 = 100.00%
    
    Loaded modules:  
    C:\WINDOWS\System32\dns.exe (0x01000000)  
    C:\WINDOWS\system32\ntdll.dll (0x77F40000)  
    C:\WINDOWS\system32\kernel32.dll (0x77E40000)  
    C:\WINDOWS\system32\msvcrt.dll (0x77BA0000)  
    C:\WINDOWS\system32\ADVAPI32.dll (0x77DA0000)  
    C:\WINDOWS\system32\RPCRT4.dll (0x77C50000)  
    C:\WINDOWS\System32\WS2_32.dll (0x71C00000)  
    C:\WINDOWS\System32\WS2HELP.dll (0x71BF0000)  
    C:\WINDOWS\system32\USER32.dll (0x77D00000)  
    C:\WINDOWS\system32\GDI32.dll (0x77C00000)  
    C:\WINDOWS\System32\NETAPI32.dll (0x71C40000)  
    C:\WINDOWS\system32\WLDAP32.dll (0x76F10000)  
    C:\WINDOWS\System32\DNSAPI.dll (0x76ED0000)  
    C:\WINDOWS\System32\NTDSAPI.dll (0x766F0000)  
    C:\WINDOWS\System32\Secur32.dll (0x76F50000)  
    C:\WINDOWS\system32\SHLWAPI.dll (0x77290000)  
    C:\WINDOWS\System32\iphlpapi.dll (0x76CF0000)  
    C:\WINDOWS\System32\MPRAPI.dll (0x76CD0000)  
    C:\WINDOWS\System32\ACTIVEDS.dll (0x76DF0000)  
    C:\WINDOWS\System32\adsldpc.dll (0x76DC0000)  
    C:\WINDOWS\System32\credui.dll (0x76B80000)  
    C:\WINDOWS\system32\SHELL32.dll (0x77380000)  
    C:\WINDOWS\System32\ATL.DLL (0x76A80000)  
    C:\WINDOWS\system32\ole32.dll (0x77160000)  
    C:\WINDOWS\system32\OLEAUT32.dll (0x770E0000)  
    C:\WINDOWS\System32\rtutils.dll (0x76E30000)  
    C:\WINDOWS\System32\SAMLIB.dll (0x5CCF0000)  
    C:\WINDOWS\System32\SETUPAPI.dll (0x765A0000)  
    C:\WINDOWS\system32\IMM32.DLL (0x76290000)  
    C:\WINDOWS\System32\LPK.DLL (0x62D80000)  
    C:\WINDOWS\System32\USP10.dll (0x73010000)  
    C:\WINDOWS\System32\netman.dll (0x76D80000)  
    C:\WINDOWS\System32\RASAPI32.dll (0x76E90000)  
    C:\WINDOWS\System32\rasman.dll (0x76E40000)  
    C:\WINDOWS\System32\TAPI32.dll (0x76E60000)  
    C:\WINDOWS\System32\WINMM.dll (0x76AA0000)  
    C:\WINDOWS\system32\CRYPT32.dll (0x761B0000)  
    C:\WINDOWS\system32\MSASN1.dll (0x76190000)  
    C:\WINDOWS\System32\WZCSvc.DLL (0x76D30000)  
    C:\WINDOWS\System32\WMI.dll (0x76CC0000)  
    C:\WINDOWS\System32\DHCPCSVC.DLL (0x76D10000)  
    C:\WINDOWS\System32\WTSAPI32.dll (0x76F00000)  
    C:\WINDOWS\System32\WINSTA.dll (0x76260000)  
    C:\WINDOWS\System32\ESENT.dll (0x69750000)  
    C:\WINDOWS\System32\WZCSAPI.DLL (0x730A0000)  
    C:\WINDOWS\system32\mswsock.dll (0x71B20000)  
    C:\WINDOWS\System32\wshtcpip.dll (0x71AE0000)  
    C:\WINDOWS\System32\winrnr.dll (0x76F70000)  
    C:\WINDOWS\System32\rasadhlp.dll (0x76F80000)  
    C:\WINDOWS\system32\kerberos.dll (0x71CA0000)  
    C:\WINDOWS\System32\cryptdll.dll (0x766E0000)  
    C:\WINDOWS\system32\msv1_0.dll (0x76C90000)  
    C:\WINDOWS\System32\security.dll (0x71F60000)
    
    escape key pressed: stopped watching PID 1276  
    System Date: <DateTime>
    
    ========= end of log file =========
    ```

    With the `-wport` command, you can watch a single port for changes, but with the `-wpid` command, you can watch all the ports that the specified PID is using for changes. A process may be using many ports, and PortQry watches all of them for changes.

    > [!IMPORTANT]
    > When you use either the `-wport` command or the `-wpid` command together with the logging parameter ( **-l**), you must press the ESC key to stop PortQry for PortQry to correctly close the log file and exit. If you press CTRL+C to stop PortQry instead of ESC, the log file doesn't close correctly. In this scenario, the log file may be empty or corrupted.

## References

For additional information about how to use PortQry, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[310099](https://support.microsoft.com/help/310099) Description of the Portqry.exe command-line utility  

> [!IMPORTANT]
> The PortQueryUI tool provides a graphical user interface and is available for download. PortQueryUI has several features that can make using PortQry easier. To obtain the PortQueryUI tool, visit the following Microsoft Web site:
>
> [https://download.microsoft.com/download/3/f/4/3f4c6a54-65f0-4164-bdec-a3411ba24d3a/PortQryUI.exe](https://download.microsoft.com/download/3/f/4/3f4c6a54-65f0-4164-bdec-a3411ba24d3a/portqryui.exe)
