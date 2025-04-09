---
title: Disable the background save feature in Outlook
description: Describes how to set a registry keydisable the background save feature in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User Interface features and Configuration\Help
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: luche
appliesto: 
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 04/08/2025
---
# Disable the background save feature in Outlook

_Original KB number:_ &nbsp; 319158

When you create an email message that has one or more attachments in Microsoft Outlook, the attachments are streamed to Microsoft Exchange Server in the background. This background save feature minimizes the time that you have to wait before you can send the message.

In an environment that has low bandwidth, you can disable the background save feature in Outlook by configuring the `DisableBGSave` registry key.
Use the following steps:

[!INCLUDE [Important registry alert](../../../includes/registry-important-alert.md)]

1. Exit all Microsoft Office applications.
2. Start Registry Editor.
3. Locate and then select the following registry subkey:
   `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook`

    If this subkey doesn't exist, select the following subkey instead:
   `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Outlook`
4. On the **Edit** menu, point to **New**, and then select **DWORD (32-bit) Value**.
5. Type **DisableBGSave**, and then press Enter.
6. Right-click the **DisableBGSave** entry, and then select **Modify**.
7. Select **Hexadecimal** for the base, type *1* in the **Value data** box, and then select **OK**.
8. Exit Registry Editor.
