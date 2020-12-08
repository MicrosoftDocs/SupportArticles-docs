---
title: 
description: 
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# "Access Is Denied" Error Message Appears When Permissions Are Correct

_Original product version:_ &nbsp; Microsoft Windows Server 2003 Standard Edition (32-bit x86), Microsoft Windows Server 2003 Enterprise Edition (32-bit x86)  
_Original KB number:_ &nbsp; 250494

## Symptoms

When you try to access a file on an NTFS file system volume, you may receive an "access is denied" error message. The file's NTFS permissions indicate that you can access the file.

## Cause

This behavior can occur if another user has encrypted the file. To determine if a file has been encrypted, see the "More Information" section in this article.

## Resolution

To resolve this behavior, the file must be decrypted by the user who encrypted the file, or by the designated Recovery agent. Files that are encrypted by using the Encrypting File System (EFS) are accessible only to the person who encrypted the file, regardless of the other permissions that are on the file.

## Status

This behavior is by design.

## More Information

To determine if a file has been encrypted:

1. Start Windows Explorer, and then click Detail on the View menu to view the details of the folder's contents.
2. Click Choose Columns from the View menu, and then click to select the Attributes check box to add the Attributes column to the current view, and to view the file attributes.

If there is an "E" in the Attributes column for that file, the file is encrypted.
