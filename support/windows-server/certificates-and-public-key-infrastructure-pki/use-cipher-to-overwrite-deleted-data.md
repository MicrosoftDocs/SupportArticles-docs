---
title: Use Cipher.exe to overwrite deleted data
description: Describes how to use Cipher.exe to overwrite deleted data in Windows.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom: sap:Certificates and Public Key Infrastructure (PKI)\Encrypting File System (EFS), csstroubleshoot
---
# Use Cipher.exe to overwrite deleted data in Windows

This article describes how to use Cipher.exe to overwrite deleted data in Windows.

_Original KB number:_ &nbsp; 814599

## Summary

Administrators can use Cipher.exe to encrypt and decrypt data on drives that use the NTFS file system. They can also use it to view the encryption status of files and folders from a command prompt. Cipher.exe has the ability to overwrite data that has been deleted so that it can't be recovered or accessed.

When you delete files or folders, the data isn't initially removed from the hard disk. Instead, the space on the disk that was occupied by the deleted data is *deallocated*. After it's deallocated, the space is available to use when new data is written to the disk. Until the space is overwritten, you can recover the deleted data by using a low-level disk editor or data-recovery software.

When you encrypt plain text files, Encrypting File System (EFS) makes a backup copy of the file. So the data isn't lost if an error occurs during the encryption process. After the encryption is complete, the backup copy is deleted. As with other deleted files, the data isn't removed until it has been overwritten. The version of the Cipher utility, on all currently supported versions of Windows, is designed to prevent unauthorized recovery of such data.

## Use the Cipher security tool to overwrite deleted data

To overwrite deleted data on a volume by using Cipher.exe, use the `/w` switch with the cipher command:

1. Quit all programs.
2. Select **Start** > **Run**, type *cmd*, and then press <kbd>Enter</kbd>.
3. Type `cipher /w:<directory>`, and then press ENTER, where `<directory>` is any folder in the volume that you want to clean. For example, the `cipher /w:C` command causes all deallocated space on drive C to be overwritten. If `<directory>` is a mount point or points to a folder on another volume, all deallocated space on that volume will be cleaned.

Data that isn't allocated to files or folders is overwritten. The data is permanently removed. It can take a long time if you overwrite a large amount of space.

## References

For more information about related topics, see [Cipher.exe Security Tool for the Encrypting File System](https://support.microsoft.com/help/298009).
