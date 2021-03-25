---
title: Features and functions in version 1.1 of the Client-Side Caching Command-Line Options command-line tool
description: Provides information about the features and functions that are available in the offline file management tool CSCCMD 1.1.
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
# Features and functions in version 1.1 of the Client-Side Caching Command-Line Options command-line tool

This article provides information about the features and functions that are available in the offline file management tool CSCCMD 1.1.

_Original product version:_ &nbsp;Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp;884739

## Introduction

This article contains information about the features and functions in the latest version of the Client-Side Caching Command-Line Options (CSCCMD) command-line tool (Csccmd.exe).

## More information

You can use the CSCCMD tool to manage offline files in Microsoft Windows 2000, in Microsoft Windows XP, and in Microsoft Windows Server 2003. The latest version of the CSCCMD tool is 1.1. Version 1.1 includes new functions and features that weren't available in the earlier versions.

> [!NOTE]
> Users who use the CSCCMD tool must have good knowledge of client-side caching functionality.

To obtain the CSCCMD tool, contact Microsoft Product Support Services. For a complete list of Microsoft Product Support Services phone numbers and information about support costs, visit the following Microsoft Web site:

[Global Customer Service phone numbers](https://support.microsoft.com/help/4051701)

> [!NOTE]
> You can also download CSCCMD 1.0 and other tools as part of Windows Server 2003 Resource Kit Tools.

The CSCCMD tool uses the following syntax: CSCCMD [/RESID] [/ENABLE] [/DISABLE] [/DISCONNECT: \\\\**Server**\\**Share**] [/MOVESHARE: \\\\**Server**\\**Share1** \\\\**Server**\\**Share2** ] [/?]  

The following command-line switches and their functions are available in the latest version of the CSCCMD tool:  

- /ENABLE - Use this switch to enable Client-Side Caching (CSC) on a client. This switch lets you access and synchronize network files while you're working offline.

    > [!NOTE]
    > You must be an administrator on the local computer to use this switch.

- /DISABLE - Use this switch to disable CSC. Before you run this command, you must make sure that you've closed all offline files. If you disable CSC, you can't work on network files while you're working offline.

    > [!NOTE]
    > You must be an administrator on the local computer to use this switch.
- /ENUM[:\\\ **Server**\\**Share**[\\**Path**]] [/RECURSE] - Use this switch to display all the shares in the local cache. If you use this switch with the /RECURSE option, the CSCCMD tool displays the contents of the shares within a parent share. You can also display the contents of a specific share of a server. To do this, use the \\\\**Server**\\**Share** format. For example, use the following command: CSCCMD /ENUM: \\**MyServer**\\**MyShare**  
    > [!NOTE]
    > **MyServer** is the server name, and **MyShare** is the name of the shared resource.
- /DISCONNECT: \\\\**Server**\\**Share** - Use this switch to disconnect a specific server from Client-Side Caching on the client computer. Use the \\\\**Server**\\**Share** format to specify the name of a specific shared resource of a server that you want to disconnect. For example, use the following command: CSCCMD /DISCONNECT: \\\\**MyServer**\\**MyShare**  
The background Client-Side Caching agent doesn't try to reconnect the server. If you synchronize offline content by using the synchronization manager, the Client-Side Caching agent then reconnects to the server if it's available.

    > [!NOTE]
    > A handle must be open on this share or any directory/file on this share for this function to work correctly.
- /MOVESHARE: \\\\**Server1**\\**Share**\\\\**Server2**\\**Share** - Use this switch to move files and directories from one share to another share in the cache. This option is useful if the target of offline files has moved and if the local cache now must point to a new location. For example, use the following command: CSCCMD /MOVESHARE: \\\\**MyServer**\\**MyShare**\\\\**MyServer1**\\**MyShare1**  
    > [!NOTE]
    > **MyServer1** is the new server name, and **MyShare1** is the name of the new shared resource.
- /RESID - Use this switch to restamp all the entries in the Windows offline files (CSC) database by using a new user security identifier (SID). This switch is used in scenarios where an organization moves user accounts from a Microsoft Windows NT 4.0 domain to a Windows Server 2003 domain.

    If a user's cache is security enhanced by using the user's Windows NT 4.0 SID, the cache can't be accessed from the Windows Server 2003 account unless the cache entries are restamped by using the Windows Server 2003 SID.
- /ISENABLED or /ISCSCENABLED - Use either of these switches to determine whether CSC is enabled on your client computer.
- /PIN2: \\\\**server**\\**share**\\**path**[/USER] [/SYSTEM] [/USERINHERIT] [/SYSTEMINHERIT] - Use this switch to pin shared resources. You can use the /USER option to pin a file. This action has the same result as using the **Offline Files** dialog box to cache the file. The /SYSTEM option specifies that the shared resource must be administratively pinned by configuring the Group Policy settings. The /USERINHERIT option and the /SYSTEMINHERIT]INHERIT option designates how the pin data is inherited. You can use any combination of the pin types.

