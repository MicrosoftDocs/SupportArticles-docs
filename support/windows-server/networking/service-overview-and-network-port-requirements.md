---
title: Service overview and network port requirements
description: A roadmap of ports, protocols, and services that are required by Microsoft client and server operating systems, server-based applications, and their subcomponents to function in a segmented network.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
adobe-target: true
---
# Service overview and network port requirements for Windows

This article discusses the required network ports, protocols, and services that are used by Microsoft client and server operating systems, server-based programs, and their subcomponents in the Microsoft Windows Server system. Administrators and support professionals may use this article as a roadmap to determine which ports and protocols Microsoft operating systems and programs require for network connectivity in a segmented network.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10, version 2004, Windows 10, version 1909, Windows 10, version 1903, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 832017

> [!IMPORTANT]
> This article contains several references to the default dynamic port range. In Windows Server 2008 and later versions, and in Windows Vista and later versions, the default dynamic port range changed to the following range:
>
> - Start port: 49152
> - End port: 65535
>
> Windows 2000, Windows XP, and Windows Server 2003 use the following dynamic port range:
>
> - Start port: 1025
> - End port: 5000
>
> What this means for you:
>
> - If your computer network environment uses only Windows Server 2012 or a later version of Windows, you must enable connectivity over the high port range of 49152 through 65535.
> - If your computer network environment uses Windows Server 2012 together with versions of Windows earlier than Windows Server 2008 and Windows Vista, you must enable connectivity over both the following port ranges:  
> High port range 49152 through 65535  
> Low port range 1025 through 5000
> - If your computer network environment uses only versions of Windows earlier than Windows Server 2008 and Windows Vista, you must enable connectivity over the low port range of 1025 through 5000.
>
> For more information about the default dynamic port range, see [The default dynamic port range for TCP/IP has changed](https://support.microsoft.com/help/929851).

Don't use the port information in this article to configure Windows Firewall. For information about how to configure Windows Firewall, see [Windows Firewall with Advanced Security](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754274(v=ws.11)).

The Windows Server system includes a comprehensive and integrated infrastructure to meet the requirements of developers and information technology (IT) professionals. This system runs programs and solutions that you can use to obtain, analyze, and share information quickly and easily. These Microsoft client, server, and server program products use different network ports and protocols to communicate with client systems and with other server systems over the network. Dedicated firewalls, host-based firewalls, and Internet Protocol security (IPsec) filters are other important components that you must have to help secure your network. However, if these technologies are configured to block ports and protocols that are used by a specific server, that server will no longer respond to client requests.

## Overview

The following list provides an overview of the information that this article contains:

- The [System services ports](#system-services-ports) section:

  - Contains a brief description of each service.
  - Displays the logical name of each service.
  - Indicates the ports and protocols that each service requires for correct operation.

  Use this section to help identify the ports and protocols that a particular service uses.
- The [Ports and protocols](#ports-and-protocols) section includes a table that summarizes the information from the System services ports section. The table is sorted by the port number instead of by the service name. Use this section to quickly determine which services listen on a particular port.

This article uses certain terms in specific ways. To help avoid confusion, make sure that you understand how the article uses these terms:

- System services: System services are programs that load automatically as part of an application's startup process or as part of the operating system startup process. System services support the different tasks that the operating system must perform. For example, some system services that are available on computers that run Windows Server 2003 Enterprise Edition include the Server service, the Print Spooler service, and the World Wide Web Publishing service. Each system service has a _friendly service name_ and a _service name_. The friendly service name is the name that appears in graphical management tools such as the Services Microsoft Management Console (MMC) snap-in. The service name is the name that is used with command-line tools and with many scripting languages. Each system service may provide one or more network services.
- Application protocol: In this article, _application protocol_ refers to a high-level network protocol that uses one or more TCP/IP protocols and ports. Examples of application protocols include HTTP, server message blocks (SMBs), and Simple Mail Transfer Protocol (SMTP).
- Protocol: TCP/IP protocols are standard formats for communicating between devices on a network. TCP/IP protocols operate at a lower level than the application protocols. The TCP/IP suite of protocols includes TCP, User Datagram Protocol (UDP), and Internet Control Message Protocol (ICMP).
- Port: It's the network port that the system service listens on for incoming network traffic.

This article doesn't specify which services rely on other services for network communication. For example, many services rely on the Remote Procedure Call (RPC) or DCOM features in Microsoft Windows to assign them dynamic TCP ports. The Remote Procedure Call service coordinates requests by other system services that use RPC or DCOM to communicate with client computers. Many other services rely on network basic input/output system (NetBIOS) or SMBs, protocols that are provided by the Server service. Other services rely on HTTP or on Hypertext Transfer Protocol Secure (HTTPS). These protocols are provided by Internet Information Services (IIS). A full discussion of the architecture of the Windows operating systems is beyond the scope of this article. However, detailed documentation on this subject is available on Microsoft TechNet and on the Microsoft Developer Network (MSDN) websites. Although many services may rely on a particular TCP or UDP port, only one service or process at a time can listen on that port.

When you use RPC with TCP/IP or with UDP/IP as the transport, incoming ports are frequently dynamically assigned to system services as required. TCP/IP and UDP/IP ports that are higher than port 1024 are used. These ports are also informally known as _random RPC ports_. In these cases, RPC clients rely on the RPC endpoint mapper to tell them which dynamic port or ports were assigned to the server. For some RPC-based services, you can configure a specific port instead of letting RPC dynamically assign a port. You can also restrict the range of ports that RPC dynamically assigns to a small range, regardless of the service. For more information about this topic, see the [References](#references) section.

This article includes information about the system services roles and the server roles for the Microsoft products that are listed in the Applies to section. Although this information may also apply to Windows XP and to Microsoft Windows 2000 Professional, this article is focused on server-class operating systems. Therefore, this article describes the ports that a service listens on instead of the ports that client programs use to connect to a remote system.

## System services ports

This section provides a description of each system service, includes the logical name that corresponds to the system service, and displays the ports and the protocols that each service requires.

### Active Directory (local security authority)

Active Directory runs under the Lsass.exe process and includes the authentication and replication engines for Windows domain controllers. Domain controllers, client computers, and application servers require network connectivity to Active Directory over specific hard-coded ports. Additionally, unless a tunneling protocol is used to encapsulate traffic to Active Directory, a range of ephemeral TCP ports between 1024 to 5000 and 49152 to 65535 are required.

> [!NOTE]
>
> - If your computer network environment uses only Windows Server 2008 R2, Windows Server 2008, Windows 7, Windows Vista or later versions, you must enable connectivity over the high port range of 49152 through 65535.
>
> - If your computer network environment uses Windows Server 2008 R2, Windows Server 2008, Windows 7, Windows Vista or later versions together with versions of Windows earlier than Windows Server 2008 and Windows Vista, you must enable connectivity over both port ranges:  
> High port range of 49152 through 65535  
> Low port range of 1025 through 5000
> - If your computer network environment uses only versions of Windows earlier than Windows Server 2008 and Windows Vista, you must enable connectivity over the low port range of 1025 through 5000.

An encapsulated solution might consist of a VPN gateway located behind a filtering router that uses Layer 2 Tunneling Protocol (L2TP) together with IPsec. In this encapsulated scenario, you must allow the following items through the router instead of opening all the ports and protocols listed in this topic:

- IPsec Encapsulating Security Protocol (ESP) (IP protocol 50)
- IPsec Network Address Translator Traversal NAT-T (UDP port 4500)
- IPsec Internet Security Association and Key Management Protocol (ISAKMP) (UDP port 500)

Finally, you can hard-code the port that is used for Active Directory replication by following the steps in [Restricting Active Directory RPC traffic to a specific port](https://support.microsoft.com/help/224196). System service name: **LSASS**.

> [!NOTE]
> Packet filters for L2TP traffic are not required, because L2TP is protected by IPsec ESP.

|Application protocol|Protocol|Ports|
|---|---|---|
|Active Directory Web Services (ADWS)|TCP|9389|
|Active Directory Management Gateway Service|TCP|9389|
|Global Catalog|TCP|3269|
|Global Catalog|TCP|3268|
|ICMP||No port number|
|Lightweight Directory Access Protocol (LDAP) Server|TCP|389|
|LDAP Server|UDP|389|
|LDAP SSL|TCP|636|
|IPsec ISAKMP|UDP|500|
|NAT-T|UDP|4500|
|RPC|TCP|135|
|RPC randomly allocated high TCP ports¹|TCP|49152 - 65535|
|SMB|TCP|445|
  
¹ For more information about how to customize this port, see Domain controllers and Active Directory in the [References](#references) section. This section also includes remote WMI and DCOM communications first used in Windows Server 2012 domain controller promotion during prerequisite validation and with the Server Manager tool.

In addition, the Microsoft LDAP client uses ICMP pings to verify that an LDAP server it has a pending request with is still present on the network. The following settings are LDAP session options:

- [PingKeepAliveTimeout](/dotnet/api/system.directoryservices.protocols.ldapsessionoptions.pingkeepalivetimeout) = 120 seconds (how long it waits after last response from server before it starts sending ping)
- [PingLimit](/dotnet/api/system.directoryservices.protocols.ldapsessionoptions.pinglimit) = 4 (how many pings are sent before connection is closed)
- [PingWaitTimeout](/dotnet/api/system.directoryservices.protocols.ldapsessionoptions.pingwaittimeout) = 2000 ms (how long it waits for the ICMP response)
- Reference: [LdapSessionOptions Class](/dotnet/api/system.directoryservices.protocols.ldapsessionoptions)

### Application Layer Gateway service

This subcomponent of the Internet Connection Sharing/Internet Connection Firewall (ICF) service provides support for plug-ins that allow network protocols to pass through the firewall and work behind Internet Connection Sharing. Application Layer Gateway (ALG) plug-ins can open ports and change data (such as ports and IP addresses) that are embedded in packets. FTP is the only network protocol that has a plug-in that is included with Windows Server. The ALG FTP plug-in supports active FTP sessions through the network address translation (NAT) engine that these components use. The ALG FTP plug-in supports these sessions by redirecting all traffic that meets the following criteria to a private listening port in the range of 3000 to 5000 on the loopback adapter:

- Passes through the NAT engine
- Is directed toward port 21

The ALG FTP plug-in then monitors and updates FTP control channel traffic so that the FTP plug-in can forward port mappings through the NAT for the FTP data channels. The FTP plug-in also updates ports in the FTP control channel stream.

System service name: **ALG**

|Application protocol|Protocol|Ports|
|---|---|---|
|FTP control|TCP|21|
  
### ASP.NET State Service

ASP.NET State Service provides support for ASP.NET out-of-process session states. ASP.NET State Service stores session data out-of-process. The service uses sockets to communicate with ASP.NET that is running on a web server.

System service name: **aspnet_state**

|Application protocol|Protocol|Ports|
|---|---|---|
|ASP.NET Session State|TCP|42424|
  
### Certificate Services

Certificate Services is part of the core operating system. By using Certificate Services, a business can act as its own certification authority (CA). It lets the business issue and manage digital certificates for programs and protocols such as:

- Secure/Multipurpose Internet Mail Extensions (S/MIME)
- Secure Sockets Layer (SSL)
- Encrypting File System (EFS)
- IPsec
- Smart card logon

Certificate Services relies on RPC and DCOM to communicate with clients by using random TCP ports that are higher than port 1024.

System service name: **CertSvc**

|Application protocol|Protocol|Ports|
|---|---|---|
|RPC|TCP|135|
|SMB|TCP|445, 139|
|Randomly allocated high TCP ports¹|TCP|**random port number between 49152 - 65535**|
  
¹ For more information about how to customize this port, see Remote Procedure Calls and DCOM in the [References](#references) section.

For more information, see [3.2.2.6.2.1.4.5.9 msPKI-Certificate-Name-Flag](/openspecs/windows_protocols/ms-wcce/a1f27ffb-7f74-4fa1-8841-7cde4ba0bcfe).

### Cluster service

The Cluster service controls server cluster operations and manages the cluster database. A cluster is a collection of independent computers that act as a single computer. Managers, programmers, and users see the cluster as a single system. The software distributes data among the nodes of the cluster. If a node fails, other nodes provide the services and data that were formerly provided by the missing node. When a node is added or repaired, the cluster software migrates some data to that node.

System service name: **ClusSvc**

|Application|Protocol|Ports|
|---|---|---|
|Cluster Service|UDP and DTLS¹|3343|
|Cluster Service|TCP|3343 (This port is required during a node join operation.)|
|Cluster Service|ICMP|Echo port (This port is required during a node join operation from the **Add Node Wizard**.)|
|Cluster Service|TCP|445 (This port is required during a node join operation from the **Add Node Wizard**.)|
|RPC|TCP|135|
|Cluster Administrator|UDP|137|
|Randomly allocated high ports²|TCP|Random port number between 49152 and 65535|
  
> [!NOTE]
> Additionally, for successful validation on Windows Failover Clusters on 2008 and above, allow inbound and outbound traffic for ICMP4, ICMP6, and port 445/TCP for SMB.
>
> ¹ Cluster Service UDP traffic over port 3343 requires the Datagram Transport Layer Security (DTLS) protocol, version 1.0 or version 1.2. By default, DTLS is enabled. For more information, see [Protocols in TLS/SSL (Schannel SSP)](/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-).
>
> ² For more information about how to customize these ports, see Remote Procedure Calls and DCOM in the [References](#references) section.

### Computer Browser

The Computer Browser system service maintains an up-to-date list of computers on your network and supplies the list to programs that request it. The Computer Browser service is used by Windows-based computers to view network domains and resources. Computers that are designated as browsers maintain browse lists that contain all shared resources that are used on the network. Earlier versions of Windows-based programs, such as My Network Places, the net view command, and Windows Explorer, all require browsing capability. For example, when you open My Network Places on a computer that is running Microsoft Windows 95, a list of domains and computers appears. To display this list, the computer obtains a copy of the browse list from a computer that is designated as a browser.

If you are running only Windows Vista and later versions of Windows, the browser service is no longer required.

System service name: **Browser**

|Application protocol|Protocol|Ports|
|---|---|---|
|NetBIOS Datagram Service|UDP|138|
|NetBIOS Name Resolution|UDP|137|
|NetBIOS Session Service|TCP|139|
  
The Browser service uses RPC over Named Pipes to compile.

### Dynamic Host Configuration Protocol (DHCP) Server

The DHCP Server service uses the DHCP to automatically allocate IP addresses. You can use this service to adjust the advanced network settings of DHCP clients. For example, you can configure network settings such as Domain Name System (DNS) servers and Windows Internet Name Service (WINS) servers. You can establish one or more DHCP servers to maintain TCP/IP configuration information and to provide that information to client computers.

System service name: **DHCPServer**

|Application protocol|Protocol|Ports|
|---|---|---|
|DHCP Server|UDP|67|
|MADCAP|UDP|2535|
|DHCP Failover|TCP|647|
  
### Distributed File System Namespaces

The Distributed File System Namespaces (DFSN) integrates different file shares that are located on a local area network (LAN) or wide area network (WAN) into a single logical namespace. The DFSN service is required for Active Directory domain controllers to advertise the SYSVOL shared folder.

System service name: `Dfs`

|Application protocol|Protocol|Ports|
|---|---|---|
|NetBIOS Datagram Service|UDP|138<sup>2</sup>|
|NetBIOS Session Service|TCP|139<sup>2</sup>|
|LDAP Server|TCP|389|
|LDAP Server|UDP|389|
|SMB|TCP|445|
|RPC|TCP|135|
|Randomly allocated high TCP ports¹|TCP|**random port number between 49152 - 65535**|
  
¹ For more information about how to customize this port, see Remote Procedure Calls and DCOM in the [References](#references) section.

<sup>2</sup> The NETBIOS ports are optional and are not required when DFSN is using FQDN Server names.

### Distributed File System Replication

The Distributed File System Replication (DFSR) service is a state-based, multi-master file replication engine that automatically copies updates to files and folders between computers that are participating in a common replication group. DFSR was added in Windows Server 2003 R2. You can configure DFSR by using the Dfsrdiag.exe command-line tool to replicate files on specific ports, regardless of whether they are participating in Distributed File System Namespaces (DFSN).

System service name: **DFSR**

|Application protocol|Protocol|Ports|
|---|---|---|
|RPC|TCP|135|
|RPC|TCP|5722<sup>2</sup>|
|Randomly allocated high TCP ports¹|TCP|**random port number between 49152 - 65535**|
  
¹ For more information about how to customize this port, see Distributed File Replication Service in the [References](#references) section.

<sup>2</sup> Port 5722 is only used on a Windows Server 2008 domain controller or on a Windows Server 2008 R2 domain controller. It is not used on a Windows Server 2012 domain controller.

### Distributed Link Tracking Server

The Distributed Link Tracking Server system service stores information so that files that are moved between volumes can be tracked to each volume in the domain. The Distributed Link Tracking Server service runs on each domain controller in a domain. This service enables the Distributed Link Tracking Client service to track linked documents that are moved to a location in another NTFS file system volume in the same domain.

System service name: **TrkSvr**

|Application protocol|Protocol|Ports|
|---|---|---|
|RPC|TCP|135|
|Randomly allocated high TCP ports¹|TCP|**random port number between 49152 - 65535**|
  
¹ For more information about how to customize this port, see Remote Procedure Calls and DCOM in the [References](#references) section.

### Distributed Transaction Coordinator

The Distributed Transaction Coordinator (DTC) system service coordinates transactions that are distributed across multiple computer systems and resource managers, such as databases, message queues, file systems, or other transaction-protected resource managers. The DTC system service is required if transactional components are configured through Component Object Model Plus (COM+). It's also required for transactional queues in Message Queuing (also known as MSMQ) and SQL Server operations that span multiple systems.

System service name: **MSDTC**

|Application protocol|Protocol|Ports|
|---|---|---|
|RPC|TCP|135|
|Randomly allocated high TCP ports¹|TCP|**random port number between 49152 - 65535**|
  
¹ For more information about how to customize this port, see Distributed Transaction Coordinator in the [References](#references) section.

### DNS Server

The DNS Server service enables DNS name resolution by answering queries and update requests for DNS names. DNS servers are required to locate devices and services that are identified by using DNS names and to locate domain controllers in Active Directory.

System service name: **DNS**

|Application protocol|Protocol|Ports|
|---|---|---|
|DNS|UDP|53|
|DNS|TCP|53|
  
### Event Log

The Event Log system service logs event messages that are generated by programs and by the Windows operating system. Event log reports contain information that you can use to diagnose problems. You view reports in Event Viewer. The Event Log service writes events that are sent to log files by programs, by services, and by the operating system. The events contain diagnostic information in addition to errors that are specific to the source program, the service, or the component. The logs can be viewed programmatically through the event log APIs or through the Event Viewer in an MMC snap-in.

System service name: **Eventlog**

|Application protocol|Protocol|Ports|
|---|---|---|
|RPC/named pipes (NP)|TCP|139|
|RPC/NP|TCP|445|
|RPC/NP|UDP|137|
|RPC/NP|UDP|138|
  
> [!NOTE]
> The Event Log service uses RPC over named pipes. This service has the same firewall requirements as the File and Printer Sharing feature.

### Fax Service

Fax Service, a Telephony API (TAPI) compliant system service, provides fax capabilities. Fax Service lets users use either a local fax device or a shared network fax device to send and receive faxes from their desktop programs.

System service name: **Fax**

|Application protocol|Protocol| Ports|
|---|---|---|
|NetBIOS Session Service|TCP|139|
|SMB|TCP|445|
|RPC|TCP|135|
|Randomly allocated high TCP ports¹|TCP|**random port number between 49152 - 65535**|
  
¹ For more information about how to customize this port, see Remote Procedure Calls and DCOM in the [References](#references) section.

### File Replication

The File Replication service (FRS) is a file-based replication engine that automatically copies updates to files and folders between computers that are participating in a common FRS replica set. FRS is the default replication engine that is used to replicate the contents of the SYSVOL folder between Windows 2000-based domain controllers and Windows Server 2003-based domain controllers that are located in a common domain. You can use the DFS Administration tool to configure FRS to replicate files and folders between targets of a DFS root or link.

System service name: **NtFrs**

|Application protocol|Protocol|Ports|
|---|---|---|
|RPC|TCP|135|
|Randomly allocated high TCP ports¹|TCP|**random port number between 49152 - 65535**|
  
¹ For more information about how to customize this port, see File Replication Service in the [References](#references) section.

### FTP Publishing Service

FTP Publishing Service provides FTP connectivity. By default, the FTP control port is 21. However, you can configure this system service through the Internet Information Services (IIS) Manager snap-in. The default data (that is used for active mode FTP) port is automatically set to one port less than the control port. Therefore, if you configure the control port to port 4131, the default data port is port 4130. Most FTP clients use passive mode FTP. This means that the client first connects to the FTP server by using the control port. Next, the FTP server assigns a high TCP port between ports 1025 and 5000. Then, the client opens a second connection to the FTP server for transferring data. You can configure the range of high ports by using the IIS metabase.

System service name: **MSFTPSVC**

|Application protocol|Protocol|Ports|
|---|---|---|
|FTP control|TCP|21|
|FTP default data|TCP|20|
|Randomly allocated high TCP ports|TCP|**random port number between 49152 - 65535** |
  

### Group Policy

To successfully apply Group Policy, a client computer must be able to contact a domain controller over the Kerberos, LDAP, SMB, and RPC protocols. Windows XP and Windows Server 2003 additionally require the ICMP protocol.

If any one of these protocols is unavailable or blocked between the client and a relevant domain controller, Group Policy will not apply or update. For a cross-domain logon, where a computer is in one domain and the user account is in another domain, these protocols may be required for the client, the resource domain, and the account domain to communicate. ICMP is used for slow link detection.

System service name: **Group Policy**

|Application protocol|Protocol|Ports|
|---|---|---|
|DCOM¹|TCP + UDP|**random port number between 49152 - 65535**|
|ICMP (ping)<sup>2</sup>|ICMP|
|LDAP|TCP|389|
|SMB|TCP|445|
|RPC¹|TCP|135<br/>**random port number between 49152 - 65535**|
  
¹ For more information about how to customize this port, see Domain controllers and Active Directory in the [References](#references) section.

<sup>2</sup> This protocol is required only by Windows XP and Windows Server 2003 acting as clients.

> [!NOTE]
> When the Group Policy Microsoft Management Console (MMC) snap-in creates Group Policy Results reports and Group Policy Modeling reports, it uses DCOM and RPC to send and to receive information from the Resultant Set of Policy (RSoP) provider on the client or on the domain controller. The various binary files that make up the Group Policy Microsoft Management Console (MMC) snap-in features primarily use COM calls to send or to receive information. When you initiate remote group policy results reporting from a Windows Server 2012 computer, access to the destination computer's event log is required. (See the [Event Log](#event-log) section in this article for port requirements.)
>
> Windows Server 2012 support the initiation of remote group policy update against Windows Server 2012 computers. This requires RPC/WMI access through port 135 and ports 49152-65535 inbound to the computer on which the policy is being refreshed.

### HTTP SSL

The HTTP SSL system service enables IIS to perform SSL functions. SSL is an open standard for establishing an encrypted communications channel to help prevent the interception of extremely important information, such as credit card numbers. Although this service works on other Internet services, it is primarily used to enable encrypted electronic financial transactions on the World Wide Web (WWW). You can configure the ports for this service through the Internet Information Services (IIS) Manager snap-in.

System service name: **HTTPFilter**

|Application protocol|Protocol|Ports|
|---|---|---|
|HTTPS|TCP|443|
  
### Hyper-V service

Hyper-V replica

|Application protocol|Protocol|Port|
|---|---|---|
|WMI|TCP|135|
|Randomly allocated high TCP ports|TCP|Random port number between 49152 and 65535|
|Kerberos authentication (HTTP)|TCP|80|
|Certificate-based authentication (HTTPS)|TCP|443|
  
Hyper-V live migration

|Application protocol|Protocol| Port|
|---|---|---|
|Live migration|TCP|6600|
|SMB|TCP|445|
|Cluster Service traffic|UDP|3343|
  
### Internet Authentication Service

Internet Authentication Service (IAS) performs centralized authentication, authorization, auditing, and accounting of users who are connecting to a network. These users can be on a LAN connection or on a remote connection. IAS implements the Internet Engineering Task Force (IETF) standard Remote Authentication Dial-In User Service (RADIUS) protocol.

System service name: **IAS**

|Application protocol|Protocol|Ports|
|---|---|---|
|Legacy RADIUS|UDP|1645|
|Legacy RADIUS|UDP|1646|
|RADIUS Accounting|UDP|1813|
|RADIUS Authentication|UDP|1812|
  
### Internet Connection Firewall (ICF)/Internet Connection Sharing

This system service provides NAT, addressing, and name resolution services for all computers on your home network or your small-office network. When the Internet Connection Sharing feature is enabled, your computer becomes an Internet gateway on the network. Other client computers can then share one connection to the Internet, such as a dial-up connection or a broadband connection. This service provides basic DHCP and DNS services but will work with the full-featured Windows DHCP or DNS services. When ICF and Internet Connection Sharing act as a gateway for the rest of the computers on your network, they provide DHCP and DNS services to the private network on the internal network interface. They do not provide these services on the external network interface.

System service name: **SharedAccess**

|Application protocol|Protocol|Ports|
|---|---|---|
|DHCP Server|UDP|67|
|DNS|UDP|53|
|DNS|TCP|53|
  
### IP Address Management (IPAM)

The IPAM client UI communicates with the IPAM server to perform remote management. It's done by using the Windows Communications Framework (WCF), which uses TCP as the transport protocol. By default, the TCP binding is performed on port 48885 on the IPAM server.

#### BranchCache information

- Port 3702 (UDP) is used to discover the availability of cached content on a client.
- Port 80 (TCP) is used to serve content to requesting clients.
- Port 443 (TCP) is the default port that is used by the hosted cache to accept incoming client offers for content.

### ISA/TMG Server

|Application protocol|Protocol|Ports|
|---|---|---|
|Configuration Storage (domain)|TCP|2171 (note 1)|
|Configuration Storage (replication)|TCP|2173 (note 1)|
|Configuration Storage (workgroup)|TCP|2172 (note 1)|
|Firewall Client Application|TCP/UDP|1025-65535 (note 2)|
|Firewall Client Control Channel|TCP/UDP|1745 (note 3)|
|Firewall Control Channel|TCP|3847 (note 1)|
|RPC|TCP|135 (note 6)|
|Randomly allocated high TCP ports (note 6)|TCP|random port number between 1024 - 65535<br/>random port number between 10000 - 65535 (note 7)|
|Web Management|TCP|2175 (note 1, 4)|
|Web Proxy Client|TCP|8080 (note 5)|
  
> [!NOTE]
>
> 1. This port is not used with ISA 2000.
> 2. FWC application transport and protocols are negotiated within the FWC control channel.
> 3. ISA 2000 FWC control uses UDP. ISA 2004 and 2006 use TCP.
> 4. OEM uses Firewall Web Management to provide non-MMC management of ISA Server.
> 5. This port is also used for intra-array traffic.
> 6. This port is used only by the ISA management MMC during remote server and service status monitoring.
> 7. It's the range in TMG. Please note that TMG extends the default dynamic port ranges in Windows Server 2008 R2, Windows 7, Windows Server 2008, and Windows Vista.

### Kerberos Key Distribution Center

When you use the Kerberos Key Distribution Center (KDC) system service, users can sign in to the network by using the Kerberos version 5 authentication protocol. As in other implementations of the Kerberos protocol, the KDC is a single process that provides two services: the Authentication Service and the Ticket-Granting Service. The Authentication Service issues ticket granting tickets, and the Ticket-Granting Service issues tickets for connection to computers in its own domain.

System service name: **kdc**

|Application protocol|Protocol|Ports|
|---|---|---|
|Kerberos|TCP|88|
|Kerberos|UDP|88|
|Kerberos Password V5|UDP|464|
|Kerberos Password V5|TCP|464|
|DC Locator|UDP|389|
  
### License Logging

The License Logging system service is a tool that was originally designed to help customers manage licenses for Microsoft server products that are licensed in the server client access license (CAL) model. License Logging was introduced with Microsoft Windows NT Server 3.51. By default, the License Logging service is disabled in Windows Server 2003. Because of legacy design constraints and evolving license terms and conditions, License Logging may not provide an accurate view of the total number of CALs that are purchased compared to the total number of CALs that are used on a particular server or across the enterprise. The CALs that are reported by License Logging may conflict with the interpretation of the Microsoft Software License Terms and with Product Use Rights (PUR). License Logging is not included in Windows Server 2008 and later operating systems. We recommend that only users of the Microsoft Small Business Server family of operating systems enable this service on their servers.

System service name: **LicenseService**

|Application protocol|Protocol|Ports|
|---|---|---|
|NetBIOS Datagram Service|UDP|138|
|NetBIOS Session Service|TCP|139|
|SMB|TCP|445|
  
> [!NOTE]
> The License Logging service uses RPC over named pipes. This service has the same firewall requirements as the File and Printer Sharing feature.

### Message Queuing

The Message Queuing system service is a messaging infrastructure and development tool for creating distributed messaging programs for Windows. These programs can communicate across heterogeneous networks and can send messages between computers that may be temporarily unable to connect to one another. Message Queuing helps provide security, efficient routing, support for sending messages within transactions, priority-based messaging, and guaranteed message delivery.

System service name: **MSMQ**

|Application protocol|Protocol|Ports|
|---|---|---|
|MSMQ|TCP|1801|
|MSMQ|UDP|1801|
|MSMQ-DCs|TCP|2101|
|MSMQ-Mgmt|TCP|2107|
|MSMQ-Ping|UDP|3527|
|MSMQ-RPC|TCP|2105|
|MSMQ-RPC|TCP|2103|
|RPC|TCP|135|
  
### Microsoft Exchange Message Transfer Agent (MTA) stacks

In Microsoft Exchange 2000 Server and Exchange Server 2003, the MTA is frequently used to provide backward-compatible message transfer services between Exchange 2000 Server-based servers and Exchange Server 5.5-based servers in a mixed-mode environment.

System service name: **MSExchangeMTA**

|Application protocol|Protocol|Ports|
|---|---|---|
|X.400|TCP|102|
  
### Microsoft POP3 service

The Microsoft POP3 service provides email transfer and retrieval services. Administrators can use this service to store and manage email accounts on the mail server. When you install POP3 service on the mail server, users can connect to the mail server and can retrieve email messages by using an email client that supports the POP3 protocol, such as Microsoft Outlook.

System service name: **POP3SVC**

|Application protocol|Protocol|Ports|
|---|---|---|
|POP3|TCP|110|
  
### Net Logon

The Net Logon system service maintains a security channel between your computer and the domain controller to authenticate users and services. It passes the user's credentials to a domain controller and returns the domain security identifiers and the user rights for the user. This is typically known as pass-through authentication. Net Logon is configured to start automatically only when a member computer or domain controller is joined to a domain. In the Windows 2000 Server and Windows Server 2003 families, Net Logon publishes service resource locator records in the DNS. When this service runs, it relies on the WORKSTATION service and on the Local Security Authority service to listen for incoming requests. On domain member computers, Net Logon uses RPC over named pipes. On domain controllers, it uses RPC over named pipes, RPC over TCP/IP, mail slots, and Lightweight Directory Access Protocol (LDAP).

System service name: `Netlogon`

|Application protocol|Protocol|Ports|
|---|---|---|
|NetBIOS Datagram Service|UDP|138<sup>2</sup>|
|NetBIOS Name Resolution|UDP|137<sup>2</sup>|
|NetBIOS Session Service|TCP|139<sup>2</sup>|
|SMB|TCP|445|
|LDAP|UDP|389|
|RPC¹|TCP|135<br/>**random port number between 49152 - 65535**|
  
¹ For more information about how to customize this port, see Domain controllers and Active Directory in the [References](#references) section.

<sup>2</sup> The NETBIOS ports are optional. `Netlogon` uses these only for trusts that don't support DNS or when DNS fails during an attempted fallback. If there is no WINS infrastructure and broadcasts can't work, you should either disable NetBt or set the computers and servers to NodeType=2.

> [!NOTE]
> The Net Logon service uses RPC over named pipes for earlier versions of Windows clients. This service has the same firewall requirements as the File and Printer Sharing feature.
  
### Network News Transfer Protocol (NNTP)

The Network News Transfer Protocol (NNTP) system service lets computers that are running Windows Server 2003 act as news servers. Clients can use a news client, such as Microsoft Outlook Express, to retrieve newsgroups from the server and to read the headers or the bodies of the articles in each newsgroup.

System service name: **NNTPSVC**

|Application protocol|Protocol|Ports|
|---|---|---|
|NNTP|TCP|119|
|NNTP over SSL|TCP|563|
  
### Offline Files, User Profile Service, Folder Redirection, and Primary Computer

Offline Files and Roaming User Profiles cache user data to computers for offline use. These capabilities exist in all supported Microsoft operating systems. Windows XP implemented roaming user profile caching as part of the `Winlogon` process while Windows Vista, Windows Server 2008, and later operating systems use the User Profile Service. All of these systems use SMB.

Folder Redirection redirects user data from the local computer to a remote file share, using SMB.

The Primary Computer system for Windows is part of the Roaming User Profile and Offline Files services. Primary Computer provides a capability to prevent data caching to computers that are not authorized by administrators for specific users. Primary Computer uses LDAP to determine the configuration and does not perform any data transfer using SMB; it instead alters the default Offline Files and Roaming User Profile behaviors. This system was added in Windows Server 2012.

System service names: **ProfSvc**, **CscService**

|Application protocol|Protocol|Ports|
|---|---|---|
|SMB|TCP|445|
|Global Catalog|TCP|3269|
|Global Catalog|TCP|3268|
|LDAP Server|TCP|389|
|LDAP Server|UDP|389|
|LDAP SSL|TCP|636|
  
### Performance Logs and Alerts

The Performance Logs and Alerts system service collects performance data from local or remote computers based on preconfigured schedule parameters and then writes that data to a log or triggers a message. Based on the information that is contained in the named log collection setting, the **Performance Logs and Alerts** service starts and stops each named performance data collection. This service runs only if at least one performance data collection is scheduled.

System service name: **SysmonLog**

|Application protocol|Protocol|Ports|
|---|---|---|
|NetBIOS Session Service|TCP|139|
  
### Print Spooler

The Print Spooler system service manages all local and network print queues and controls all print jobs. Print Spooler is the center of the Windows printing subsystem. It manages the print queues on the system and communicates with printer drivers and input/output (I/O) components, such as the USB port and the TCP/IP protocol suite.

System service name: **Spooler**

|Application protocol|Protocol|Ports|
|---|---|---|
|RPC|TCP|135|
|Randomly allocated high TCP ports¹|TCP|**random port number between 49152 - 65535**|
|NetBIOS Datagram Service|UDP|138|
|NetBIOS Name Resolution|UDP|137|
|NetBIOS Session Service|TCP|139|
|SMB|TCP|445|
  
¹ For more information about how to customize this port, see Remote Procedure Calls and DCOM in the [References](#references) section.
  
> [!NOTE]
> The Print Spooler service uses RPC over named pipes. This service has the same firewall requirements as the File and Printer Sharing feature.

### Remote Installation

You can use the Remote Installation system service to install Windows 2000, Windows XP, and Windows Server 2003 on Pre-Boot Execution Environment (PXE) remote boot-enabled client computers. The Boot Information Negotiation Layer (BINL) service, the primary component of Remote Installation Server (RIS), answers PXE client requests, checks Active Directory for client validation, and passes client information to and from the server. The BINL service is installed when you add the RIS component from Add/Remove Windows Components, or you can select it when you first install the operating system.

System service name: **BINLSVC**

|Application protocol|Protocol|Ports|
|---|---|---|
|BINL|UDP|4011|
  
### Remote Procedure Call (RPC)

The Remote Procedure Call (RPC) system service is an interprocess communication (IPC) mechanism that enables data exchange and invocation of functionality that is located in a different process. The different process can be on the same computer, on the LAN, or in a remote location, and it can be accessed over a WAN connection or over a VPN connection. The RPC service serves as the RPC Endpoint Mapper and Component Object Model (COM) Service Control Manager. Many services depend on the RPC service to start successfully.

System service name: **RpcSs**

|Application protocol|Protocol|Ports|
|---|---|---|
|RPC|TCP|135|
|RPC over HTTPS|TCP|593|
|NetBIOS Datagram Service|UDP|138|
|NetBIOS Name Resolution|UDP|137|
|NetBIOS Session Service|TCP|139|
|SMB|TCP|445|
  
> [!NOTE]
>
> - RPC does not use only the hard-coded ports that are listed in the table. Ephemeral range ports that are used by Active Directory and other components occur over RPC in the ephemeral port range. The ephemeral port range depends on the server operating system that the client operating system is connected to.  
> - The RPC Endpoint Mapper also offers its services by using named pipes. This service has the same firewall requirements as the File and Printer Sharing feature.

### Remote Procedure Call (RPC) Locator

The Remote Procedure Call (RPC) Locator system service manages the RPC name service database. When this service is turned on, RPC clients can locate RPC servers. By default, this service is turned off.

System service name: **RpcLocator**

|Application protocol|Protocol|Ports|
|---|---|---|
|NetBIOS Datagram Service|UDP|138|
|NetBIOS Name Resolution|UDP|137|
|NetBIOS Session Service|TCP|139|
|SMB|TCP|445|
  
> [!NOTE]
> The RPC Locator service offers its services by using RPC over named pipes. This service has the same firewall requirements as the File and Printer Sharing feature.

### Remote Storage Notification

The Remote Storage Notification system service notifies users when they read from or write to files that are available only from a secondary storage media. Stopping this service prevents this notification.

System service name: **Remote_Storage_User_Link**

|Application protocol|Protocol|Ports|
|---|---|---|
|RPC|TCP|135|
|Randomly allocated high TCP ports¹|TCP|**random port number between 49152 - 65535**|
  
¹ For more information about how to customize this port, see Remote Procedure Calls and DCOM in the [References](#references) section.

### Remote Storage

The Remote Storage system service stores infrequently used files on a secondary storage medium. If you stop this service, users cannot move or retrieve files from the secondary storage media.

System service name: **Remote_Storage_Server**

|Application protocol|Protocol|Ports|
|---|---|---|
|RPC|TCP|135|
|Randomly allocated high TCP ports¹|TCP|**random port number between 49152 - 65535**|
  
¹ For more information about how to customize this port, see Remote Procedure Calls and DCOM in the [References](#references) section.

### Routing and Remote Access

The Routing and Remote Access service provides multiprotocol LAN-to-LAN, LAN-to-WAN, VPN, and NAT routing services. The Routing and Remote Access service also provides dial-up and VPN remote access services. Although the Routing and Remote Access service can use all the following protocols, the service typically uses only a few of them. For example, if you configure a VPN gateway that is behind a filtering router, you will probably use only one protocol. If you use L2TP with IPsec, you must allow IPsec ESP (IP protocol 50), NAT-T (UDP on port 4500), and IPsec ISAKMP (UDP on port 500) through the router.

> [!NOTE]
> Although NAT-T and IPsec ISAKMP are required for L2TP, these ports are monitored by the Local Security Authority. For more information about this, see the [References](#references) section.

System service name: **RemoteAccess**

|Application protocol|Protocol|Ports|
|---|---|---|
|GRE (IP protocol 47)|GRE|n/a|
|IPsec AH (IP protocol 51)|AH|n/a|
|IPsec ESP (IP protocol 50)|ESP|n/a|
|L2TP|UDP|1701|
|PPTP|TCP|1723|
  
### Server

The Server system service provides RPC support and file sharing, print sharing, and named pipe sharing over the network. The Server service lets users share local resources, such as disks and printers, so that other users on the network can access them. It also enables named pipe communication between programs that are running on the local computer and on other computers. Named pipe communication is memory that is reserved for the output of one process to be used as input for another process. The input-accepting process does not have to be local to the computer.

> [!NOTE]
> If a computer name resolves to multiple IP addresses by using WINS, or if WINS failed and the name is resolved by using DNS, NetBIOS over TCP/IP (NetBT) tries to ping the IP address or addresses of the file server. Port 139 communications depend on Internet Control Message Protocol (ICMP) echo messages. If IP version 6 (IPv6) is not installed, port 445 communications will also depend on ICMP for name resolution. Preloaded Lmhosts entries will bypass the DNS resolver. If IPv6 is installed on computers that are running Windows Server 2003 or Windows XP operating systems, port 445 communications do not trigger ICMP requests.

The NetBIOS ports that are listed here are optional. Windows 2000 and newer clients can work over port 445.

System service name: **lanmanserver**

|Application protocol|Protocol|Ports|
|---|---|---|
|NetBIOS Datagram Service|UDP|138|
|NetBIOS Name Resolution|UDP|137|
|NetBIOS Session Service|TCP|139|
|SMB|TCP|445|
  
### SharePoint Portal Server

The SharePoint Portal Server system service lets you develop an intelligent portal that seamlessly connects users, teams, and knowledge. It helps people take advantage of relevant information across business processes. Microsoft SharePoint Portal Server 2003 provides an enterprise business solution that integrates information from various systems into one solution through single sign-on and enterprise application integration capabilities.

|Application protocol|Protocol|Ports|
|---|---|---|
|HTTP|TCP|80|
|HTTPS|TCP|443|
  
### Simple Mail Transfer Protocol (SMTP)

The Simple Mail Transfer Protocol (SMTP) system service is an email submission and relay agent. It accepts and queues email messages for remote destinations, and it retries at set intervals. Windows domain controllers use the SMTP service for intersite e-mail-based replication. The Collaboration Data Objects (CDO) for the Windows Server 2003 COM component can use the SMTP service to submit and to queue outgoing email messages.

System service name: **SMTPSVC**

|Application protocol|Protocol|Ports|
|---|---|---|
|SMTP|TCP|25|
  
### Simple TCP/IP Services

Simple TCP/IP Services implements support for the following protocols:

- Echo, port 7, RFC 862
- Discard, port 9, RFC 863
- Character Generator, port 19, RFC 864
- Daytime, port 13, RFC 867
- Quote of the Day, port 17, RFC 865

System service name: **SimpTcp**

|Application protocol|Protocol|Ports|
|---|---|---|
|`Chargen`|TCP|19|
|`Chargen`|UDP|19|
|Daytime|TCP|13|
|Daytime|UDP|13|
|Discard|TCP|9|
|Discard|UDP|9|
|Echo|TCP|7|
|Echo|UDP|7|
|`Quotd`|TCP|17|
|Quoted|UDP|17|
  
### Simple Network Management Protocol (SNMP) Service

SNMP Service lets the local computer service incoming SNMP requests. SNMP Service includes agents that monitor activity in network devices and report to the network console workstation. SNMP Service provides a method of managing network hosts (such as workstation or server computers, routers, bridges, and hubs) from a centrally located computer that is running network management software. SNMP performs management services by using a distributed architecture of management systems and agents.

System service name: **SNMP**

|Application protocol|Protocol|Ports|
|---|---|---|
|SNMP|UDP|161|
  
### SNMP Trap Service

SNMP Trap Service receives trap messages that are generated by local or by remote SNMP agents. Then the SNMP Trap Service forwards those messages to SNMP management programs that are running on your computer. When SNMP Trap Service is configured for an agent, the service generates trap messages if any specific events occur. These messages are sent to a trap destination. For example, an agent can be configured to start an authentication trap if an unrecognized management system sends a request for information. Trap destinations include the computer name, the IP address, or the Internetwork Packet Exchange (IPX) address of the management system. The trap destination must be a network-enabled host that is running SNMP management software.

System service name: **SNMPTRAP**

|Application protocol|Protocol|Ports|
|---|---|---|
|SNMP Traps Outgoing|UDP|162|
  
### Simple Service Discovery Protocol (SSDP) Discovery Service

SSDP Discovery Service implements SSDP as a Windows service. SSDP Discovery Service manages receipt of device presence announcements, updates its cache, and sends these notifications to clients that have outstanding search requests. SSDP Discovery Service also accepts the registration of event callbacks from clients. The registered event callbacks are then turned into subscription requests. SSDP Discovery Service then monitors for event notifications and sends these requests to the registered callbacks. This system service also provides periodic announcements to hosted devices. Currently, the SSDP event notification service uses TCP port 5000.

> [!NOTE]
> Starting with Windows XP Service Pack 2 (SP2), the SSDP event notification service uses TCP port 2869.

System service name: **SSDPRSR**

|Application protocol|Protocol|Ports|
|---|---|---|
|SSDP|UDP|1900|
|SSDP event notification|TCP|2869|
|SSDP legacy event notification|TCP|5000|
  
### TCP/IP Print Server

The TCP/IP Print Server system service enables TCP/IP-based printing by using the Line Printer Daemon (LPD) protocol. The LPD service on the server receives documents from Line Printer Remote (LPR) utilities that are running on UNIX computers.

System service name: **LPDSVC**

|Application protocol|Protocol|Ports|
|---|---|---|
|LPD|TCP|515|
  
### Telnet

The Telnet system service for Windows provides ASCII terminal sessions to Telnet clients. A Telnet server supports two kinds of authentication and supports the following kinds of terminals:

- American National Standards Institute (ANSI)
- VT-100
- VT-52
- VTNT

System service name: **TlntSvr**

| Application protocol| Protocol| Ports |
|---|---|---|
|Telnet|TCP|23|
  
### Remote Desktop Services (RDS)

RDS provides a multi-session environment that enables client devices to access a virtual Windows desktop session and Windows-based programs that are running on the server. RDS enables multiple users to be connected interactively to a computer.

System service name: **TermService**

|Application protocol|Protocol|Ports|
|---|---|---|
|RDS|TCP|3389|
|RDS|UDP|3389|
  
### RDS Licensing (RDSL)

The RDSL system service installs a license server and provides licenses to registered clients when the clients connect to a RDS server (a server that has RDS enabled). RDSL is a low-impact service that stores the client licenses that are issued for a RDS server and tracks the licenses that are issued to client computers or servers.

System service name: **TermServLicensing**

|Application protocol|Protocol|Ports|
|---|---|---|
|RPC|TCP|135|
|Randomly allocated high TCP ports¹|TCP|**random port number between 49152 - 65535**|
|NetBIOS Datagram Service|UDP|138|
|NetBIOS Name Resolution|UDP|137|
|NetBIOS Session Service|TCP|139|
|SMB|TCP|445|
  
¹ For more information about how to customize this port, see Remote Procedure Calls and DCOM in the [References](#references) section.

> [!NOTE]
> RDSL offers its services by using RPC over named pipes. This service has the same firewall requirements as the File and Printer Sharing feature.

### Remote Desktop Connection Broker

The Remote Desktop Connection Broker system service enables clusters of load-balanced RDS servers to correctly route a user's connection request to the server where the user already has a session running. Users are routed to the first-available RDS server regardless of whether they are running another session in the server cluster. The load-balancing functionality pools the processing resources of several servers by using the TCP/IP networking protocol. You can use this service together with a cluster of RDS servers to increase the performance of a single RDS server by distributing sessions across multiple servers. Remote Desktop Connection Broker keeps track of disconnected sessions on the cluster and makes sure that users are reconnected to those sessions.

System service name: **Tssdis**

|Application protocol|Protocol|Ports|
|---|---|---|
|RPC|TCP|135|
|Randomly allocated high TCP ports¹|TCP|**random port number between 49152 - 65535**|
  
¹ For more information about how to customize this port, see Remote Procedure Calls and DCOM in the [References](#references) section.

### Trivial FTP Daemon

The Trivial FTP Daemon system service does not require a user name or a password and is an important part of the Remote Installation Services (RIS). The Trivial FTP Daemon service implements support for the Trivial FTP Protocol (TFTP) that is defined by the following RFCs:

- RFC 1350 - TFTP
- RFC 2347 - Option extension
- RFC 2348 - Block size option
- RFC 2349 - Time-out interval, and transfer size options

Trivial File Transfer Protocol (TFTP) is an FTP that supports diskless startup environments. The TFTP service listens on UDP port 69, but it responds from a randomly allocated high port. Therefore, when you enable this port, the TFTP service receives incoming TFTP requests, but it does not let the selected server respond to those requests. The service is free to respond to any such request from any source port, and the remote client then uses that port during the transfer. Communication is bidirectional. If you have to enable this protocol through a firewall, you may want to open UDP port 69 incoming. You can then rely on other firewall features that dynamically let the service respond through temporary holes on any other port.

System service name: **tftpd**

|Application protocol|Protocol| Ports|
|---|---|---|
|TFTP|UDP|69|
  
### UPnP Device Host

The UPnP Device Host discovery system service implements all the components that are required for device registration, control, and the response to events for hosted devices. The information that is registered that relates to a device, such as the description, the lifetimes, and the containers, are optionally stored to disk and are announced on the network after registration or when the operating system restarts. The service also includes the web server that serves the device in addition to service descriptions and a presentation page.

System service name: **UPNPHost**

|Application protocol|Protocol|Ports|
|---|---|---|
|UPNP|TCP|2869|
  
### Windows Internet Name Service (WINS)

Windows Internet Name Service (WINS) enables NetBIOS name resolution. This service helps you locate network resources by using NetBIOS names. WINS servers are required unless all domains have been upgraded to the Active Directory directory service and unless all computers on the network are running Windows 2000 or later versions. WINS servers communicate with network clients by using NetBIOS name resolution. WINS replication is only required between WINS servers.

System service name: **WINS**

|Application protocol|Protocol|Ports|
|---|---|---|
|NetBIOS Name Resolution|UDP|137|
|WINS Replication|TCP|42|
|WINS Replication|UDP|42|
  
### Windows Media Services

Windows Media Services in Windows Server 2003 and later versions replaces the following services that are included in Windows Media Services versions 4.0 and 4.1:

- Windows Media Monitor Service
- Windows Media Program Service
- Windows Media Station Service
- Windows Media Unicast Service

Windows Media Services is now a single service that runs on Windows Server. Its core components were developed by using COM, and it has a flexible architecture that you can customize for specific programs. Windows Media Services supports a larger variety of control protocols. These include Real Time Streaming Protocol (RTSP), Microsoft Media Server (MMS) protocol, and HTTP.

System service name: `WMServer`

|Application protocol|Protocol|Ports|
|---|---|---|
|HTTP|TCP|80|
|MMS|TCP|1755|
|MMS|UDP|1755|
|MS Theater|UDP|2460|
|RTCP|UDP|5005|
|RTP|UDP|5004|
|RTSP|TCP|554|
  
### Windows Remote Management (WinRM)

System service name: **WinRM**

|Application protocol|Protocol|Ports|
|---|---|---|
|WinRM 1.1 and earlier|TP|The default HTTP port is TCP 80, and the default HTTPS port is TCP 443.|
|WinRM 2.0|TP|The default HTTP port is TCP 5985, and the default HTTPS port is TCP 5986.|
  
For more information, see [Installation and Configuration for Windows Remote Management](/windows/win32/winrm/installation-and-configuration-for-windows-remote-management).

### Windows Time

The Windows Time system service maintains date and time synchronization on all the computers on a network that are running Windows XP or later versions and Windows Server 2003 or later versions. This service uses Network Time Protocol (NTP) to synchronize computer clocks so that an accurate clock value, or time stamp, is assigned for network validation and for resource access requests. The implementation of NTP and the integration of time providers help make Windows Time a reliable and scalable time service for your business. For computers that are not joined to a domain, you can configure Windows Time to synchronize time with an external time source. If this service is turned off, the time setting for local computers is not synchronized with a time service in the Windows domain or with an externally configured time service. Windows Server 2003 uses NTP. NTP runs on UDP port 123. The Windows 2000 version of this service uses Simple Network Time Protocol (SNTP). SNTP also runs on UDP port 123.

When the Windows Time service uses a Windows domain configuration, the service requires domain controller location and authentication services. Therefore, the ports for Kerberos and DNS are required.

System service name: **W32Time**

|Application protocol|Protocol|Ports|
|---|---|---|
|NTP|UDP|123|
|SNTP|UDP|123|
  
### World Wide Web Publishing Service

World Wide Web Publishing Service provides the infrastructure that you must have to register, manage, monitor, and serve websites and programs that are registered with IIS. This system service contains a process manager and a configuration manager. The process manager controls the processes where custom applications and websites reside. The configuration manager reads the stored system configuration for World Wide Web Publishing Service and makes sure that Http.sys is configured to route HTTP requests to the appropriate application pools or operating system processes. You can use the Internet Information Services (IIS) Manager snap-in to configure the ports that are used by this service. If the administrative website is enabled, a virtual website is created that uses HTTP traffic on TCP port 8098.

System service name: **W3SVC**

|Application protocol|Protocol|Ports|
|---|---|---|
|HTTP|TCP|80|
|HTTPS|TCP|443|
  
## Ports and protocols

The following table summarizes the information from the [System services ports](#system-services-ports) section. This table is sorted by port number instead of by service name.

|Port|Protocol|Application protocol|System service name|
|---|---|---|---|
|n/a|GRE|GRE (IP protocol 47)|Routing and Remote Access|
|n/a|ESP|IPsec ESP (IP protocol 50)|Routing and Remote Access|
|n/a|AH|IPsec AH (IP protocol 51)|Routing and Remote Access|
|7|TCP|Echo|Simple TCP/IP Services|
|7|UDP|Echo|Simple TCP/IP Services|
|9|TCP|Discard|Simple TCP/IP Services|
|9|UDP|Discard|Simple TCP/IP Services|
|13|TCP|Daytime|Simple TCP/IP Services|
|13|UDP|Daytime|Simple TCP/IP Services|
|17|TCP|`Quotd`|Simple TCP/IP Services|
|17|UDP|`Quotd`|Simple TCP/IP Services|
|19|TCP|`Chargen`|Simple TCP/IP Services|
|19|UDP|`Chargen`|Simple TCP/IP Services|
|20|TCP|FTP default data|FTP Publishing Service|
|21|TCP|FTP control|FTP Publishing Service|
|21|TCP|FTP control|Application Layer Gateway Service|
|23|TCP|Telnet|Telnet|
|25|TCP|SMTP|Simple Mail Transfer Protocol|
|25|TCP|SMTP|Exchange Server|
|42|TCP|WINS Replication|Windows Internet Name Service|
|42|UDP|WINS Replication|Windows Internet Name Service|
|53|TCP|DNS|DNS Server|
|53|UDP|DNS|DNS Server|
|53|TCP|DNS|Internet Connection Firewall/Internet Connection Sharing|
|53|UDP|DNS|Internet Connection Firewall/Internet Connection Sharing|
|67|UDP|DHCP Server|DHCP Server|
|67|UDP|DHCP Server|Internet Connection Firewall/Internet Connection Sharing|
|69|UDP|TFTP|Trivial FTP Daemon Service|
|80|TCP|HTTP|Windows Media Services|
|80|TCP|HTTP|WinRM 1.1 and earlier|
|80|TCP|HTTP|World Wide Web Publishing Service|
|80|TCP|HTTP|SharePoint Portal Server|
|88|TCP|Kerberos|Kerberos Key Distribution Center|
|88|UDP|Kerberos|Kerberos Key Distribution Center|
|102|TCP|X.400|Microsoft Exchange MTA Stacks|
|110|TCP|POP3|Microsoft POP3 Service|
|110|TCP|POP3|Exchange Server|
|119|TCP|NNTP|Network News Transfer Protocol|
|123|UDP|NTP|Windows Time|
|123|UDP|SNTP|Windows Time|
|135|TCP|RPC|Message Queuing|
|135|TCP|RPC|Remote Procedure Call|
|135|TCP|RPC|Exchange Server|
|135|TCP|RPC|Certificate Services|
|135|TCP|RPC|Cluster Service|
|135|TCP|RPC|Distributed File System Namespaces|
|135|TCP|RPC|Distributed Link Tracking|
|135|TCP|RPC|Distributed Transaction Coordinator|
|135|TCP|RPC|Distributed File Replication Service|
|135|TCP|RPC|Fax Service|
|135|TCP|RPC|Microsoft Exchange Server|
|135|TCP|RPC|File Replication Service|
|135|TCP|RPC|Group Policy|
|135|TCP|RPC|Local Security Authority|
|135|TCP|RPC|Remote Storage Notification|
|135|TCP|RPC|Remote Storage|
|135|TCP|RPC|Systems Management Server 2.0|
|135|TCP|RPC|RDSL|
|135|TCP|RPC|Remote Desktop Connection Broker|
|137|UDP|NetBIOS Name Resolution|Computer Browser|
|137|UDP|NetBIOS Name Resolution|Server|
|137|UDP|NetBIOS Name Resolution|Windows Internet Name Service|
|137|UDP|NetBIOS Name Resolution|Net Logon|
|137|UDP|NetBIOS Name Resolution|Systems Management Server 2.0|
|138|UDP|NetBIOS Datagram Service|Computer Browser|
|138|UDP|NetBIOS Datagram Service|Server|
|138|UDP|NetBIOS Datagram Service|Net Logon|
|138|UDP|NetBIOS Datagram Service|Distributed File System|
|138|UDP|NetBIOS Datagram Service|Systems Management Server 2.0|
|138|UDP|NetBIOS Datagram Service|License Logging Service|
|139|TCP|NetBIOS Session Service|Computer Browser|
|139|TCP|NetBIOS Session Service|Fax Service|
|139|TCP|NetBIOS Session Service|Performance Logs and Alerts|
|139|TCP|NetBIOS Session Service|Print Spooler|
|139|TCP|NetBIOS Session Service|Server|
|139|TCP|NetBIOS Session Service|Net Logon|
|139|TCP|NetBIOS Session Service|Remote Procedure Call Locator|
|139|TCP|NetBIOS Session Service|Distributed File System Namespaces|
|139|TCP|NetBIOS Session Service|Systems Management Server 2.0|
|139|TCP|NetBIOS Session Service|License Logging Service|
|143|TCP|IMAP|Exchange Server|
|161|UDP|SNMP|SNMP Service|
|162|UDP|SNMP Traps Outgoing|SNMP Trap Service|
|389|TCP|LDAP Server|Local Security Authority|
|389|UDP|DC Locator|Local Security Authority|
|389|TCP|LDAP Server|Distributed File System Namespaces|
|389|UDP|DC Locator|Distributed File System Namespaces|
|389|UDP|DC Locator|`Netlogon`|
|389|UDP|DC Locator|Kerberos Key Distribution Center|
|389|TCP|LDAP Server|Distributed File System Replication|
|389|UDP|DC Locator|Distributed File System Replication|
|443|TCP|HTTPS|HTTP SSL|
|443|TCP|HTTPS|World Wide Web Publishing Service|
|443|TCP|HTTPS|SharePoint Portal Server|
|443|TCP|RPC over HTTPS|Exchange Server 2003|
|443|TCP|HTTPS|WinRM 1.1 and earlier|
|445|TCP|SMB|Fax Service|
|445|TCP|SMB|Print Spooler|
|445|TCP|SMB|Server|
|445|TCP|SMB|Remote Procedure Call Locator|
|445|TCP|SMB|Distributed File System Namespaces|
|445|TCP|SMB|Distributed File System Replication|
|445|TCP|SMB|License Logging Service|
|445|TCP|SMB|Net Logon|
|464|UDP|Kerberos Password V5|Kerberos Key Distribution Center|
|464|TCP|Kerberos Password V5|Kerberos Key Distribution Center|
|500|UDP|IPsec ISAKMP|Local Security Authority|
|515|TCP|LPD|TCP/IP Print Server|
|554|TCP|RTSP|Windows Media Services|
|563|TCP|NNTP over SSL|Network News Transfer Protocol|
|593|TCP|RPC over HTTPS endpoint mapper|Remote Procedure Call|
|593|TCP|RPC over HTTPS|Exchange Server|
|636|TCP|LDAP SSL|Local Security Authority|
|636|UDP|LDAP SSL|Local Security Authority|
|647|TCP|DHCP Failover|DHCP Failover|
|9389|TCP|Active Directory Web Services (ADWS)|Active Directory Web Services (ADWS)|
|9389|TCP|Active Directory Web Services (ADWS)|Active Directory Management Gateway Service|
|993|TCP|IMAP over SSL|Exchange Server|
|995|TCP|POP3 over SSL|Exchange Server|
|1067|TCP|Installation Bootstrap Service|Installation Bootstrap protocol server|
|1068|TCP|Installation Bootstrap Service|Installation Bootstrap protocol client|
|1270|TCP|MOM-Encrypted|Microsoft Operations Manager 2000|
|1433|TCP|SQL over TCP|Microsoft SQL Server|
|1433|TCP|SQL over TCP|MSSQL$UDDI|
|1434|UDP|SQL Probe|Microsoft SQL Server|
|1434|UDP|SQL Probe|MSSQL$UDDI|
|1645|UDP|Legacy RADIUS|Internet Authentication Service|
|1646|UDP|Legacy RADIUS|Internet Authentication Service|
|1701|UDP|L2TP|Routing and Remote Access|
|1723|TCP|PPTP|Routing and Remote Access|
|1755|TCP|MMS|Windows Media Services|
|1755|UDP|MMS|Windows Media Services|
|1801|TCP|MSMQ|Message Queuing|
|1801|UDP|MSMQ|Message Queuing|
|1812|UDP|RADIUS Authentication|Internet Authentication Service|
|1813|UDP|RADIUS Accounting|Internet Authentication Service|
|1900|UDP|SSDP|SSDP Discovery Service|
|2101|TCP|MSMQ-DCs|Message Queuing|
|2103|TCP|MSMQ-RPC|Message Queuing|
|2105|TCP|MSMQ-RPC|Message Queuing|
|2107|TCP|MSMQ-Mgmt|Message Queuing|
|2393|TCP|OLAP Services 7.0|SQL Server: Downlevel OLAP Client Support|
|2394|TCP|OLAP Services 7.0|SQL Server: Downlevel OLAP Client Support|
|2460|UDP|MS Theater|Windows Media Services|
|2535|UDP|MADCAP|DHCP Server|
|2701|TCP|SMS Remote Control (control)|SMS Remote Control Agent|
|2701|UDP|SMS Remote Control (control)|SMS Remote Control Agent|
|2702|TCP|SMS Remote Control (data)|SMS Remote Control Agent|
|2702|UDP|SMS Remote Control (data)|SMS Remote Control Agent|
|2703|TCP|SMS Remote Chat|SMS Remote Control Agent|
|2703|UPD|SMS Remote Chat|SMS Remote Control Agent|
|2704|TCP|SMS Remote File Transfer|SMS Remote Control Agent|
|2704|UDP|SMS Remote File Transfer|SMS Remote Control Agent|
|2725|TCP|SQL Analysis Services|SQL Server Analysis Services|
|2869|TCP|UPNP|UPnP Device Host|
|2869|TCP|SSDP event notification|SSDP Discovery Service|
|3268|TCP|Global Catalog|Local Security Authority|
|3269|TCP|Global Catalog|Local Security Authority|
|3343|UDP|Cluster Services|Cluster Service|
|3389|TCP|RDS|RDS|
|3389|UDP|RDS|RDS|
|3527|UDP|MSMQ-Ping|Message Queuing|
|4011|UDP|BINL|Remote Installation|
|4500|UDP|NAT-T|Local Security Authority|
|5000|TCP|SSDP legacy event notification|SSDP Discovery Service|
|5004|UDP|RTP|Windows Media Services|
|5005|UDP|RTCP|Windows Media Services|
|5722|TCP|RPC|Distributed File System Replication|
|6001|TCP|Information Store|Exchange Server 2003|
|6002|TCP|Directory Referral|Exchange Server 2003|
|6004|TCP|DSProxy/NSPI|Exchange Server 2003|
|42424|TCP|ASP.NET Session State|ASP.NET State Service|
|51515|TCP|MOM-Clear|Microsoft Operations Manager 2000|
|5985|TCP|HTTP|WinRM 2.0|
|5986|TCP|HTTPS|WinRM 2.0|
|1024-65535|TCP|RPC|Randomly allocated high TCP ports|
|135|TCP|WMI|Hyper-V service|
|random port number between 49152 - 65535|TCP|Randomly allocated high TCP ports|Hyper-V service|
|80|TCP|Kerberos Authentication (HTTP)|Hyper-V service|
|443|TCP|Certificate-based Authentication (HTTPS)|Hyper-V service|
|6600|TCP|Live Migration|Hyper-V Live Migration|
|445|TCP|SMB|Hyper-V Live Migration|
|3343|UDP|Cluster Service Traffic|Hyper-V Live Migration|

> [!NOTE]
> Port 5722 is only used on a Windows Server 2008 domain controller or a Windows Server 2008 R2 domain controller; it is not used on a Windows Server 2012 domain controller. Port 445 is used by DFSR only when creating a new empty replicated folder.

Microsoft provides part of the information that is in this table in a Microsoft Excel worksheet. This worksheet is available for download from the Microsoft Download Center.

### Active Directory port and protocol requirements

Application servers, client computers, and domain controllers that are located in common or external forests have service dependencies so that user-initiated and computer-initiated operations such as domain join, logon authentication, remote administration, and Active Directory replication work correctly. Such services and operations require network connectivity over specific port and networking protocols.

A summarized list of services, ports, and protocols required for member computers and domain controllers to inter-operate with one another or for application servers to access Active Directory include but are not limited to the following.

The list of services on which Active Directory depends:

- Active Directory / LSA
- Computer Browser
- Distributed File System Namespaces
- Distributed File System Replication (if not using FRS for SYSVOL replication)
- File Replication Service (if not using DFSR for SYSVOL replication)
- Kerberos Key Distribution Center
- Net Logon
- Remote Procedure Call (RPC)
- Server
- Simple Mail Transfer Protocol (SMTP)
- WINS (in Windows Server 2003 SP1 and later versions for backup Active Directory replication operations, if DNS is not working)
- Windows Time
- World Wide Web Publishing Service

The list of services that require Active Directory services:

- Certificate Services (required for specific configurations)
- DHCP Server
- Distributed File System Namespaces (if using domain-based namespaces)
- Distributed File System Replication
- Distributed Link Tracking Server
- Distributed Transaction Coordinator
- DNS Server
- Fax Service
- File Replication Service
- Internet Authentication Service
- License Logging
- Net Logon
- Print Spooler
- Remote Installation
- Remote Procedure Call (RPC) Locator
- Remote Storage Notification
- Remote Storage
- Routing and Remote Access
- Server
- Simple Mail Transfer Protocol (SMTP)
- RDS
- RDSL
- Remote Desktop Connection Broker

## References

The Help files for each Microsoft product that is described in this article contain more information that you may find useful to help configure your programs.

For information about Active Directory Domain Services firewalls and ports, see [How to configure a firewall for Active Directory domains and trusts](https://support.microsoft.com/help/179442).

### General information

For more information about how to help secure Windows Server and for sample IPsec filters for specific server roles, see [Microsoft Security Compliance Manager](/previous-versions/tn-archive/cc677002(v=technet.10)). This tool aggregates all previous security recommendations and security documentation into a single utility for all support Microsoft operating systems:

- [Windows security baselines](/windows/security/threat-protection/windows-security-baselines)
- [Windows Server 2008 R2 Security Baseline](/previous-versions/tn-archive/gg236605(v=technet.10))
- [Windows Server 2008 Security Baseline](/previous-versions/tn-archive/cc514539(v=technet.10))
- [Windows Server 2003 Security Baseline](/previous-versions/tn-archive/cc163140(v=technet.10))
- [Windows 7 Security Baseline](/previous-versions/tn-archive/ee712767(v=technet.10))
- [Windows Vista Security Baseline](/previous-versions/tn-archive/dd450978(v=technet.10))
- [Windows XP Security Baseline](/previous-versions/tn-archive/cc163061(v=technet.10))

For more information about operating system services, security settings, and IPsec filtering, see one of the following Threats and Countermeasures Guides:

- [Threats and Countermeasures Guide: Security Settings in Windows Server 2008 R2 and Windows 7](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh125921(v=ws.10))
- [Threats and Countermeasures Guide: Security Settings in Windows Server 2008 and Windows Vista](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd349791(v=ws.10))
- [Threats and Countermeasures: Security Settings in Windows Server 2003 and Windows XP](/previous-versions/tn-archive/dd162275(v=technet.10))

For more information, see:

- [Network Ports Used by Key Microsoft Server Products](/previous-versions/tn-archive/cc875824(v=technet.10))
- [Active Directory and Active Directory Domain Services Port Requirements](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd772723(v=ws.10)).

The Internet Assigned Numbers Authority coordinates the use of well-known ports. To view this organization's list of TCP/IP port assignments, see [Service Name and Transport Protocol Port Number Registry](https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xml).

### Remote Procedure Calls and DCOM

For a detailed description of RPC, see [Remote Procedure Call (RPC)](/previous-versions/ms950395(v=msdn.10)).

For more information about how to configure RPC to work with a firewall, see [How to configure RPC dynamic port allocation to work with firewalls](https://support.microsoft.com/help/154596).

For more information about the RPC protocol and about how computers that are running Windows 2000 initialize, see [Windows 2000 Startup and Logon Traffic Analysis](/previous-versions/windows/it-pro/windows-2000-server/bb742590(v=technet.10)).

### Domain controllers and Active Directory

For more information about how to restrict Active Directory replication and client logon traffic, see [Restricting Active Directory replication traffic and client RPC traffic to a specific port](https://support.microsoft.com/help/224196).

For an explanation of how the Directory System Agent, LDAP, and the local system authority are related, see [Directory System Agent](/windows/win32/ad/directory-system-agent).

For more information about how LDAP and the global catalog work, see [How the Global Catalog works](/previous-versions/windows/it-pro/windows-server-2003/cc737410(v=ws.10)).

### Exchange Server

For information about ports, authentication, and encryption for all data paths that are used by Microsoft Exchange Server, see [Network ports for clients and mail flow in Exchange](/Exchange/plan-and-deploy/deployment-ref/network-ports).

There may be additional things to consider for your particular environment. You can receive more information and help planning an Exchange implementation from the following Microsoft websites:

- [Exchange Server 2013](/exchange/exchange-server-2013-exchange-2013-help)
- [Exchange Server 2007](/previous-versions/office/exchange-server-2007/bb124558(v=exchg.80))
- [Exchange Server 2003](/previous-versions/tn-archive/bb123872(v=exchg.65))

For more information, see [Configure Outlook Anywhere in Outlook 2013](/previous-versions/office/office-2013-resource-kit/cc179036(v=office.15)).

### Distributed File Replication Service

The Distributed File Replication Service includes the Dfsrdiag.exe command-line tool. Dfsrdiag.exe can set the server RPC port that is used for administration and replication. To use Dfsrdiag.exe to set the server RPC port, follow this example:

> dfsrdiag StaticRPC/port:**nnnnn**/Member:**Branch01.sales.contoso.com**

In this example, **nnnnn** represents a single, static RPC port that DFSR will use for replication. `Branch01.sales.contoso.com` represents the DNS or NetBIOS name of the target member computer. If no member is specified, Dfsrdiag.exe uses the local computer.

### Internet Information Services

For information about ports in IIS 6.0, see [TCP/IP Port Filtering](/previous-versions/windows/it-pro/windows-server-2003/cc779085(v=ws.10)).

For information about FTP, see the following resources:

- [FTP Publishing Service webpage](https://www.iis.net/downloads/microsoft/ftp)
- [Configuring FTP Firewall Support](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd464003(v=ws.10))

### Multicast Address Dynamic Client Allocation Protocol (MADCAP)

For more information about how to plan MADCAP servers, see [Checklist: Installing a MADCAP server](/previous-versions/windows/it-pro/windows-server-2003/cc757948(v=ws.10)).

### Message Queuing

For more information about the ports that are used by Microsoft Message Queuing, see [TCP ports, UDP ports, and RPC ports that are used by Message Queuing](https://support.microsoft.com/help/178517).

### Microsoft Operations Manager

For information about how to plan for and to deploy MOM, see [System Center Developer Documentation Library](/previous-versions/system-center/developer/cc817313(v=msdn.10)).

### RDS

For more information about how to configure the port that is used by RDS, see [Change the listening port for Remote Desktop on your computer](/windows-server/remote/remote-desktop-services/clients/change-listening-port).

### Controlling communications over the Internet in Windows

For more information, see the [Using Windows Server 2003 with Service Pack 1 in a Managed Environment: Controlling Communication with the Internet](/previous-versions/windows/it-pro/windows-server-2003/cc755713(v=ws.10)).

### Windows Media Services

For information about the ports that are used by Windows Media Services, see [Allocating Ports for Windows Media Services](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee126118(v=ws.10)).
