---
title: Configure firewall for AD domain and trusts
description: Describes the ports that are used when you configure a trust relationship between domains.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-domain-or-forest-functional-level-updates, csstroubleshoot
---
# How to configure a firewall for Active Directory domains and trusts

This article describes how to configure a firewall for Active Directory domains and trusts.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 Standard, Windows Server 2012 Standard  
_Original KB number:_ &nbsp; 179442

> [!NOTE]
> Not all the ports that are listed in the tables here are required in all scenarios. For example, if the firewall separates members and DCs, you don't have to open the FRS or DFSR ports. Also, if you know that no clients use LDAP with SSL/TLS, you don't have to open ports 636 and 3269.

## More information

> [!NOTE]
> The two domain controllers are both in the same forest, or the two domain controllers are both in a separate forest. Also, the trusts in the forest are Windows Server 2003 trusts or later version trusts.

|Client Port(s)|Server Port|Service|
|---|---|---|
|1024-65535/TCP|135/TCP|RPC Endpoint Mapper|
|1024-65535/TCP|1024-65535/TCP|RPC for LSA, SAM, NetLogon (*)|
|1024-65535/TCP/UDP|389/TCP/UDP|LDAP|
|1024-65535/TCP|636/TCP|LDAP SSL|
|1024-65535/TCP|3268/TCP|LDAP GC|
|1024-65535/TCP|3269/TCP|LDAP GC SSL|
|53,1024-65535/TCP/UDP|53/TCP/UDP|DNS|
|1024-65535/TCP/UDP|88/TCP/UDP|Kerberos|
|1024-65535/TCP|445/TCP|SMB|
|1024-65535/TCP|1024-65535/TCP|FRS RPC (*)|
  
NetBIOS ports as listed for Windows NT are also required for Windows 2000 and Windows Server 2003 when trusts to domains are configured that support only NetBIOS-based communication. Examples are Windows NT-based operating systems or third-party Domain Controllers that are based on Samba.

For more information about how to define RPC server ports that are used by the LSA RPC services, see:

- [Restricting Active Directory RPC traffic to a specific port](https://support.microsoft.com/help/224196).
- The Domain controllers and Active Directory section in [Service overview and network port requirements for Windows](https://support.microsoft.com/help/832017).

### Windows Server 2008 and later versions

Windows Server 2008 newer versions of Windows Server have increased the dynamic client port range for outgoing connections. The new default start port is 49152, and the default end port is 65535. Therefore, you must increase the RPC port range in your firewalls. This change was made to comply with Internet Assigned Numbers Authority (IANA) recommendations. This differs from a mixed-mode domain that consists of Windows Server 2003 domain controllers, Windows 2000 server-based domain controllers, or legacy clients, where the default dynamic port range is 1025 through 5000.

For more information about the dynamic port range change in Windows Server 2012 and Windows Server 2012 R2, see:

- [The default dynamic port range for TCP/IP has changed](https://support.microsoft.com/help/929851).
- [Dynamic Ports in Windows Server](https://techcommunity.microsoft.com/t5/Ask-the-Directory-Services-Team/Dynamic-Ports-in-Windows-Server-2008-and-Windows-Vista-or-How-I/ba-p/394893).

|Client Port(s)|Server Port|Service|
|---|---|---|
|49152-65535/UDP|123/UDP|W32Time|
|49152-65535/TCP|135/TCP|RPC Endpoint Mapper|
|49152-65535/TCP|464/TCP/UDP|Kerberos password change|
|49152-65535/TCP|49152-65535/TCP|RPC for LSA, SAM, NetLogon (*)|
|49152-65535/TCP/UDP|389/TCP/UDP|LDAP|
|49152-65535/TCP|636/TCP|LDAP SSL|
|49152-65535/TCP|3268/TCP|LDAP GC|
|49152-65535/TCP|3269/TCP|LDAP GC SSL|
|53, 49152-65535/TCP/UDP|53/TCP/UDP|DNS|
|49152-65535/TCP|49152-65535/TCP|FRS RPC (*)|
|49152-65535/TCP/UDP|88/TCP/UDP|Kerberos|
|49152-65535/TCP/UDP|445/TCP|SMB (**)|
|49152-65535/TCP|49152-65535/TCP|DFSR RPC (*)|
  
NetBIOS ports as listed for Windows NT are also required for Windows 2000 and Server 2003 when trusts to domains are configured that support only NetBIOS-based communication. Examples are Windows NT-based operating systems or third-party Domain Controllers that are based on Samba.

(*) For information about how to define RPC server ports that are used by the LSA RPC services, see:

- [Restricting Active Directory RPC traffic to a specific port](https://support.microsoft.com/help/224196).
- The Domain controllers and Active Directory section in [Service overview and network port requirements for Windows](https://support.microsoft.com/help/832017).

(**) For the operation of the trust this port is not required, it is used for trust creation only.

> [!NOTE]
> External trust 123/UDP is only needed if you have manually configured the Windows Time Service to Sync with a server across the external trust.

### Active Directory

The Microsoft LDAP client uses ICMP ping when a LDAP request is pending for extended time and it waits for a response. It sends ping requests to verify the server is still on the network. If it does not receive ping responses, it fails the LDAP request with LDAP_TIMEOUT.

The Windows Redirector also uses ICMP Ping messages to verify that a server IP is resolved by the DNS service before a connection is made, and when a server is located by using DFS. If you want to minimize ICMP traffic, you can use the following sample firewall rule:

> \<any> ICMP -> DC IP addr = allow

Unlike the TCP protocol layer and the UDP protocol layer, ICMP does not have a port number. This is because ICMP is directly hosted by the IP layer.

By default, Windows Server 2003 and Windows 2000 Server DNS servers use ephemeral client-side ports when they query other DNS servers. However, this behavior may be changed by a specific registry setting. Or, you can establish a trust through the Point-to-Point Tunneling Protocol (PPTP) compulsory tunnel. This limits the number of ports that the firewall has to open. For PPTP, the following ports must be enabled.  

|Client Ports|Server Port|Protocol|
|---|---|---|
|1024-65535/TCP|1723/TCP|PPTP|
  
In addition, you would have to enable IP PROTOCOL 47 (GRE).

> [!NOTE]
> When you add permissions to a resource on a trusting domain for users in a trusted domain, there are some differences between the Windows 2000 and Windows NT 4.0 behavior. If the computer cannot display a list of the remote domain's users, consider the following behavior:
>
> - Windows NT 4.0 tries to resolve manually typed names by contacting the PDC for the remote user's domain (UDP 138). If that communication fails, a Windows NT 4.0-based computer contacts its own PDC, and then asks for resolution of the name.
> - Windows 2000 and Windows Server 2003 also try to contact the remote user's PDC for resolution over UDP 138. However, they do not rely on using their own PDC. Make sure that all Windows 2000-based member servers and Windows Server 2003-based member servers that will be granting access to resources have UDP 138 connectivity to the remote PDC.

## Reference

[Service overview and network port requirements for Windows](https://support.microsoft.com/help/832017) is a valuable resource outlining the required network ports, protocols, and services that are used by Microsoft client and server operating systems, server-based programs, and their subcomponents in the Microsoft Windows Server system. Administrators and support professionals may use the article as a roadmap to determine which ports and protocols Microsoft operating systems and programs require for network connectivity in a segmented network.

You should not use the port information in [Service overview and network port requirements for Windows](https://support.microsoft.com/help/832017) to configure Windows Firewall. For information about how to configure Windows Firewall, see [Windows Firewall with Advanced Security](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008).
