---
title: Error when establishing a VPN connection
description: Provides a solution to an Error 721 that occurs when try to establish a VPN connection through your Windows Server-based remote access server.
ms.date: 09/18/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-access, csstroubleshoot
ms.subservice: networking
---
# You receive an "Error 721" error message when you try to establish a VPN connection through your Windows Server-based remote access server

This article provides a solution to an Error 721 that occurs when try to establish a VPN connection through your Windows Server-based remote access server.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 888201

## Symptoms

If you try to establish a virtual private network (VPN) connection to a corporate network by using a Point-to-Point Tunneling Protocol (PPTP) client, the connection to the Microsoft Windows Server-based remote access server may not succeed. You may receive the following error message:

> Error 721: The remote computer is not responding.

> [!NOTE]
> The 721 error description may vary.

## Cause

This issue may occur if the network firewall does not permit Generic Routing Encapsulation (GRE) protocol traffic. GRE is IP Protocol 47. PPTP uses GRE for tunneled data.

## Resolution

To resolve this issue, configure the network firewall to permit GRE protocol 47. Also, make sure that the network firewall permits TCP traffic on port 1723. Both of these conditions must be met to establish VPN connectivity by using PPTP.

## More information

For more information about installing and configuring a VPN Server in Windows Server 2003, click the following article number to view the article in the Microsoft Knowledge Base:

[323441](https://support.microsoft.com/help/323441) How to install and configure a Virtual Private Network server in Windows Server 2003  

For more information about the PPTP protocol, visit the following Microsoft Web site: [https://technet.microsoft.com/library/bb877963.aspx](https://technet.microsoft.com/library/bb877963.aspx)
