---
title: NFS Server and File Permissions
description: Provides some information about NFS Server and File Permissions.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
ms.technology: networking
---
# NFS Server and File Permissions

This article provides some information about NFS Server and File Permissions.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 231964

## Summary

This article describes how to set file permissions on your Windows NT network file system (NFS) exports to work with UNIX NFS workstations.

## More information

You do not need to perform these steps when using only anonymous authentication, although the results can give you some insight into how NTFS file permissions are reflected onto UNIX workstations.

> [!NOTE]
> The following instructions assume that the Windows NT Server-based NFS computer is configured to use default values for advanced options and security permissions.

On the Microsoft Windows NT Server-based NFS computer:

1. Always set the NTFS permissions on your export (and all folders and files underneath the export) to Full Control for Everyone, the Administrators group, and the Administrator user.
2. If your export folder is empty, create a dummy file called `dummyfile` in your NFS export folder.
3. If you are not using a network information service (NIS) server, copy the Etc/Passwd and Etc/Group files in binary mode from the appropriate UNIX computer to the Winnt\System32\drivers\etc folder.

    > [!NOTE]
    > Leave the password fields blank. It is recommended that UIDs and GIDs be unique as a whole, as well as user names and groups as a whole. For example, do not use 1001 for a user and a group, and do not have a wheel user in addition to a wheel group.
4. Map each user and each group to a unique Windows NT user and group. You can do this using Server for NFS User Manager.
5. Map the UNIX root user to the Windows NT Administrator user and the group root or wheel to the Windows NT Administrators group.  

On the UNIX NFS client:

1. Log on as root (only root can mount an NFS export). Mount the export on your UNIX workstation by typing  

    ```console
    mount ntserver :/F/export/home/user /mnt  
    ```  

    where **`ntserver`** is the host name of the Windows NT Server-based computer, **F/export/home/user** is the path to the export, and **`mnt`** is a locally available mount point.

2. Check the permissions by typing:  

    ```console
    ls -l  
    ```

    Output similar to the following example is displayed:  

    ```console
    -rwxrwxrwx 1 root root dummyfile
    ```

3. Assign the appropriate owners to the files and folders by typing:  

    ```console
    /usr/ucb/chown -R user.group /mnt  
    ```

    > [!NOTE]
    > In some UNIX operating systems, the chown command does not take a group parameter. In these situations, you need to type chgrp -R group /mnt in addition to this command.

4. Assign appropriate permissions to the files and folders by typing:  

    ```console  
    chmod -R g-w,o-wx /mnt  
    ```

5. Verify the new permissions by typing:  

    ```console
    ls -l  
    ```

    Output similar to the following example is displayed:  

    ```console  
    -rwxr-xr-- 1 user group dummyfile  
    ```

If you are unable to change the permissions on a file or if you receive "access denied" error messages, use the following steps:

1. On the Windows NT Server-based NFS computer, assign Full Control to the export for Everyone, the Administrators group, and the Administrator user.
2. On the UNIX NFS client, copy the file to a different name (you must do it as a user, not as root). Delete the original file in Windows NT and rename the file to its original name.  

Some Windows NT users and groups cannot be mapped to equivalent UNIX users or groups. They may be displayed as nobody4 or nogroup. Special groups that exhibit this behavior include:

- Everyone
- Network
- Interactive
- System
- Authenticated users
