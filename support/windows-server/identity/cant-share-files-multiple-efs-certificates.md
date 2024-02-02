---
title: Can't share files that have multiple EFS certificates
description: Describes an issue that occurs when you enable users to share files that are encrypted by using multiple EFS certificates.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, lindakup
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
ms.subservice: active-directory
---
# You can't share files that have multiple EFS certificates

This article describes an issue where you can't share files that are encrypted by using multiple EFS certificates.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 3118620

## Symptoms

Consider the following scenario:

- You would like users to share files that were encrypted by using multiple Encrypting File System (EFS) certificates.
- Users U1 and U2 have valid EFS certificates.
- File F1 exists on a computer on which EFS is enabled, and users U1 and U2 have read and write permissions on the file.
- User U1 follows these steps to encrypt file F1:
  1. Locate file F1 on disk.
  2. Right-click on file F1.
  3. Click **Properties**.
  4. Click **Advanced**.
  5. Select **Encrypt contents to secure data**.
  6. Click **OK**.
  7. Click **Apply**.

- User U1 creates file sharing for file F1 by adding the appropriate EFS certificate for user U2 to file F1.
- Users U1 and U2 follow these steps to access file F1:
  1. Locate file F1 on disk.
  2. Right-click file F1.
  3. Click **Properties**.
  4. Click **Advanced**.
  5. Click **Details**.
  6. Click **Add**.
  7. Select the user whom you want to add.
  8. Click **OK**.

- User U1 or user U2 changes file F1.

In this scenario, EFS metadata is not maintained, and only the current user can decrypt the file. However, you expect that EFS metadata will be maintained and that the user whom you added in step 7 is still there.

## Cause

If an application opens and saves a file by using the `replacefile()` API, and if that file was encrypted by using EFS when more than one certificate was present, the resulting file will contain only the certificate of the user who saved the file. This behavior is by design.

## Status

This method of sharing encrypted files is unsupported at this time.
