---
title: DirectAccess network performance in Windows
description: Discuss a performance issue that affects DirectAccess networking.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: delhan, jheath, ajayps, thierdel, mihaipe, alvinm, kaushika
ms.custom: sap:remote-access, csstroubleshoot
---
# DirectAccess network performance in Windows

This article discusses a performance issue that affects DirectAccess networking.

_Applies to:_ &nbsp; Windows 10, version 1809, Windows 10, version 1709, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 4056838

## Symptoms

Consider the following scenario:

- You use DirectAccess with IP-HTTPS or TEREDO to connect to the corporate network.  
- You access and download some files from a corporate network share.  

In this scenario, DirectAccess works correctly. However, you expect better network performance.  

## Workaround

Network performance can be improved by switching to a "Microsoft Always On" virtual private network (VPN).

For a complete feature comparison, see [Always On VPN and DirectAccess Features Comparison](/windows-server/remote/remote-access/vpn/vpn-map-da).
