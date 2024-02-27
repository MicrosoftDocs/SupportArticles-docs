---
title: How to reset location list for appointments or meetings
description: Discusses how to reset the location list for appointments or meetings in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: CHRISBUR
appliesto: 
  - Outlook
search.appverid: MET150
ms.date: 01/30/2024
---
# How to reset location list for appointments or meetings

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

_Original KB number:_ &nbsp; 300579

## Summary

This article discusses how to reset the **Location** field in an appointment item or in a meeting request in Microsoft Outlook.

## More information

Appointment items and meeting requests in Outlook have a **Location** field. This field contains a list of entries that you previously entered. The list may become fairly large and may contain outdated locations. Therefore, you may find it necessary to purge the entries from the list.

To reset the list by deleting the registry subkey entry, follow these steps.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Select **Start**, point to **Run**, and then type *regedit*.
2. Find the `LocationMRU` entry under the following registry subkey, as appropriate for the version of Microsoft Windows that you are running:

    Outlook 2007: `HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Outlook\Preferences`  
    Outlook 2003: `HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Outlook\Preferences`  
    Outlook XP: `HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Outlook\Preferences`

3. On the **Edit** menu, select **Delete**.

If you delete the registry subkey entry, and then create an appointment or a meeting request with a value in the **Location** field, the `LocationMRU` entry is recreated.

> [!NOTE]
> There is not a supported method to modify single entries in the list of entries. You must delete the entire registry subkey entry for the registry subkey entry to be recreated correctly.
