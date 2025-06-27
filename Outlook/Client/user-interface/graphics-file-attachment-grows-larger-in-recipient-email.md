---
title: Graphics file attachment larger in recipient's email
description: Fixes a problem that makes a graphics file attachment look larger in a recipient's email message after you change the resolution to a high DPI setting in Windows.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User Interface features and Configuration\Other
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: abarglo
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Word 2016
  - Outlook 2013
  - Word 2013
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Graphics file attachment grows larger in the recipient's email message after you change to a high DPI setting

_Original KB number:_ &nbsp; 3042197

## Symptoms

Assume that you change the dots per inch (DPI) setting in Windows to a higher resolution, such as 125 DPI or 150 DPI. Then, in Microsoft Outlook, you send, reply to, or forward an email message that contains a graphics file attachment. In this situation, the graphics file image appears larger in the recipient's copy of the message than in the message that you originally sent, replied to, or forwarded.

## Cause

This problem is caused by a change that was introduced in Microsoft Word 2010. Outlook 2010 and later versions use Word as the email editor.

## Resolution

To resolve this issue, install the update appropriate for your version of Office, and then add the `DontUseScreenDpiOnOpen` registry value by following the steps in the Registry information section.

> [!NOTE]
> Office 2016 does not require the installation of an update. However, you still must add the `DontUseScreenDpiOnOpen` value to the system registry for these versions.

For Office 2013, install Microsoft Office 2013 Service Pack 1 (SP1). For information about this update, see [Description of Microsoft Office 2013 Service Pack 1 (SP1)](https://support.microsoft.com/help/2817430/description-of-microsoft-office-2013-service-pack-1-sp1).

### Registry information

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To add the `DontUseScreenDpiOnOpen` value to the registry, follow these steps:

1. Exit Outlook.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows.
   - Windows 10, Windows 8.1, and Windows 8: Press Windows key+R to open a **Run** dialog box. Type *regedit.exe* and then press **OK**.
   - Windows 7: Select **Start**, type *regedit.exe* in the search box, and then press Enter.

3. Locate and then select the following registry subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Word\Options`

    > [!NOTE]
    > The **x.0** placeholder represents your version of Office (16.0 = Office 2016, Microsoft 365 and Office 2019, 15.0 = Office 2013, 14.0 = Office 2010).

4. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
5. Type *DontUseScreenDpiOnOpen*, and then press Enter .
6. In the Details pane, right-click **DontUseScreenDpiOnOpen**, and then select **Modify**.
7. In the **Value data** box, type *1*, and then select **OK**.
8. Exit Registry Editor.
