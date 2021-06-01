---
title: PROCESS1_INITIALIZATION_FAILED stop error after you upgrade to Windows 10 Version 1607
description: Describes an issue that triggers a stop error on a blue screen after you upgrade your system to Windows 10 Version 1607. This issue occurs if you have Hitachi HIBUN installed. Workarounds are provided.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: No Boot (not BugChecks)
ms.technology: windows-client-performance
---
# PROCESS1_INITIALIZATION_FAILED stop error after you upgrade to Windows 10 Version 1607

This article provides a workaround to an issue that triggers a stop error on a blue screen after you upgrade your system to Windows 10 Version 1607.

_Applies to:_ &nbsp; Windows 10, version 1607  
_Original KB number:_ &nbsp; 3083796

## Symptoms  

After you perform an upgrade to Windows 10 Version 1607 from Windows 7, Windows 8, or Windows 8.1, the system fails to start, and you receive a "PROCESS1_INITIALIZATION_FAILED" error message.

## Cause

This issue occurs if you have the HIBUN application from Hitachi installed. Hitachi HIBUN is incompatible with a compression technology in Windows 10 Version 1607. To prevent data corruption, Windows fails to start after a Windows 10 upgrade in this scenario.

## Workaround

To work around this issue, roll back the system to the previous OS, uninstall Hitachi HIBUN, and then upgrade to Windows 10 Version 1607. To do this, follow these steps:

1. Reboot the computer, and wait for the Windows Recovery Environment (WinRE) to start.
2. Click **Troubleshoot**, select **Advanced Options**, and then select **Go back to the previous build**.
3. Uninstall Hitachi HIBUN.
4. Upgrade to Windows 10 Version 1607.

## More Information  

### Third-party information disclaimer

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
