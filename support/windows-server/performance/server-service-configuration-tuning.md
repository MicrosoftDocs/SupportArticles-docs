---
title: Server service configuration and tuning
description: Describes how to configure and tuning Windows Server service.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: peterlo, kaushika
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# Server service configuration and tuning

This article describes how to configure and tuning Windows Server service.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 128167

## Summary

Although the Windows Server service is self-tuning, it can also be configured manually through Control Panel Service. Normally, the server configuration parameters are auto-configured (calculated and set) each time you boot Windows. However, if you run NET CONFIG SERVER in conjunction with the `/AUTODISCONNECT`, `/SERVCOMMENT` OR `/HIDDEN` switches the current values for the automatically tuned parameters are displayed and written to the registry. Once these parameters are written to the registry, you can't tune the Server service using Control Panel Networks.

If you add or remove system memory, or change the server size setting minimize/balance/maximize), Windows doesn't automatically tune the Server service for your new configuration. For example, if you run `NET CONFIG SRV /SRVCOMMENT`, and then add more memory to the computer, Windows doesn't increase the calculated value of autotuned entries.

Typing NET CONFIG SERVER at the cmd prompt without additional parameters leaves auto tuning intact while displaying useful configuration information about the server.

## More information

The Server service supports information levels that let you set each parameter individually. For example, the command NET CONFIG SRV /HIDDEN uses information level 1016 to set just the hidden parameter. However, NET.EXE queries and sets information levels 102 (hidden, comment, users, and disc parameters) and 502. As a result, all parameters in the information level get permanently set in the Registry. SRVMGR.EXE and the Control Panel Server query and set only level 102 (not level 502) when you change the server comment.

Administrators wishing to hide Windows computers from the browse list or change the autodisconnect value should make those specific changes using REGEDT32.EXE instead of the command-line equivalents discussed above. The server comment can be edited using the description field of the Control Panel Server applet or Server Manager.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To restore the LAN Manager Server parameters to the defaults, or to reconfigure Windows so that it auto-configures the Server service:

1. Run Registry Editor (REGEDT32.EXE).

2. From the HKEY_LOCAL_MACHINE subtree, go to the following key:  
    `\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters`

3. Remove all entries except the following:  
    EnableSharedNetDrives  
    Lmannounce  
    NullSessionPipes  
    NullSessionShares  
    Size  
    > [!NOTE]
    > You may have other entries here that are statically coded. Do not remove these entries.

4. Quit Registry Editor and restart Windows.
