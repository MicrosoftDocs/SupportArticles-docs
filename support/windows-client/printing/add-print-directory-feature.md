---
title: Add print directory feature to Windows Explorer
description: Describes how to add the print directory feature, and how to enable printing of the directory listing from within Windows Explorer.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration:-general-issues, csstroubleshoot
---
# How to add the print directory feature to Windows Explorer

This article describes how to add the print directory feature, and how to enable printing of the directory listing from within Windows Explorer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Vista  
_Original KB number:_ &nbsp; 272623

## Summary

For more information about How to add the Print Directory feature for folders in Windows XP, in Windows Vista, or in Windows 7, click the following article number to view the article in the Microsoft Knowledge Base: [321379](https://support.microsoft.com/help/321379) How to add the Print Directory feature for folders in Windows XP, in Windows Vista, or in Windows 7  

## More information

To add the print directory feature to Windows Explorer, follow these steps:

### Step 1: Create the Printdir.bat file

To do this, follow these steps:

1. Click **Start**, click **Run**, type *notepad*, and then click **OK**.
2. Paste the following text into Notepad:

    ```console
    @echo off  
    dir %1 /-p /o:gn > "%temp%\Listing"  
    start /w notepad /p "%temp%\Listing"  
    del "%temp%\Listing"  
    exit
    ```

3. On the **File** menu, click **Exit**, and then click **Yes** to save the changes.
4. In the **Save As** dialog box, type the following text in the **File name** box, and then click **Save**: %windir%\\Printdir.bat  

> [!NOTE]
> If you receive a dialog box that states that you do not have permission to save in this location, you can save the file to the desktop. Next, you click **Start**, click **Run**, type *%windir%*, and then click **OK**. Then, you can copy the file from the desktop to the location.

### Step 2: Edit the registry

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. Click **Start**, click **Run**, type *Notepad*, and then click **OK**.
2. Type the following commands in Notepad.

    ```registry
    Windows Registry Editor Version 5.00

    [HKEY_CLASSES_ROOT\Directory\Shell]
    @="none"

    [HKEY_CLASSES_ROOT\Directory\Shell\Print_Directory_Listing]
    @="Print Directory Listing"

    [HKEY_CLASSES_ROOT\Directory\shell\Print_Directory_Listing\command]
    @="Printdir.bat \"%1\""

    [HKEY_CLASSES_ROOT\SOFTWARE\Classes\Directory]
    "BrowserFlags"=dword:00000008

    [HKEY_CLASSES_ROOT\SOFTWARE\Classes\Directory\shell\Print_Directory_Listing]
    @="Print Directory Listing"

    [HKEY_CLASSES_ROOT\SOFTWARE\Classes\Directory\shell\Print_Directory_Listing\command]
    @="Printdir.bat \"%1\""

    [HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\AttachmentExecute\{0002DF01-0000-0000-C000-000000000046}]
    @=""

    [HKEY_CLASSES_ROOT\SOFTWARE\Classes\Directory]
    "EditFlags"="000001d2"
    ```

    On the **File** menu, click **Save As**.
3. In the **Save in** list, click **Desktop**.
4. In the **File name** box, type *PrintDirectoryListing.reg*, click **All Files** in the **Save as type** list, and then click **Save**.
5. On the desktop, double-click the LoggingOn.reg file to add the registry keys to the Windows registry.
6. Click **OK** in the message box.
