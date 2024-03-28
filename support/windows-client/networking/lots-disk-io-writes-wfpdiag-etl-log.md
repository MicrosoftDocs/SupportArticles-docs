---
title: Port Scanning Prevention Filter behavior in Windows
description: Describes the functionality of the Port Scanning Prevention Filter in Windows Server 2008 and later versions of Windows. Includes a workaround for by-design behavior that generates lots of disk I/O when there's activity in the wfpdiag.etl log.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# Port Scanning Prevention Filter behavior in Windows

This article describes the functionality of the Port Scanning Prevention Filter in Windows Server 2008 and later versions of Windows. It also includes a workaround for the by-design behavior that generates lots of disk I/O when there's activity in the wfpdiag.etl log.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3044882

## Symptoms

Consider the following scenario:

- You have a custom networking application installed on your server.
- The application captures lots of traffic on the wire.
- The server may be using a DHCP-assigned IP address.

In this scenario, a large volume of disk I/O may be generated when writes are made to the C:\\Windows\\System32\\wfp\\wfpdiag.etl log.

## Cause

This behavior is by design. When the Port Scanning Prevention Filter is triggered, this typically means that there's no process listening on the port. (For security reasons, WFP blocks process listening.) When a connection is tried on a port where there's no listener, WFP recognizes the packet as if it was coming from a port scanner and therefore silently drops the connection.

If there had been a listener, and the communication was instead blocked because of either malformed packets or authentication, the dropped event would be listed as "DROP" (not silent), and WFP logging would indicate a different filter ID and name.

This filter is built in to the Windows Firewall and Advanced Security (WFAS). It's included in Windows Vista, Windows Server 2008, and later versions of Windows.

## Workaround

To work around this issue, disable WFP logging by using one of the following methods:

- Disable WFP logging by running the following Netsh command from an elevated command prompt:

    ```console
    netsh wfp set options netevents=off
    ```

- Disable WFP logging in the registry. To do this, follow these steps:

    1. Start Registry Editor.
    2. Locate the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BFE\Parameters\Policy\Options`
    3. Right-click the subkey, click **New**, and then create a DWORD (32-bit) registry value.
    4. Type *CollectNetEvents* as the registry value name.
    5. Leave the value data as 0.
    6. Restart the server.

> [!NOTE]
> By disabling WFP logging, this only stops the logging of WFP activity in wfpdiag.etl. The Port Scanning Prevention Filter continues to work normally.

## More information

For more information, see [Stealth mode in Windows Firewall with Advanced Security](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd448557(v=ws.10)).
