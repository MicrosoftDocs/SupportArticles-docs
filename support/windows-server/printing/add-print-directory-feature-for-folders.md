---
title: Add Print Directory feature for folders
description: Explains how to print a directory listing of the contents of a folder more easily by using the Print Directory feature.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, davidg, georgev
ms.custom: sap:management-and-configuration:-general-issues, csstroubleshoot
ms.subservice: printing
---
# How to add the Print Directory feature for folders in Windows XP, in Windows Vista, in Windows 7

This article describes how to print a directory listing of the contents of a folder by using the Print Directory feature.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 321379

## Summary  

After you follow the steps that are described in the "More Information" section, you can right-click a folder and then click
 **Print Directory Listing** to print a directory listing of the contents of a folder. For more information about how to add the print directory feature for folders in Windows 2000, in Windows Server 2003 or in Windows Server 2008, click the following article number to view the article in the Microsoft Knowledge Base: [272623](https://support.microsoft.com/help/272623) How to add the print directory feature to Windows Explorer  

## More information

### Windows XP

#### Step 1: Create the Printdir.bat file

To do this, follow these steps:  

1. Click **Start**, click **Run**, type notepad, and then click **OK**.
2. Paste the following text into Notepad:

    ```console
    @echo off
    dir %1 /-p /o:gn > "%temp%\Listing"
    start /w notepad /p "%temp%\Listing"
    del "%temp%\Listing"
    exit
    ```

3. On the **File** menu, click **Exit**, and then click **Yes** to save the changes.
4. In the **Save As** dialog box, type the following text in the **File name** box, and then click **Save**: %windir%\Printdir.bat.  

#### Step 2: Create a new action for file folders

1. Click **Start**, click **Control Panel**, and then double-click **Folder Options**.  
    Or, click **Start**, point to **Settings**, click **Control Panel**, and then double-click **Folder Options**.
2. On the **File Types** tab, click **File Folder**.
3. Click **Advanced**, and then click **New**.
4. In the **Action** box, type Print Directory Listing.
5. In the **Application used to perform action** box, type printdir.bat.
6. Click **OK**.
7. Click **OK** two times, and then click **Close**.

#### Step 3: Edit the registry

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

After you follow the steps in the previous sections, Search Companion may start when you double-click a folder instead of the folder being opened. Or, if you have associated other actions with file folders, those actions may be performed instead.

To resolve this issue, follow these steps:  

1. Click **Start**, click **Run**, type Regedit and then click **OK**.
2. Locate the following registry subkey: `HKEY_CLASSES_ROOT\Directory\shell`  
3. Click the value named Default.
4. On the **Edit** menu, click **Modify**.
5. In the **Value data** box, type none.
6. Click **OK**.
7. Exit Registry Editor.

### Windows Vista or Windows 7

#### Step 1: Create the Printdir.bat file

To do this, follow these steps:  

1. Click **Start**, click **Run**, type notepad, and then click **OK**.
2. Paste the following text into Notepad:

    ```console
    @echo off
    dir %1 /-p /o:gn > "%temp%\Listing"
    start /w notepad /p "%temp%\Listing"
    del "%temp%\Listing"
    exit
    ```

3. On the **File** menu, click **Exit**, and then click **Yes** to save the changes.
4. In the **Save As** dialog box, type the following text in the **File name** box, and then click **Save: %windir%\Printdir.bat.  

    > [!NOTE]
    > If you receive a dialog box that says you don't have permission to save in this location, you can save the file to the desktop. Next, you click **Start**, click **Run**, type **%windir%** , and then click **OK**. Then, you can copy the file from the desktop to the location.

#### Step 2: Edit the registry

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. Click **Start**, click **Run**, type **Notepad,** and then click **OK**.
2. Type the following commands in Notepad.

    ```registry
    Windows Registry Editor Version 5.00  
    [HKEY_CLASSES_ROOT\Directory\Shell] @="none"  
    [HKEY_CLASSES_ROOT\Directory\Shell\Print_Directory_Listing] @="Print Directory Listing"  
    [HKEY_CLASSES_ROOT\Directory\shell\Print_Directory_Listing\command] @="Printdir.bat \"%1\""  
    [HKEY_CLASSES_ROOT\SOFTWARE\Classes\Directory] "BrowserFlags"=dword:00000008  
    [HKEY_CLASSES_ROOT\SOFTWARE\Classes\Directory\shell\Print_Directory_Listing] @="Print Directory  
    Listing"[HKEY_CLASSES_ROOT\SOFTWARE\Classes\Directory\shell\Print_Directory_Listing\command]  
    @="Printdir.bat \"%1\""  
    [HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\AttachmentExecute\  
    {0002DF01-0000-0000-C000-000000000046}] @=""[HKEY_CLASSES_ROOT\SOFTWARE\Classes\Directory]  
    "EditFlags"="000001d2"
    ```

    On the **File** menu, click **Save As**.
3. In the **Save in** list, click **Desktop**.
4. In the **File name** box, type PrintDirectoryListing.reg, click **All Files** in the **Save as type** list, and then click **Save**.
5. On the desktop, double-click the PrintDirectoryListing.reg file to add the registry keys to the Windows registry.
6. Click **OK** in the message box.
