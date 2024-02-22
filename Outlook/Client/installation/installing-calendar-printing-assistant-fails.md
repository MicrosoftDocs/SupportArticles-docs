---
title: Can't install Calendar Printing Assistant
description: Works around an issue in which you cannot install the Calendar Printing Assistant for Outlook when you have Outlook 2013 and later versions installed.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
ms.date: 10/30/2023
---
# Error when you try to install the Calendar Printing Assistant for Outlook: Setup cannot complete

_Original KB number:_ &nbsp; 2898576

## Symptoms  

Assume that you have Outlook 2013 or a later version installed on the computer. When you try to install the Calendar Printing Assistant for Outlook, you receive the following error message:

> Setup cannot complete. Calendar Printing Assistant for Microsoft Office Outlook 2007 requires the 2007 Microsoft Office system to be installed.  
> Please install the 2007 Microsoft Office system and then rerun setup.

## Cause

This issue occurs because the Calendar Print Assistant installation process looks for product version registry keys for Outlook 2007 and Outlook 2010. If you have either of these products already installed, you do not have to do the workaround.

To work around this issue, use one of the following methods.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To modify the registry subkey manually, follow these steps:

1. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows:

   - Windows 10 and Windows 8: Press Windows Key + R to open a **Run** dialog box. Type *regedit.exe* and then press **OK**.
   - Windows 7: Click **Start**, type *regedit.exe* in the search box, and then press **Enter**.

2. Locate and then right-click one of the following registry subkeys:

   - For a 32-bit version of Office that is installed on a 32-bit version of Windows:

      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\14.0\Common\ProductVersion`

   - For a 32-bit version of Office that is installed on a 64-bit version of Windows:

      `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\14.0\Common\ProductVersion`

3. Select **New**, and then click **String Value**.
4. Type **LastProduct** as the value name, and then press Enter.
5. Right-click the new **LastProduct** string value, and then click **Modify**.
6. In the **Value data** box, type *14.0.6029.1000*, and then click **OK**.
7. Exit Registry Editor.
8. Install the Calendar Printing Assistant for Outlook.
9. After you install the Calendar Printing Assistant for Outlook, remove the **LastProduct** value.

> [!NOTE]
> The value data version does not really matter. The Calendar Printing Assistant just checks whether the key exists.
