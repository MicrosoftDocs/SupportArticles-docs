---
title: How to disable the background save feature
description: Describes how to disable the background save feature in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: luche
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# How to disable the background save feature in Outlook

_Original KB number:_ &nbsp; 319158

## Summary

When you create an email message that has one or more attachments in Microsoft Outlook 2019, Outlook 2016, Outlook 2013, Outlook 2010, or Outlook for Microsoft 365, the attachments are streamed to Microsoft Exchange Server in the background. This background save feature minimizes the time that you have to wait before you can send the message.

In an environment that has a low bandwidth, you can disable the background save feature in these Outlook versions by setting the `DisableBGSave` registry key as follows.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Exit all Microsoft Office applications.
2. Start Registry Editor:

   - In Windows 10, go to **Start**, enter *regedit* in the **Search Windows** box, and then select **regedit.exe** in the search results.
   - In Windows 8 and Windows 8.1, move your mouse to the upper-right corner, select **Search**, type *regedit* in the search text box, and then select **regedit.exe** in the search results.
   - In Windows 7, select **Start**, type *regedit* in the **Search programs and files** text box, and then select **regedit.exe** in the search results.

3. Locate and then select the following registry subkeys:
   - `HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Outlook`
   - `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\xx.0\Outlook`

    > [!NOTE]
    > In this registry path, <xx.0> corresponds to the Outlook version (16.0 = Outlook 2016, Outlook 2019 or Outlook for Microsoft 365, 15.0 = Outlook 2013, 14.0 = Outlook 2010).

4. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
5. Type **DisableBGSave**, and then press Enter.
6. In the **Details** pane, right-click **DisableBGSave**, and then select **Modify**.
7. Select **Hexadecimal** for the base, type *1* in the **Value data** box, and then select **OK**.
8. Exit Registry Editor.
