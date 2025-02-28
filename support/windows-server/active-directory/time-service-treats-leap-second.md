---
title: How Windows Time service treats leap second
description: Describes how the Windows Time service does not include the value of the Leap Indicator when the service receives a packet that includes a leap second.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, RyukiY
ms.custom:
- sap:active directory\windows time service configuration,accuracy,and synchronization
- pcy:WinComm Directory Services
---
# How the Windows Time service treats a leap second

This article describes how the Windows Time service treats a leap second.

_Original KB number:_ &nbsp; 909614

## When the Windows Time service is working as a Network Time Protocol (NTP) client

The Windows Time service does not indicate the value of the Leap Indicator when the Windows Time service receives a packet that includes a leap second. (The Leap Indicator indicates whether an impending leap second is to be inserted or deleted in the last minute of the current day.) Therefore, after the leap second occurs, the NTP client that is running Windows Time service is one second faster than the actual time. This time difference is resolved at the next time synchronization.

For more information about Windows time synchronization, see
 [How the Windows Time Service Works](/previous-versions/windows/it-pro/windows-server-2003/cc773013(v=ws.10)).

## When the Windows Time service is working as an NTP server

No method exists to include a leap second explicitly for the Windows Time service when the service is working as an NTP server.

However, if an external NTP server sends a Leap Indicator that has a value of 01 to the Windows Time service NTP server, the Windows NTP server sends the same value to following NTP client.
