---
title: Windows shuts down slowly when it is set to clear the virtual memory pagefile on shutdown
description: This article provides a solution for the issue Windows shuts down slowly when it is set to clear the virtual memory pagefile on shutdown.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:System Performance\Shutdown Performance (slow, unresponsive), csstroubleshoot
---
# Windows shuts down slowly when it is set to clear the virtual memory pagefile on shutdown

This article provides a solution for the issue Windows shuts down slowly when it is set to clear the virtual memory pagefile on shutdown.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 320423

## Symptoms

When the Clear virtual memory pagefile when system shuts down Group Policy setting is turned on in Windows Server 2003 and in later versions, the computer may take longer to shut down than it usually takes. This setting is called Shutdown: Clear virtual memory pagefile in Windows Vista and later versions.

## Cause

This behavior occurs because when this policy setting is turned on, the computer must physically write to each page in the pagefile to clear each page. The period of time that it takes for the system to clear the pagefile varies according to the pagefile size, and the disk hardware that is involved.

## Status

This behavior is by design. 

> [!NOTE]
> This issue also occurs when the Group Policy setting is turned on in Windows XP and in Windows Server 2003.

## More information

By default, the Clear virtual memory pagefile when system shuts down Group Policy setting is turned off. To confirm this setting on Windows 2000, on Windows XP, or on Windows Server 2003, follow these steps:
1. Click **Start**, point to **Settings**, and then click **Control Panel**.
2. Double-click **Administrative Tools**.
3. Double-click **Local Security Policy**.
4. Double-click **Local Policies**.
5. Click **Security Options**.
6. Look in the **Effective Setting** column to the right side of the Clear virtual memory pagefile when system shuts down entry.  

To check this setting on Windows Vista and on later versions, follow these steps:
1. Click **Start**, type secpol.msc, and then press ENTER.
2. Expand **Local Policies**.
3. Click **Security Options**.
4. Look in the **'Security Setting** column to the right side of the Shutdown: Clear virtual memory pagefile entry.
