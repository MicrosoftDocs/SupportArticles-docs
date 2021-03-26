---
title: Move the CSC folder to a new location
description: This article describes how to move the client-side caching (CSC) folder to a new location in Windows Vista or later versions of Windows.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Folder redirection and Offline Files and Folders (CSC)
ms.technology: windows-client-networking
---
# Move the client-side caching (CSC) folder to a new location in Windows

This article describes how to move the client-side caching (CSC) folder in Windows and how to delete the old cache folder after you move the CSC cache folder to a new location.

_Original product version:_ &nbsp; Windows 10, version 2004, Windows 10, version 1909, Windows 10, version 1709, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 942960

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

## Why you can't use Cachemov.exe

The Cachemov.exe tool is not supported in Windows Vista and later versions of Windows. When you try to use the Cachemov.exe tool to move the client-side caching (CSC) folder in Windows Vista and later versions of Windows, you may receive the following error message:

> cachemov.exe - Ordinal Not Found  
> The ordinal 51 could not be located in the dynamic link library CSCDLL.dll

> [!NOTE]
> The CSC folder is the folder in which Windows Vista stores offline files.

The Cachemov.exe tool is used to move the CSC folder on a computer that contains one of the following operating systems:

- Windows Server 2003
- Windows XP
- Windows 2000 Server

## Move the CSC folder

Typically, the offline files cache is located in the following directory: `%systemroot%\CSC`.

To move the CSC cache folder to another location in Windows Vista, Windows 7, Windows 8.1, and Windows 10, follow these steps:

1. Open an elevated command prompt. To do this, click **Start**, click **All Programs**, click **Accessories**, right-click **Command Prompt**, and then click **Run as administrator**.

    If you are prompted for an administrator password or for a confirmation, type the password, or click **Allow**.

2. Type the following command, and then press ENTER:

    ```console
    REG ADD "HKLM\System\CurrentControlSet\Services\CSC\Parameters" /v MigrationParameters /t REG_DWORD /d 1 /f
    ```

3. Type the following command, and then press ENTER:

    ```console
    c:\windows\system32\migwiz\migwiz.exe
    ```

    > [!NOTE]
    > You may have to substitute a different drive letter, as appropriate for your situation.

4. In the Windows Easy Transfer Wizard, select the following options:
  
    1. Click **Start a New Transfer**.
    2. Click **My old computer**.
    3. Click **Use a CD, DVD or other removable media**.
    4. Click **External hard disk or to a network location**.
    5. Type a path where you want to save the Savedata.mig file, and then click **Next**.
    6. Click **Advanced options**.
    7. In the **Select user accounts, files, and settings to transfer** dialog box, do the following:

        1. Clear all check boxes.
        2. Under **System and program settings (all users)**, expand **Windows Settings**, expand **Network and Internet**, and then click to select the **Offline Files** check box.
        3. Repeat the previous step for each user who is listed on the page.
        4. Click **Next** to begin the transfer process.

## Change the registry settings

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

Check the cache size that is used on the computer. To do this, follow these steps:

1. In **Control Panel**, click **Network and Internet**, and then click **Offline Files**.
2. Click the **Disk Usage** tab in the **Offline Files** box.

If the cache size is zero, you must change only the registry settings as given in the following list. Or, if the cache size is set to some value, follow all the steps.

1. Click **Start**, type *regedit* in the **Search** box, and then press ENTER.
2. Locate the following registry subkey, and then right-click it: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\CSC`.
3. Right-click **CSC**, point to **New**, and then click **Key**.
4. Type *Parameters* in the name box.
5. Right-click **Parameters**, point to **New**, and then click **String Value**.
6. To name the new value, type *CacheLocation*, and then press ENTER.
7. Right-click **CacheLocation**, and then click **Modify**.
8. In the **Value data** box, type the name of the new folder in which you want to create the cache.

    > [!NOTE]
    > Use the Microsoft Windows NT format for the folder name. For example, if you want the cache location to be `d:\csc`, type `\??\d:\csc`.

9. Exit **Registry Editor**, and then restart the computer.

## Continue the transfer process

1. At the elevated command prompt, type the following command, and then press ENTER: `c:\windows\system32\migwiz\migwiz.exe`.

2. In the Windows Easy Transfer Wizard, select the following options:

    1. Click **Continue a transfer in progress**.
    2. Click **No, I've copied files and settings to a CD, DVD, or other removable media**.
    3. Click **On an external hard disk or network location**.
    4. Type the path of the Savedata.mig file that was created in step 4e of the procedure in the [Move the CSC folder](#move-the-csc-folder) section.
    5. Map the user account on the old computer to the corresponding user account on the new computer.
    6. Click **Next**, and then click **Transfer**.
    7. Restart the computer.

## Delete the old cache

When all the files are moved, delete the old cache from a Windows Vista Release Candidate 1 (RC1) build. To do this, follow these steps:

1. At the elevated command prompt, type the `takeown /r /f c:\windows\csc` command, and then press ENTER.

2. At the elevated command prompt, type the `rd /s c:\windows\csc` command, and then press ENTER.

> [!NOTE]
> The limitation of this method to delete the old cache is that Takeown.exe can only process paths that do not exceed the `MAX_PATH` (maximum length of a path). The maximum length of a path is 260 characters. If this path length exceeds the `MAX_PATH`, the takeown command fails.

## References

For more information about how to change the location of the CSC folder, see [How to change the location of the CSC folder by configuring the CacheLocation registry value in Windows Vista](https://support.microsoft.com/help/937475).
