---
title: Can't access WebDAV Web folder
description: Describes how to edit the FileAttributesLimitInBytes registry entry so that you can access a Web folder that contains many files in Windows.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, waltere
ms.custom: sap:webclient-and-webdav, csstroubleshoot
---
# You can't access a WebDAV Web folder from a Windows-based client computer

This article provides help to solve an issue where you can't access a Web Distributed Authoring and Versioning (WebDAV) Web folder from a Windows-based client computer.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 912152

## Symptoms

You can't access a WebDAV Web folder from a Windows-based client computer. When you try to do this, you may experience the following symptoms:

- When you use a Universal Naming Convention (UNC) path to access the Web folder, you receive an error message that is similar to the following:

    > \\\server\webfolder\folder is not accessible. You might not have permission to use this network resource.  
    Contact the administrator of this server to find out if you have access permissions.  
    >
    > A device attached to the system is not functioning.
    >
    > error 31 = ERROR_GEN_FAILURE

- When you map a driver letter to access the Web folder, you receive an error message that is similar to the following:

    > Disk is not formatted
    >
    > Windows cannot read from this disk. The disk might be corrupted, or it could be using a format that is not compatible with Windows.

- When you try to enumerate the Web folder at a command prompt, you receive the following error message:

    > File Not Found

Additionally, every time that you try to access the Web folder, memory consumption increases for the Svchost.exe process that contains the WebClient service. This increase may be approximately 20 megabytes (MB) for every 20,000 files in the Web folder. The memory is not released when you stop the WebClient service. The memory is released only if the computer is restarted.

## Cause

This problem may occur if all the following conditions are true:

- The client computer is running one of the following configurations:
  - Windows XP with Service Pack 1 (SP1) and security update 896426
  - Windows XP with Service Pack 2 (SP2)
  - Windows XP Professional x64 Edition
  - Windows 7
  - Windows 8
  - Windows 8.1

- The WebDAV folder contains many files. For example, the folder contains 20,000 or more files. By default, Windows XP will enumerate approximately 1,000 files in one Web folder. This number is based on the default setting for the following registry subkey:

  - Path: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WebClient\Parameters\`
  - Value: FileAttributesLimitInBytes
  - Data Type: DWORD
  - Default Value: 1,000,000 decimal (1 MB)
  - Description: This registry subkey determines the maximum collective size of all file attributes in one folder that is allowed by the WebDAV redirector. This attribute limit covers all the PROPFIND and PROPPATCH responses.

The problem occurs because the size of all the file attributes that are returned by the WebDAV server is much larger than what is expected. By default, this size is limited to 1 MB. This limit is for security reasons. For more information, see [Folder copy error message when downloading a file that is larger than 50000000 bytes from a Web folder](https://support.microsoft.com/help/900900).

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To work around this problem, add a DWORD entry that is named **FileAttributesLimitInBytes** to the following registry subkey:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WebClient\Parameters\`

Configure the **FileAttributesLimitInBytes** registry value to the size that you want, and then restart the WebClient service. To do this, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WebClient\Parameters\`

3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type **FileAttributesLimitInBytes** for the name of the DWORD, and then press ENTER.
5. Right-click **FileAttributesLimitInBytes**, and then click **Modify**.
6. In the **Value data** box, type the value that you want to use, and then click **OK**. For example, if the Web folder contains 20,000 files, type *20000000* in the **Value data** box.

    > [!NOTE]
    > If the default value is 1,000,000 (1 MB), Windows will enumerate a maximum of approximately 1,000 files in one folder. The actual maximum number of files may vary, depending on the number of file attributes or file properties. By default, the WebClient service does not ask for specific WebDAV properties. Therefore, the server returns all file attributes. The Microsoft Office-integrated Webfolders redirector does ask for specific WebDAV properties.

7. Exit Registry Editor.
8. Stop and then restart the WebClient service. To do this, follow these steps:
    1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
    2. Type the following commands, and then press ENTER after each command:

        ```console
        net stop webclient
        net start webclient
        ```
