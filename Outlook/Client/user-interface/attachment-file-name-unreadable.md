---
title: Can't read an attachment file name
description: Resolves a bug in which the file name on an attachment icon is unreadable when you print an RTF email message in Outlook 2010 and Outlook 2013. This problem occurs because the icon has a black background.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: Christil, shshah, mereditm, sercast
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# File name on an attachment icon is unreadable when you print an RTF email message in Outlook

_Original KB number:_ &nbsp; 2550502

## Symptoms

Assume that you insert an attachment into a Rich Text Format (RTF) email message in Microsoft Outlook 2010 or Microsoft Outlook 2013. When you print the email message, the attachment icon has a black background. Therefore, you cannot read the file name of the attachment.

## Resolution

### Registry key information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

### Outlook 2010

For Outlook 2010, the `DisableAttachmentTransparency` registry setting was introduced with the Microsoft Outlook 2010 hotfix package dated June 18, 2011 (KB2544026). For more information about the hotfix package, see the following article:

[Description of the Office 2010 hotfix package (mso-x-none.msp): June 28, 2011](https://support.microsoft.com/help/2544026)

After you install the hotfix package, follow these steps to enable the hotfix:

1. Click **Start**, click **Run**, type regedit in the **Open** box, and then click **OK**.
2. Locate and then select the following registry subkey:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common`

3. On the **Edit** menu, point to **New**, and then click **DWORD (32-bit) Value**.
4. Type `DisableAttachmentTransparency`, and then press ENTER.
5. In the **Details** pane, right-click `DisableAttachmentTransparency`, and then click **Modify**.
6. In the **Value data** box, type **1**, and then click **OK**.
7. Exit Registry Editor.

### Outlook 2013

1. Click **Start**, click **Run**, type regedit in the **Open** box, and then click **OK**.
2. Locate and then select the following registry subkey:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common`

3. On the **Edit** menu, point to **New**, and then click **DWORD (32-bit) Value**.
4. Type `DisableAttachmentTransparency`, and then press ENTER.
5. In the **Details** pane, right-click `DisableAttachmentTransparency`, and then click **Modify**.
6. In the **Value data** box, type **1**, and then click **OK**.
7. Exit Registry Editor.