- /PIN2: **filename** /FILELIST [/UNICODE] [/USER] [/SYSTEM] [/USERINHERIT] [/SYSTEMINHERIT]  
- Use this switch if you want to use a file that describes all the objects to pin as parameters. The file contains the Universal Naming Convention (UNC) path of the objects to pin. The objects are separated by a carriage return/linefeed. For example, use the following command: CSCCMD /PIN: **MyShare.txt** /FILELIST  
    > [!NOTE]
    > The **MyShare.txt** file contains entries that are separated by spaces.

    These entries are similar to the following:

    //MyServer/MyShare //MyServer1/MyShare1

    > [!NOTE]
    > The /PIN switch does not copy the content of the shared resource into the local cache. Pinning is not sufficient to make the files available offline. After you use the /PIN switch, you must run the CSCCMD command together with the /FILL switch to copy the content of the shared resource to the local cache and to make sure that the shared resource is available offline. The /USERINHERIT option and the /SYSTEMINHERIT]INHERIT option designates how the pin data is inherited. You can use any combination of the pin types.
- /UNPIN2: \\\\**server**\\**share**\\**path**[/USER] [/SYSTEM] [/USERINHERIT] [/SYSTEMINHERIT] [/RECURSE]  
- Use this switch to unpin a shared resource or to remove a shared resource from the local cache. If you use this switch with the /RECURSE option, the CSCCMD tool unpins all children of the path. If you use this switch with the /RECURSE2 option, the CSCCMD tool unpins the path and children of the path. You can use any combination of the pin types.
- /UNPIN2: **filename** /FILELIST [/UNICODE] [/USER] [/SYSTEM] [/USERINHERIT] [/SYSTEMINHERIT] - Use this switch to unpin a specific set of shared resources by using a file. You can use any combination of the pin types.

    > [!NOTE]
    > The /FILELIST parameter indicates that the file specified is a text file with one file name for each line. Any white space at the start of a file is ignored. However, any white space at the end of the line is counted. Lines are delimited by any combination of carriage return characters, linefeed characters, or both.

    If you use this switch with the /UNICODE option, the CSCCMD tool creates the file list in Unicode text format.

- /FILL: \\\\**Server**\\**Share**\\**Path** - Use this switch to copy server-side data to the local cache for a specified shared resource.

- /FILL: **FileName** /FILELIST [/UNICODE]  
- Use this switch to copy server-side data to the local cache for a set of specified shared resources by using a file.

    > [!NOTE]
    > The /FILELIST parameter indicates that the file specified is a text file with one file name per line. Any white space at the start of a file is ignored. However, any white space at the end of the line is counted. Lines are delimited by any combination of carriage return characters, linefeed characters, or both.

    If you use this switch with the /UNICODE option, the CSCCMD tool creates the file list in Unicode text format.
- /DELETE: \\\\**Server**\\**Share**\\**Path**[/RECURSE] [/RECURSE2]  
- Use this switch to delete a file, a directory, or a share from the local cache. To delete a directory or a share, you must make sure that the directory or the share is empty before you use this switch. If the directory or the share isn't empty, you can't delete the directory or the share. If the file is open, you can't delete the file. If you use this switch with the /RECURSE option, the CSCCMD tool only operates on the children of the path. If you use this switch with the /RECURSE2 option, the CSCCMD tool operates on the path and children of the path.
- /ISSERVEROFFLINE: \\\\**Server** - Use this switch to determine whether CSC considers a specific server to be offline.

    > [!NOTE]
    > Before you use this switch, you must open any share, file, or directory that is stored on the local cache for the server that you want to verify. If you do not do this, the CSCCMD command always reports that the server is online. Also, the server state that this command reports is the state that CSC recognizes. It is not the actual server state.

- /SETSPACE: **Bytes to Set** - Use this switch to specify the disk space in bytes that you want to allocate to temporary offline files. These temporary offline files are nonpinned, auto-cached files. This function works similarly to the function that is provided in the **Offline Files** dialog box.
- /CHECKDB [/QUICK] - Use this switch to examine the CSC database and to display any database error flags. If you use this switch with the /QUICK option, the CSCCMD tool skips the enumeration, and just displays the database errors.
- /EXTRACT[:\\\\**Server**\\**Share**[\\**Path** ]] /TARGET: **Path** [/RECURSE] [/ONLYMODIFIED] [/STOPONERROR] - Use this switch to extract a file, a directory, or a directory tree from the local cache. You can use the /TARGET option to specify the destination to which you want to extract the file or the directory. You can specify a destination folder that already exists, or you can specify a destination folder that doesn't already exist.

    > [!NOTE]
    > If the destination folder that you specify does not already exist, the process automatically creates a folder that has the name that you specify.

    You can use the /ONLYMODIFIED option to extract only those files that have been modified offline. If you use the /STOPONERROR option, the extraction process stops whenever an error occurs during the extraction process.

    > [!NOTE]
    > Because files in the offline cache use NTFS file system permissions, you must be an administrator on the local computer to use the /EXTRACT switch.
