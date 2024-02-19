---
title: Fail to log on to a terminal server
description: Describes a problem that may occur if many users are logged on to the terminal server. To resolve this problem, modify the registry to increase the PoolUsageMaximum value and the PagedPoolSize value.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
---
# Error message when you try to log on to a Windows Server 2003-based terminal server: Windows cannot load the user's profile but has logged you on with the default profile for the system

This article provides a solution to an issue that occurs when you log on to a Windows Server 2003-based terminal server.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 935649

## Symptoms

When you try to log on to a Microsoft Windows Server 2003-based terminal server, you receive the following error message:  
> Windows cannot load the user's profile but has logged you on with the default profile for the system.
>
> Detail: Insufficient system resources exist to complete the requested service.  

When this problem occurs, the following events are logged in the Application log on the terminal server.

> Event ID 1505

> Event ID 1508

### Cause

You experience this problem if many users are logged on to the terminal server.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To resolve this problem, modify the registry to increase the PoolUsageMaximum value and the PagedPoolSize value. To do this, follow these steps:

1. Click **Start**, click **Run**, type regedit, and then click **OK**.
2. Locate and then click the following registry subkey:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management`  

3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. In the **New Value #1** box, type PoolUsageMaximum, and then press ENTER.
5. Right-click **PoolUsageMaximum**, and then click **Modify**.
6. In the **Value data** box, type 60, click **Decimal**, and then click **OK**.
7. If the PagedPoolSize registry entry exists, go to step 8. If the PagedPoolSize registry entry does not exist, create it. To do this, follow these steps:
   1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
   2. In the **New Value #1** box, type PagedPoolSize, and then press ENTER.
8. Right-click **PagedPoolSize**, and then click **Modify**.
9. In the **Value data** box, type ffffffff, and then click **OK**.
10. Exit Registry Editor, and then restart the computer.

## More information

For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[312362](https://support.microsoft.com/help/312362) Server is unable to allocate memory from the system paged pool  

### Did this fix the problem

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus/).  
