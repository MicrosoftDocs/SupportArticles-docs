---
title: How Windows Time service treats leap second
description: Describes how the Windows Time service does not include the value of the Leap Indicator when the service receives a packet that includes a leap second.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, RyukiY
ms.custom: sap:windows-time-service, csstroubleshoot
ms.subservice: active-directory
---
# How the Windows Time service treats a leap second

This article describes how the Windows Time service treats a leap second.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 909614

## When the Windows Time service is working as a Network Time Protocol (NTP) client

The Windows Time service does not indicate the value of the Leap Indicator when the Windows Time service receives a packet that includes a leap second. (The Leap Indicator indicates whether an impending leap second is to be inserted or deleted in the last minute of the current day.) Therefore, after the leap second occurs, the NTP client that is running Windows Time service is one second faster than the actual time. This time difference is resolved at the next time synchronization.

For more information about Windows time synchronization, see
 [How the Windows Time Service Works](/previous-versions/windows/it-pro/windows-server-2003/cc773013(v=ws.10)).

## When the Windows Time service is working as an NTP server

No method exists to include a leap second explicitly for the Windows Time service when the service is working as an NTP server.

However, if an external NTP server sends a Leap Indicator that has a value of 01 to the Windows Time service NTP server, the Windows NTP server sends the same value to following NTP client.
