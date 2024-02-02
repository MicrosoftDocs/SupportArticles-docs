---
title: Move the CSC folder to a new location
description: Describes how to move the client-side caching (CSC) folder to a new location in Windows Vista or later versions of Windows.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:folder-redirection-and-offline-files-and-folders-csc, csstroubleshoot
---
# Move the client-side caching (CSC) folder to a new location in Windows

This article describes how to move the CSC folder in Windows. It also describes how to delete the old cache folder after you move the CSC cache folder to a new location.

_Applies to:_ &nbsp; Windows 10, version 2004, Windows 10, version 1909, Windows 10, version 1709, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 942960

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

## Why you can't use Cachemov.exe

The Cachemov.exe tool isn't supported in Windows Vista and later versions of Windows. When you try to use the Cachemov.exe tool to move the CSC folder in Windows Vista and later versions of Windows, you may receive the following error message:

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

1. Open an elevated command prompt. Select **Start** > **All Programs** > **Accessories**, right-click **Command Prompt**, and then select **Run as administrator**.

    If you're prompted for an administrator password or for a confirmation, type the password, or select **Allow**.

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
  
    1. Select **Start a New Transfer**.
    2. Select **My old computer**.
    3. Select **Use a CD, DVD or other removable media**.
    4. Select **External hard disk or to a network location**.
    5. Type a path where you want to save the Savedata.mig file, and then select **Next**.
    6. Select **Advanced options**.
    7. In the **Select user accounts, files, and settings to transfer** dialog box, follow these steps:

        1. Clear all check boxes.
        2. Under **System and program settings (all users)**, expand **Windows Settings** > **Network and Internet**, and then select the **Offline Files** check box.
        3. Repeat the previous step for each user who is listed on the page.
        4. Select **Next** to begin the transfer process.

## Change the registry settings

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

Check the cache size that is used on the computer by following these steps:

1. In **Control Panel**, select **Network and Internet** > **Offline Files**.
2. Select the **Disk Usage** tab in the **Offline Files** box.

If the cache size is zero, you must change only the registry settings as given in the following list. Or, if the cache size is set to some value, follow all the steps.

1. Select **Start**, type *regedit* in the **Search** box, and then press ENTER.
2. Locate the following registry subkey, and then right-click it: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\CSC`.
3. Right-click **CSC**, point to **New**, and then select **Key**.
4. Type *Parameters* in the name box.
5. Right-click **Parameters**, point to **New**, and then select **String Value**.
6. To name the new value, type *CacheLocation*, and then press ENTER.
7. Right-click **CacheLocation**, and then select **Modify**.
8. In the **Value data** box, type the name of the new folder in which you want to create the cache.

    > [!NOTE]
    > Use the Microsoft Windows NT format for the folder name. For example, if you want the cache location to be `d:\csc`, type `\??\d:\csc`.

9. Exit **Registry Editor**, and then restart the computer.

## Continue the transfer process

1. At the elevated command prompt, type the following command, and then press ENTER: `c:\windows\system32\migwiz\migwiz.exe`.

2. In the Windows Easy Transfer Wizard, select the following options:

    1. Select **Continue a transfer in progress**.
    2. Select **No, I've copied files and settings to a CD, DVD, or other removable media**.
    3. Select **On an external hard disk or network location**.
    4. Type the path of the Savedata.mig file created in step 4e in the [Move the CSC folder](#move-the-csc-folder) section.
    5. Map the user account on the old computer to the corresponding user account on the new computer.
    6. Select **Next** > **Transfer**.
    7. Restart the computer.

## Delete the old cache

When all the files are moved, delete the old cache from a Windows Vista Release Candidate 1 (RC1) build by following these steps:

1. At the elevated command prompt, type the `takeown /r /f c:\windows\csc` command, and then press ENTER.

2. At the elevated command prompt, type the `rd /s c:\windows\csc` command, and then press ENTER.

> [!NOTE]
> The limitation of this method to delete the old cache is that Takeown.exe can only process paths that do not exceed the `MAX_PATH` (maximum length of a path). The maximum length of a path is 260 characters. If this path length exceeds the `MAX_PATH`, the takeown command fails.

## References

For more information about how to change the location of the CSC folder, see [How to change the location of the CSC folder by configuring the CacheLocation registry value in Windows Vista](https://support.microsoft.com/help/937475).
