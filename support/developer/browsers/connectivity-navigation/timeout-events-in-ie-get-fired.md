---
title: The Internet Explorer timeout event is triggered
description: This article describes the operating uptime of the operating system exceeding the tickCount value, a time-out event will be triggered.
ms.date: 06/03/2020
ms.reviewer: heikom
---
# Time-out events in Internet Explorer get fired multiple times when the system uptime is near 49.7 days

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about you clicking on the webpage will cause a time-out event when the uptime of the operating system reaches a predetermined value.

_Original product version:_ &nbsp; Internet Explorer 6, Internet Explorer 7, Internet Explorer 8  
_Original KB number:_ &nbsp; 2655407

## Summary

Internet Explorer 6, Internet Explorer 7, and Internet Explorer 8 may fire additional time-out events when you click on a webpage if the operating system uptime is approximately 49.7 days.

## More information

This behavior occurs because the **tickCount** value of the operating system uptime, which is stored as a **DWORD** value in milliseconds, performs a rollover from `0xFFFFFFFF` to `0x00000000` after approximately 49.7 days. If the time-out event is set to happen after the rollover, during the period of the time-out event and the rollover a click event may trigger an additional time-out event.

After the rollover has been performed, the time-out event is no longer triggered by the click event.

> [!NOTE]
> This behavior does not occur in Internet Explorer 9 or higher.

For more information about GetTickCount, see [GetTickCount function](/windows/win32/api/sysinfoapi/nf-sysinfoapi-gettickcount).
