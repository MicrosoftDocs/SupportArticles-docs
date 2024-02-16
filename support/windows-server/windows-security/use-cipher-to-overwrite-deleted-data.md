---
title: Use Cipher.exe to overwrite deleted data
description: Describes how to use Cipher.exe to overwrite deleted data in Windows Server 2003.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
---
# Use Cipher.exe to overwrite deleted data in Windows Server 2003

This article describes how to use Cipher.exe to overwrite deleted data in Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 814599

## Summary

Administrators can use Cipher.exe to encrypt and decrypt data on drives that use the NTFS file system. They can also use it to view the encryption status of files and folders from a command prompt. The version of Cipher.exe that's included with Windows Server 2003 includes the ability to overwrite data that has been deleted so that it can't be recovered or accessed.

When you delete files or folders, the data isn't initially removed from the hard disk. Instead, the space on the disk that was occupied by the deleted data is *deallocated*. After it's deallocated, the space is available to use when new data is written to the disk. Until the space is overwritten, you can recover the deleted data by using a low-level disk editor or data-recovery software.

When you encrypt plain text files, Encrypting File System (EFS) makes a backup copy of the file. So the data isn't lost if an error occurs during the encryption process. After the encryption is complete, the backup copy is deleted. As with other deleted files, the data isn't removed until it has been overwritten. The Windows Server 2003 version of the Cipher utility is designed to prevent unauthorized recovery of such data.

## Use the Cipher security tool to overwrite deleted data

> [!NOTE]
> The `cipher /w` command does not work for files that are smaller than 1 KB. Therefore, make sure that you check the file size to confirm whether is smaller than 1 KB. This issue is scheduled to be fixed in longhorn.

To overwrite deleted data on a volume by using Cipher.exe, use the `/w` switch with the cipher command:

1. Quit all programs.
2. Select **Start** > **Run**, type *cmd*, and then press ENTER.
3. Type `cipher /w: folder`, and then press ENTER, where **folder** is any folder in the volume that you want to clean. For example, the `cipher /w:c:\test` command causes all deallocated space on drive C to be overwritten. If `C:\folder` is a Mount Point or points to a folder on another volume, all deallocated space on that volume will be cleaned.

Data that isn't allocated to files or folders is overwritten. The data is permanently removed. It can take a long time if you overwrite a large amount of space.

## References

For more information about related topics, see [Cipher.exe Security Tool for the Encrypting File System](https://support.microsoft.com/help/298009).
