---
title: Large Publisher files open in read-only mode in SharePoint
description: Describes an issue in which large Publisher files that are more than 50 MB open in read-only mode and can't be directly edited.
author: helenclu
ms.author: luche
ms.reviewer: warrenr
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: sap:spsexperts, CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server 2013
  - Publisher 2013
ms.date: 12/17/2023
---

# Large Publisher files open in read-only mode

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

In SharePoint Online or SharePoint Server 2013, large Publisher files that are more than 50 megabytes (MB) open in read-only mode and can't be directly edited. To edit the files, you must first save them locally, and then manually upload them after you complete the edit.

## Cause

Publisher 2013 relies on the **Web Client** local service that has a default limit of 50 MB.

## Workaround

To work around this issue, set the **FileSizeLimitInBytes** registry key to a value more than **50**. To do this, follow these steps:

**Important**

Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/en-us/help/322756) in case problems occur.

1. Exit all Microsoft Office applications.
1. Start Registry Editor:
   - In Windows 10, go to **Start**, enter **regedit** in the **Search box**, and then select **regedit.exe** in the search results.
   - In Windows 8 or Windows 8.1, move your mouse to the upper-right corner, select **Search**, enter **regedit** in the search box, and then select **regedit.exe** in the search results.
   - In Windows 7, select **Start**, enter **regedit** in the **Start Search** box, and then select **regedit.exe** in the search results.
1. Locate and select the following registry key:

   **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WebClient\Parameters\FileSizeLimitInBytes**

1. Right-click **FileSizeLimitInBytes**, and select **Modify**.
1. In the **Edit DWORD (32-bit) Value** dialog box, select the **Decimal** option, type a decimal value in the **Value data** box, and then click **OK**. For example, to limit the file size to 200 MB, type 200000000 for **Value data**.
