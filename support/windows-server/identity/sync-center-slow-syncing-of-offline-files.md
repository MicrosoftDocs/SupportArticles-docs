---
title: Sync Center syncs offline files very slow
description: Describes an issue that slows down the progress of offline folder file sync operations by Microsoft Sync Center. This issue involves unsorted files and the extra time that's needed to sort them.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, bburgin, garymu
ms.custom: sap:domain-join-issues, csstroubleshoot
ms.subservice: active-directory
---
# Sync Center: Slow syncing of offline files on some file servers

This article describes an issue that slows down the progress of offline folder file sync operations by Microsoft Sync Center.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3046857

## Summary

When Microsoft Sync Center syncs offline files, the sync operation may take longer than expected. This behavior occurs when the back-end file server enumerates unsorted directory contents (a list in which the file names are not sorted alphabetically). This affects Microsoft Sync Center performance when it syncs offline files with non-Microsoft file servers.

## More information

Microsoft Sync Center compares the local system's directory list against a list of files that it receives from the remote file server. Sync Center does this by making query directory calls against the remote file server through the Server Message Block protocol (CIFS, SMB, SMB2, and SMB3). Microsoft file servers always return query directory results in alphabetical order, sorted by file name. (The underlying NTFS file system maintains sorted lists.)

Many underlying file systems do not maintain sorted lists. This includes the file systems that are used by most third-party SMB protocol implementers and Microsoft file systems such as FAT32. Therefore, most third-party file servers exhibit performance delays when they sync offline files by using Sync Center.

> [!NOTE]
> The SMB protocol does not require query directory results to be sorted.

Just how significantly performance is affected depends on several factors, including the number of files, the length of the file names (both properties affect the total size of the file metadata), and how unsorted the results are. When there are lots of files (hundreds or thousands) with large file names that are profoundly out of order, more directory queries of the local file system and more remote directory queries on the remote file server are required.

You can ease this problem by using smaller folders (either in terms of file count or file name size). It also helps if you can increase the extent to which files are recorded in sorted order on the underlying file system.

The scenario affects performance only. Offline file syncing otherwise occurs successfully and correctly.
