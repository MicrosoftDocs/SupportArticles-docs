---
title: Printing pauses after every 11 print jobs when you use an LPR port
description: Fixes an issue where printing pauses after every 11 print jobs when printing through a line printer remote (LPR) port and event IDs 2004 and 4227 are logged.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-and-troubleshooting:-print-output-or-print-failures, csstroubleshoot
---
# Printing pauses after every 11 print jobs when you use an LPR port

This article helps fix an issue where printing pauses after every 11 print jobs when printing through a line printer remote (LPR) port and event IDs 2004 and 4227 are logged.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2003449

## Symptoms

Printing may pause after every 11 print jobs when you're printing through a line printer remote (LPR) port. When this occurs, the following events are logged in the System log on the server:

Windows Server 2003 Print Server  

> Event Type: Warning  
Event Source: LPR Print Monitor  
Event ID: 2004  
Description: Printer \<Printername> on host \<Host IP/Name> is rejecting our request.  Will retry until it accepts the request or the job is cancelled by the user.  

Windows Server 2008 Print Server

> Log Name:      System  
Source:        Tcpip  
Event ID:      4227  
Task Category: None  
Level:         Warning  
Keywords:      Classic  
User:          N/A  
Description: TCP/IP failed to establish an outgoing connection because the selected local endpoint was recently used to connect to the same remote endpoint. This error typically occurs when outgoing connections are opened and closed at a high rate, causing all available local ports to be used and forcing TCP/IP to reuse a local port for an outgoing connection. To minimize the risk of data corruption, the TCP/IP standard requires a minimum time period to elapse between successive connections from a given local endpoint to a given remote endpoint.  

## Cause

LPR ports use the default LPR RFC source and destination ports (TCP: 721-731, TCP: 515). This makes a total of 11 ports. After these 11 ports are used up, printing will pause until the ports time out and again become available.

## Resolution

We recommend that you use standard TCP\IP ports instead of LPR ports. If you must use LPR ports, you can still use TCP\IP ports. However, you should set them to LPR mode. The following articles describe standard TCP\IP ports in more detail.

[The standard port monitor for TCP/IP in Windows Server 2003](standard-port-monitor-for-tcpip.md)  

To work around the 11-port RFC default for LPR ports, follow these steps:  

 1. Set the following registry key (REG_DWORD):

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\LPDSVC\lpr`  
    Value name: UseNonRFCSourcePorts  
    Value Data: 1  
    Value Type: Binary  
    0 = uses ports 721-731 (default)  
    1 = uses any dynamic port  
 2. Restart the Spooler Service to enable the feature.

## More information

By default, the key isn't present. This limits the number of LPR ports to 11. Setting the registry value to 1 will make the LPD use any port whose number is greater than 1024 to transmit the jobs.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
