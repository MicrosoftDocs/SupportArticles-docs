---
title: Disconnect incoming VPN connection
description: Describes how to disconnect an incoming VPN connection when an option to disconnect the incoming VPN connection is not displayed in the View Available Networks dialog box.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, tiquinn, qianyu
ms.custom: sap:remote-access, csstroubleshoot
---
# How to disconnect an incoming VPN connection

This article describes how to disconnect an incoming VPN connection when an option to disconnect the incoming VPN connection is not displayed in the View Available Networks dialog box.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2737610

> [!NOTE]
> When you right-click an incoming VPN connection in Windows Server 2012 and then click **Connect/Disconnect**, the **View Available Networks**  dialog box appears. However, an option to disconnect the incoming VPN connection is not displayed.  

## More information

To disconnect an incoming VPN connection, follow these steps:  

1. Open Network Connections. To do this, use either of the following methods:
   - Swipe in from the right edge of the screen, or point to the lower-right corner of the screen, and then click **Search.** Then, type ncpa.cpl, and then click the **Ncpa.cpl** icon.

   - Press Win+R to open the **Run** window, type ncpa.cpl, and then click **OK**.

2. Right-click the incoming VPN connection that you want to disconnect, and then click **Status**.

3. On the **General** tab, click **Disconnect**.

4. Close Network Connections.
