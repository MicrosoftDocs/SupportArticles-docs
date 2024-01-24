---
title: Error 0x000006D9 when you share a printer
description: Provides a solution to an error 0x000006D9 when you try to share a printer on a computer.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-firewall-with-advanced-security-wfas, csstroubleshoot
ms.subservice: networking
---
# Error 0x000006D9 when you try to share a printer on a computer that is running Windows 7 or Windows Server 2008 R2

This article provides a solution to an error 0x000006D9 when you try to share a printer on a computer.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2123653

## Symptoms

When you try to share a printer on a computer that is running Windows 7 or Windows Server 2008 R2, you may receive one of the following error messages.

Error message when you use the Add Printer Wizard to share a printer:

> Windows could not share your printer. Operation could not be completed (Error 0x000006D9)

Error message when you use Printer Properties to share a printer:

> Printer Settings could not be saved. Operation could not be completed (Error 0x000006D9)

When you look up the error code, you discover that there are no endpoints available from the endpoint mapper:

C:\\>err.exe 0x000006d9  
for hex 0x6d9 / decimal 1753  
EPT_S_NOT_REGISTERED winerror.h  
There are no more endpoints available from the endpoint mapper.

## Cause

This issue may occur if you've stopped or disabled the Windows Firewall Service. To share printers in Windows 7 or in Windows Server 2008 R2, you must have the Windows Firewall Service enabled.

## Resolution

To resolve this issue, set the Windows Firewall Service to Automatic, and then start the service.

## More information

This issue occurs because the Spooler service uses the Firewallapi.dll file to make an API call to check the availability of the Windows Firewall service. If sharing is being performed for the first time, the following incoming rules are enabled during this process:

File and Printer Sharing (Spooler Service - RPC-EPMAP)  
File and Printer Sharing (Spooler Service - RPC)  
File and Printer Sharing (Echo Request - ICMPv4-In)  
File and Printer Sharing (Echo Request - ICMPv6-In)  
File and Printer Sharing (LLMNR-UDP-In)  
File and Printer Sharing (NB-Datagram-In)  
File and Printer Sharing (NB-Name-In)  
File and Printer Sharing (NB-Session-In)  
File and Printer Sharing (SMB-In)  

> [!NOTE]
> The same incoming rules are enabled when you share a folder on the computer for the first time.

When the Firewall Service is running, the following registry is checked for the firewall rules:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\FirewallRules`

Similar events are logged when the incoming rule is set. You can see these events in the Applications and Services logs in the Microsoft-Windows-Windows Firewall With Advanced Security log, as follows:

> Log Name: Microsoft-Windows-Windows Firewall With Advanced Security/Firewall  
Source: Microsoft-Windows-Windows Firewall With Advanced Security  
Date: \<*Date*>  
Event ID: 2005  
Task Category: None  
Level: Information  
Keywords: (2199023255552)  
User: LOCAL SERVICE  
Computer: <*ComputerName*>  
Description: A rule has been modified in the Windows Firewall exception list.  
Modified Rule:  
Rule ID: FPS-SpoolSvc-In-TCP-NoScope  
Rule Name: File and Printer Sharing (Spooler Service - RPC)  
Origin: Local  
Active: Yes  
Direction: Inbound  
Profiles: Domain  
Action: Allow  
Application Path: C:\Windows\system32\spoolsv.exe  
Service Name: Spooler  
Protocol: TCP  
Security Options: None  
Edge Traversal: None  
Modifying User: SYSTEM  
Modifying Application: C:\Windows\System32\svchost.exe
>
> Log Name: Microsoft-Windows-Windows Firewall With Advanced Security/Firewall  
Source: Microsoft-Windows-Windows Firewall With Advanced Security  
Date:\<*Date*>  
Event ID: 2005  
Task Category: None  
Level: Information  
Keywords: (2199023255552)  
User: LOCAL SERVICE  
Computer: \<*ComputerName*>  
Description:  
A rule has been modified in the Windows Firewall exception list.  
Modified Rule:  
Rule ID: FPS-RPCSS-In-TCP-NoScope  
Rule Name: File and Printer Sharing (Spooler Service - RPC-EPMAP)  
Origin: Local  
Active: Yes  
Direction: Inbound  
Profiles: Domain  
Action: Allow  
Application Path:  
Service Name: Rpcss  
Protocol: TCP  
Security Options: None  
Edge Traversal: None  
Modifying User: SYSTEM  
Modifying Application: C:\Windows\System32\svchost.exe

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
