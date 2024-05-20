---
title: Performance issues after you upgrade DCs
description: Provides a solution to solve performance issues (such as logon delays and Outlook hangs) that occur after you upgrade your Domain Controllers (DCs).
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rolandw, herbertm
ms.custom: sap:Active Directory\LDAP configuration and interoperability, csstroubleshoot
---
# Domain Controller delayed response to LDAP or Kerberos requests

This article provides help to solve performance issues (such as logon delays and Outlook hangs) that occur after you upgrade your Domain Controllers (DCs).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2668820

## Symptoms

After upgrading your DCs, you may be affected by this issue. Possible symptoms are logon delays, Outlook, and other application hangs, increasing Exchange queue.

A more obvious indicator is Event Warning Netlogon 5807 on the slow responding DC with a high number of clients, like the following:

> Event Type: Warning  
Event Source: NETLOGON  
Event Category: None  
Event ID: 5807  
User: N/A  
Computer: \<MyW2k8R2DC1>  
>
> Description:
During the past 4.23 hours, there have been 123450 connections to this Domain Controller from client machines whose IP addresses don't map to any of the existing sites in the enterprise. Those clients, therefore, have undefined sites and may connect to any Domain Controller including those that are in far distant locations from the clients. A client's site is determined by the mapping of its subnet to one of the existing sites. To move the above clients to one of the sites, consider creating subnet object(s) covering the above IP addresses with mapping to one of the existing sites. The names and IP addresses of the clients in question have been logged on this computer in the following log file '%SystemRoot%\debug\netlogon.log' and, potentially, in the log file '%SystemRoot%\debug\netlogon.bak' created if the former log becomes full. The log(s) may contain additional unrelated debugging information. To filter out the needed information, search for lines that contain text'NO_CLIENT_SITE:'. The first word after this string is the client name and the second word is the client IP address. The maximum size of the log(s) is controlled by the following registry DWORD value `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters\LogFileMaxSize`; the default is 20000000 bytes. The current maximum size is 20,000,000 bytes. To set a different maximum size, create the above registry value and set the desired maximum size in bytes.  

## Cause

For site-unmapped Client IPs, a DC performs name resolution, because since Vista and the introduction of IPv6 a client may have multiple IPs. The IP address the client uses during the LDAP UDP Netlogon ping to contact the DC may not be the only one available. If the DC has no subnet configured for this IP, it tries finding a different one having a mapping and would return the according Sitename to the client.

Depending on the Name Resolution mechanism configured on the DC this name resolution may take some seconds. During this time, the LDAP Ping request holds an ATQ Thread from a limited ATQ pool. A high number of such site-unmapped LDAP Pings may saturate this Pool. Since other LDAP and Kerberos request also need this pool, they may be affected as well.

The typical setup when stepping into this issue is a Client- with a trusting Resource Forest, where the Client IP Segments have no Subnet/Site match in the Resource Forest. The Resource Forest DCs may log Event Warning Netlogon 5807 with a high number of clients.

## Resolution

There was an update released that allows turning off this DNS lookup:

[2922852](https://support.microsoft.com/help/2922852)    Update resolves a problem in which LDAP, Kerberos, and DC locator responses are slow or time out with Windows

You may apply the workaround:

- create matching subnet/sites, avoid Netlogon 5807 with a high number of unmapped connections

- increase MaxPoolThreads to 10 (counts per core)
Ref. [315071 How to view and set LDAP policy in Active Directory by using Ntdsutil.exe](https://support.microsoft.com/help/315071)

- optimize DC Name resolution, disable Netbios or use P-Node when WINS is required
Ref. [Chapter 11 - NetBIOS over TCP/IP - Microsoft TechNet: Resources](https://technet.microsoft.com/library/bb727013.aspx)

## More information

ATQ (Active Thread Queue) Performance Counter monitoring:
"Monitoring Your Branch Office Environment", [https://technet.microsoft.com/library/dd736504(WS.10).aspx](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd736504(v=ws.10))
