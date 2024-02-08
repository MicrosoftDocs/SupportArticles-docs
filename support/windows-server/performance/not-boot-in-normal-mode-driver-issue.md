---
title: Not Boot In Normal Mode
description: Provides some information about Windows does not boot in Normal Mode due to a driver issue.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
ms.subservice: performance
---
# Not boot in Normal Mode - driver issue

This article provides some information about Windows does not boot in Normal Mode due to a driver issue.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 555996

This article was written by [`Nirmal Sharma`](https://mvp.microsoft.com/en-US/PublicProfile/33635), Microsoft MVP.

## Summary

This article explains a situation when Windows doesn't boot in Normal Mode because of a driver issue.  

## More information

The problem might be either with Windows Driver or Third-Party applications. In 99 cases, the problem is with any third-party driver that is causing this problem. If Windows is not booting into Normal Mode, but booting successfully in either Safe Mode or Safe Mode With Networking, then you can follow below steps outlined to make Windows to run in Normal Mode.

- Go to Safe Mode.
- Start Registry editor > navigate to the following registry key:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal`  

- Save or Export this key to SafeBoot.reg file.
- Next navigate to the following key:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services`  

- Save or Export it to Services.reg.
- Now edit SafeBoot.reg in notepad (make sure you disable word wrapping).
- Find all the entries with:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal`  

- and replace all with the following key:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services`  

- After replacing all entries, save SafeBoot.reg file and double-click on it.
- Now restart your computer in Normal Mode.  

> [!Note]
> Editing registry is not recommended by users only experienced administrators should edit the registry.

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
