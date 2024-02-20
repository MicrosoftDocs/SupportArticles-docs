---
title: Robocopy may report error 1338 or 87
description: Provides a solution to error 1338 or error 87 that occurs when copying files and their associated file security from a CIFS file server.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, sgoad
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Robocopy may report error 1338 (The security descriptor structure is invalid) or error 87 (The parameter is incorrect) when you copy data from CIFS file servers

This article provides a solution to fix error 1338 or error 87 that occurs when you copy files and their associated file security from a CIFS file server.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2459083

## Symptoms

Robocopy may report one the following errors for some files, when copying files and their associated file security from a CIFS file server:

> yyyy/mm/dd hh:mm:ss ERROR 1338 (0x0000053A) Copying NTFS Security to Destination File \<file pathname>  
The security descriptor structure is invalid.

> yyyy/mm/dd hh:mm:ss ERROR 87 (0x00000057) Copying NTFS Security to Destination File \<file pathname>  
The parameter is incorrect.

The error only occurs when copying file security, for example, by specifying `/SEC` or `/COPYALL` on the Robocopy command line. If file security is not copied, all files are copied successfully, and no errors are reported.

## Cause

The error is caused by the CIFS file server returning invalid security information for a file. For example, if the CIFS file server returns a NULL Security ID (SID) for a file's Owner, or a file's Primary Group, when Robocopy tries to copy this information to the destination file, Windows will return error 87 **The parameter is incorrect** or error 1338 **The security descriptor is invalid**. This is by design - file security information in Windows is expected to contain both Owner and Primary Group SIDs.

## Resolution

On the CIFS file server, use the appropriate tools to correct the security information for affected files, and ensure that all affected files have both an Owner SID and a Primary Group SID.

## More information

This is by design - file security information in Windows is expected to contain both Owner and Primary Group SIDs. For more information about Security Descriptors and Access Control Lists:

[How Security Descriptors and Access Control Lists Work](/previous-versions/windows/it-pro/windows-server-2003/cc781716(v=ws.10))
