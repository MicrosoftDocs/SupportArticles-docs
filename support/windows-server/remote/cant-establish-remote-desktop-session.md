---
title: Can't establish a Remote Desktop session
description: Provides a solution to an error that occurs when you try to connect to the Terminal service running on one of the affected products.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, MVP
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# You can't establish a Remote Desktop session to a computer running one of the affected products

This article provides a solution to an error that occurs when you try to connect to the Terminal service running on one of the affected products.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 555382

## Symptoms

When you try to connect to the Terminal service running on one of the affected products, you receive the following error message:

> Remote Desktop Disconnected  
The client could not connect to the remote computer.  
Remote connections might not be enabled or the computer might be too busy to accept new connections.  
It is also possible that network problems are preventing your connection.  
Please try connecting again later. If the problem continues to occur, contact your administrator.  
OK Help

Additionally, when you view System Event log on the affected server you see the following event:

```output
Event Type: Error  
Event Source: TermService  
Event Category: None  
Event ID: 1036  
Date: <DateTime>  
Time: <DateTime>  
User: N/A  
Computer: Servername  
Description:  
Terminal Server session creation failed. The relevant status code was 0x2740.  
For more information, see Help and Support Center at.
```

## Resolution

To resolve the problem, make sure that the correct network adapter is bound to RDP-TCP connection. To do it, follow these steps:

1. On the server, sign in to the server locally (not using Remote Desktop/Terminal Client).
2. Select **Start**, **Run**, type tscc.msc /s (without quotation marks and select **OK**).
3. In the Terminal Services Configuration snap-in, double-click **Connections**, then **RDP-Tcp** in the right pane.
4. Select the **Network Adapter** tab, select the correct network adapter, and select **OK**.
5. Make sure that you can establish an RDP connection to the server.

Alternative resolution steps.
Use these steps only if you can't do local sign-in to the affected server.

> [!WARNING]
> Using Registry Editor incorrectly may cause serious problems that may require you to reinstall your operating system. Use Registry Editor at your own risk and only after making backup of full Registry and the keys you are going to change.

1. Start Registry Editor (Regedt32.exe).

2. Select **File\Connect network Registry**. Enter computer name or IP address and select **OK**. Firewalls between your computer and the affected server may prevent successful connection. Remote Registry service should be running on the server.

3. Navigate to the following registry key (path may wrap):
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Network\{4D36E972-E325-11CE-BFC1-08002BE10318}`

4. Under this key are one or more keys for the globally unique identifiers (GUIDs) corresponding to the installed LAN connections. Each of these GUID keys has a Connection subkey. Open each of theGUID\Connection keys and look for the Name value. Choose the connection you want Terminal Services to use.

5. When you have found the GUID\Connection key that contains the Name setting that matches the name of your LAN connection, write down or otherwise note the GUID value.

6. Then navigate to the following key:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\lanatable`. Using the GUID you noted in step 5 select subkey. It's LanaId.

7. Navigate to the following value:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\LanAdapter`.  
    Change it's data to the value you noted in step 6. If you want RDP to listen on all LAN adapters enter value of 0.

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#remote-desktop-session).
