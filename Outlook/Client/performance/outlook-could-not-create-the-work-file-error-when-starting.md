---
title: Outlook could not create the work file error
description: Describes an issue that triggers an error during Outlook startup. Occurs when the Cache string value in the registry doesn't point to a valid directory. A resolution is provided.
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
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook could not create the work file error when you start Outlook

_Original KB number:_ &nbsp; 3062443

## Symptoms

When you start Microsoft Outlook, you receive the following error message:

> Outlook could not create the work file. Check the temp environment variable.

:::image type="content" source="media/outlook-could-not-create-the-work-file-error-when-starting/error.png" alt-text="Screenshot of the Outlook work file error." border="false":::

## Cause

This problem occurs when the Cache string value in the registry doesn't point to a valid directory.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require you to reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To resolve this issue, follow these steps.

1. Exit Outlook.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your situation:
   - Windows 10, Windows 8.1, and Windows 8: Press Windows Key+R to open a **Run** dialog box. Type *regedit.exe* and then press **OK**.
   - Windows 7 or Windows Vista: Select **Start**, type *regedit.exe* in the search box, and then press Enter.

3. Locate and then select the following subkey:  
   `HKEY_CURRENT_ USER \Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`

4. Right-click the Cache key, and then select Modify.

    > [!NOTE]
    > The Cache string value varies, depending on your version of Windows.

    **Windows 10, or Windows 8.1**

    DWORD: Cache  
    Type: REG_EXPAND_SZ  
    Data: %USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache

    **Windows 8, Windows 7, or Windows Vista**

    DWORD: Cache  
    Type: REG_EXPAND_SZ  
    Data: %USERPROFILE%\AppData\Local\Microsoft\Windows\Temporary Internet Files

    **Windows XP**

    DWORD: Cache  
    Type: REG_EXPAND_SZ  
    Data: %USERPROFILE%\Local Settings\Temporary Internet Files

5. On the **File** menu, select **Exit** to exit Registry Editor.
