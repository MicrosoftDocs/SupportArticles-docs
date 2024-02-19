---
title: System event log srv event ID 2012
description: Explains reasons for the system event log srv event ID 2012.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, WalterE
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
---
# Reason for System Event Log srv Event ID: 2012 - While transmitting or receiving data, the server encountered a network error

This article discusses the system event log srv event ID 2012.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2885205

## Summary

Consider the following scenario:

- You have a Windows Server 2012-based file server
- Windows Server 2003, Windows Server 2003 R2, or Microsoft Windows XP Professional-based client computers are accessing the file server with SMB v1 protocol
- or any other SMB v1 protocol-based computer with third-party CIFS implementation is accessing the file server

In this scenario, you see multiple events with Source Srv ID 2012 in the system event log:

> Log Name: System  
Source: srv  
Date: *\<DateTime>*  
Event ID: 2012  
Task Category: None  
Level: Warning  
Keywords: Classic  
User: N/A  
Computer: FILEsrv.fqdn  
Description:  
While transmitting or receiving data, the server encountered a network error. Occasional errors are expected, but large amounts of these indicate a possible error in your network configuration. The error status code is contained within the returned data (formatted as Words) and may point you towards the problem.
>
>\<EventData>  
 \<Data>\Device\LanmanServer\</Data>  
 \<Binary>0000040001002C0000000000DC07008000000000840100C00000000000000000000000000000000034060000\</Binary>  
 \</EventData>
>
> In Words  
0000: 00040000 002C0001 00000000 800007DC  
0008: 00000000 C0000184 00000000 00000000  
0010: 00000000 00000000 00000634

Explanation of these 'Words' logged in this event:  
800007DC = EVENT_SRV_NETWORK_ERROR,  
C0000184 = STATUS_INVALID_DEVICE_STATE, The device is not in a valid state to perform this request.
00000634 hex = 1588 decimal, this points to line 1588 in Windows Server 2012 code for downlevel Clients.  
This number depends on Operating System, Service Pack and possibly on SRV.SYS Hotfix level.

Frequently Asked Questions (FAQ):  
\----------------------------------  
Is such Srv 2012 an indicator for a serious error?  
No this is an event of type WARNING, typically you can ignore it. See below for some typical scenarios, where such Event is expected.  
Administrators should just ignore the warning.

What should a normal SMB communication look like?  
According to CIFS protocol specification ([[MS-CIFS]: Common Internet File System (CIFS) Protocol](https://msdn.microsoft.com/library/ee442092.aspx))  
NEGOTIATE DIALECT - SESSION SETUP - TREE CONNECT - TREE DISCONNECT - LOGOFF

After upgrading our file server to Windows Server 2012 we encounter this Event more often, why?

- you have an environment with many downlevel SMB1 clients like Windows XP or Windows Server 2003.  
Unsuccessfully logon attempts (SESSION SETUP Response with error status) followed by TCP FIN result in Event 2012.  
These clients tend to end their last SMB session with a LOGOFF and TREE DISCONNEcT SMB command, then they terminate the transport session gracefully with a TCP FIN.  
This sequence of SMB commands is not fully CIFS-compliant, see above, resulting in Event 2012.

- you have an environment with some SAMBA / UNIX / MAC based downlevel SMB1 clients.  
These clients often terminate SMB sessions not CIFS conform (omitting a LOGOFF command), resulting in Event 2012.

- downlevel clients with redirected folders on the Windows Server 2012-based file server are disconnected from the network without a proper shutdown.  
The file server sends in such situation TCP KeepAlive packets to inactive clients and resets the TCP transport connection if there is no more response from the client.

- SMB1 clients encounter some network problems (File server is not answering their outstanding SMB command within one minute (SessTimeout = 60 sec), so the client won't send a LOGOFF, but terminates the TCP session with RESET and then establishes a new TCP / SMB session with a new virtual circuit (VcNumber: 0).  
The file server was not aware of the clients network issue and scavenges the former client session as soon as it detects the same SMB1 client IP with SESSION SETUP (VcNumber: 0) coming in.
(this can happen in NAT Scenario for different clients resulting in same IP address in the file server subnet as well)

## More information

For more information about this topic, click the following article number to view the article on the Microsoft Web:

[[MS-CIFS]: Common Internet File System (CIFS) Protocol](/openspecs/windows_protocols/ms-cifs/d416ff7c-c536-406e-a951-4f04b2fd1d2b)
