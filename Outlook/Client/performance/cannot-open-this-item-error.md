---
title: Cannot open this item error
description: Describes an issue that triggers an error when you try to open an email message in Outlook 2007 and later versions. To fix this issue, you must install update 3008627.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# Cannot open this item The text formatting command is not available error in Outlook

_Original KB number:_ &nbsp; 3062702

## Symptoms

When you try to open an email message in Microsoft Outlook 2013, Outlook 2010, or Outlook 2007, you receive the following error message:

> Cannot open this item. The text formatting command is not available. It may not be installed correctly. Install Microsoft Outlook again.

## Cause

This problem occurs when the following conditions are true:

- You do not have update [Unexpected UAC prompt after you install update 2918614 in Windows](https://support.microsoft.com/help/3008627/unexpected-uac-prompt-after-you-install-update-2918614-in-windows) installed.
- The `NoUACforHashMissing` registry entry doesn't exist in your system registry.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require you to reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To resolve this issue, follow these steps:

1. Exit Outlook.
2. Install the [Unexpected UAC prompt after you install update 2918614 in Windows](https://support.microsoft.com/help/3008627/unexpected-uac-prompt-after-you-install-update-2918614-in-windows) update.

    > [!NOTE]
    > To install this update in Windows 8.1 or Windows Server 2012 R2, you must first install [Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2 update: April 2014](https://support.microsoft.com/help/2919355). For Windows 7 and Windows Server 2008 R2, first install Service Pack 1. For Windows Vista and Windows Server 2008, first install Service Pack 2.

3. Start Registry Editor. To do this, use one of the following methods, as appropriate for your situation:
   - Windows 8: Press Windows Key+R to open a **Run** dialog box.
   - Windows 7 or Windows Vista: select **Start**, and then select **Run** to open a **Run** dialog box.

4. Type *regedit.exe*, and then press Enter.
5. Locate and select the following registry key:

   `HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Installer`

6. On the **Edit** menu, point to **New**, then select DWORD Value.
7. Type *NoUACforHashMissing*, and then press Enter.
8. Right-click `NoUACforHashMissing`, and then select **Modify**.
9. In the **Value data** box, type *1*, and then select **OK**.
10. Exit Registry Editor.
11. Start Outlook.
