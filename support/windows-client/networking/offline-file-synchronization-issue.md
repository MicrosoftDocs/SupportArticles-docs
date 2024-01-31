---
title: Offline file synchronization issues
description: Provides a solution to solve issues where the Work Offline/Work Online option button disappears from Windows Explorer after an offline/online transition and the Client-Side Caching remains offline until the next restart of the computer.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:folder-redirection-and-offline-files-and-folders-csc, csstroubleshoot
ms.subservice: networking
---
# Offline File Synchronization - In Windows 7 the "Work Offline/Work Online" option button disappears from Windows Explorer after an offline/online transition and the Client-Side Caching remains offline until the next restart of the computer

This article provides a solution to solve issues where the Work Offline/Work Online option button disappears from Windows Explorer after an offline/online transition and the Client-Side Caching remains offline until the next restart of the computer.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2512089

## Symptoms

You have Windows 7 configured for offline file synchronization to synchronize content from network shares and have it available offline. Users notice that Windows 7 changes usually to offline mode; however Windows 7 does not switch back to online mode automatically after the network becomes available. Synchronization of the UNC path is not possible, and in the Sync Center no information is available for the offline file synchronization partnership.

If the user accesses network resources in Windows Explorer, some network resources are online and accessible; however when the user tries to access resources that have been made available offline, the offline content is displayed from the Client-Side Caching. The user can create new files and change existing files, but these files remain in the local cache.

You provide a file share and subfolders for every user like in the following example:

\\\ServerName\ShareName$\dir1\dir2

A user with the appropriate permissions can access subfolders dir1 and dir2 but do not have permissions to view the content of the share ShareName$.

## Cause

This behavior is caused by the way Windows Vista and Windows 7 handle remote file operations. The UNC path is parsed and every part is checked for availability. In the case described in the sections above, Windows Vista or Windows 7 checks for the prefix \\\ServerName. If this is successful, it checks if the \\\ShareName$\ is available. Due to missing access rights on this level, the remote file operation fails and the Client-Side Caching (CSC) provides files from the offline content if the UNC path was made available offline.

> [!Note]
> if you are using DFS Namespace (AD integrated or stand alone) \\\domain\folder1\folder2 CSC will also check folder1 and folder2 on the DFS Namespace server.

## Resolution

To solve this issue with the offline file synchronization ensure that all parts of an UNC path are accessible by a user. On an UNC path like \\\ServerName\ShareName$\dir1\dir2 (where ServerName can be a file server or DFSN server) the following permissions are required on ShareName$ when the user synchronizes the subfolder dir1:

Share level (SMB) Permissions for the offline files share ShareName$:

| User Account| Default Permissions| Minimum permissions required |
|---|---|---|
|Everyone|Read|No Permissions|
|Security group of users needing to put data on share.|N/A|Change|

In this example, Everyone is removed from the share permissions and a global group containing the user account is used to set share level permissions.

NTFS permissions needed for the root folder ShareName$ for offline file synchronization:  

| User Account| Minimum Permissions Required |
|---|---|
|Creator Owner|Full Control, Subfolders and Files Only|
|Administrator|None|
|Security group of users that need to put data on share|List Folder/Read Data - This Folder, Subfolders and Files|
|Everyone|No Permissions|
|Local System|Full Control, This Folder, Subfolders and Files|

On the subfolders \dir1 and \dir2, the following permissions are required:
 NTFS permissions needed for the folders dir1 and dir2 for offline file synchronization:  

| User Account| Default Permissions| Minimum permissions required |
|---|---|---|
|%Username%|N/A|Read, Write|
|Local System|Full Control|Full Control|
|Administrators|No Permissions|No Permissions|
|Everyone|No Permissions|No Permissions|

## More information

In Windows Vista and Windows 7, all remote file system access requests are channeled by the Multiple UNC Provider (MUP). MUP redirects the request to a network redirector (the UNC provider) that is capable to handle the remote file system request. For example, for SMB requests MUP redirects the request to the network provider LanmanWorkstation (ntlanman.dll). LanmanWorkstation calls the Workstation Service (svchost.exe) that calls the network redirector (mrxsmb.sys).

MUP performs a prefix resolution operation (IOCTL_REDIR_QUERY_PATH) request to the network redirector that is registered with MUP and capable for the type of request. This prefix resolution operation parses the UNC path and checks every part for availability. If the return message from the prefix resolution is STATUS_LOGON_FAILURE or STATUS_ACCESS_DENIED, the request fails and MUP states the UNC path as not accessible.

The Client-Side Caching intercepts requests that are channeled to the network redirector. If the prefix resolution operation fails like described in the section above, CSC provides content from the local cache if the UNC path was made available offline before.

The behavior is outlined in detail on the following links:

- [Support for UNC Naming and MUP](https://msdn.microsoft.com/library/ff556761(v=vs.85).aspx)

- [IOCTL_REDIR_QUERY_PATH IOCTL](https://msdn.microsoft.com/library/ff548313(v=vs.85).aspx)

- [Basic Architecture of a Network Redirector](https://msdn.microsoft.com/library/ff538979(v=vs.85).aspx)
