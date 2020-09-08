---
title: URL multiple slashes are changed to a single slash
description: Two or more consecutive forward slashes in a URL is converted to one forward slash in Word or Outlook. This causes the hyperlink to be invalid.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: article
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- CI 106818
- CSSTroubleshoot
ms.reviewer: gbratton
appliesto:
- Word
- Outlook
---

# Two or more consecutive slashes in a hyperlink are changed to one slash

## Symptoms

When you save a hyperlink that contains two or more consecutive forward slashes (/) in Microsoft Word or Microsoft Outlook, the group of slashes is changed to a single forward slash. Therefore, the hyperlink is no longer valid.

## Resolution

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [256986 Description of the Microsoft Windows registry](https://support.microsoft.com/help/256986/windows-registry-information-for-advanced-users).

1. Close all Office applications.
2. On the **Start** menu, select **Run**, enter **regedit**, and then select **OK**.
3. Locate and select the following registry subkey:

   **HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\x.0\Common**

   > [!NOTE]
   > In this subkey, *x.0* is the Office version (16.0 = Office 2019 or Office 2016, 15.0 = Office 2013, 14.0 = Office 2010).
4. After you select the subkey that's specified in step 3, point to **New** on the **Edit** menu, and then select **DWORD**.
5. Enter **AllowConsecutiveSlashesInUrlPathComponent**, and then press Enter.
6. Right-click **AllowConsecutiveSlashesInUrlPathComponent**, and then select **Modify**.
7. In the **Value data** box, enter **1**, and then select **OK**.
8. On the **File** menu, select **Exit** to exit Registry Editor.