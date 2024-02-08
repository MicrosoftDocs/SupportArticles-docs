---
title: RemoteFX USB redirected scanner doesn't start
description: Fixes an issue in which RemoteFX USB redirected scanner can't open
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:redirection-not-printer, csstroubleshoot
---
# RemoteFX USB redirected scanner doesn't start  

This article helps to fix an issue in which RemoteFX USB redirected scanner can't open.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 3125295

## Symptoms

Consider the following scenario:
- You prepare a Windows 8.1 Pro x64-based computer as a Remote Desktop (RDP) client and a Windows Server 2012-based or a Windows Server 2012 R2 Datacenter-based server as an RDP server.
- You connect a USB scanner to the Windows 8.1-based computer.
- You install a driver for the scanner on the server.
- On the Windows 8.1-based computer, you enable the **Allow RDP redirection of other supported RemoteFX USB devices from this computer** in the **Computer Configuration\Administrative Templates\Windows Components\Remote Desktop Services\Remote Desktop Connection Client\RemoteFX USB Device Redirection**  Group Policy setting.
- On the Windows Server 2012 R2-based server, you enable the **Remote Desktop Session Host** and **Desktop Experience** features.
- You log on to the RDP session by using RemoteFX USB redirection from the Windows 8.1-based RDP client to the Windows Server 2012 R2-based RDP server.
- In that session, you open the **Devices and Printers** window.
- You right-click the icon for the USB scanner and then click **Start scan**.  

In this scenario, the scan doesn't start, and no error message is displayed.

This issue occurs when the driver calls the CreateFile function without setting the FILE_FLAG_SESSION_AWARE flag. When the issue occurs, the CreateFile function fails with an E_ACCESSDENIED (0x80070005) error.

## Resolution

If you're the driver developer, you should set the FILE_FLAG_SESSION_AWARE flag in the *dwFlagsAndAttributes* parameter of the CreateFile function to fix this issue. Otherwise, you should contact the scanner manufacture for the latest driver that fixes the issue.

## More information

Although RemoteFX USB Redirection for Windows 7 SP1 was implemented for client SKUs with a single session, RemoteFX USB Redirection for Windows Server 2012 R2 supports redirection from multiple clients and provides session isolation for redirected devices. Therefore, users will see only USB devices that belong to them. When USB device redirection is enabled in RDS or MultiPoint, USB devices are assigned to the particular session into which they've been redirected. Only user-mode code that's running in that same session can access these devices.

The default behavior of the I/O Manager is to deny access when a service that's running in session 0 tries to open one of these devices unless the service does this by passing the FILE_FLAG_SESSION_AWARE flag to CreateFile. The theory here is that when developers updated their services to use this flag to open devices, they also added new functionality to make sure that their services restricted access to those devices to any other apps from other sessions that might also be using the service (for example, if the service is a COM server).

## References

[CreateFile function (Windows)](https://msdn.microsoft.com/library/windows/desktop/aa363858%28v=vs.85%29.aspx )
