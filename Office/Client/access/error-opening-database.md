---
title: Unable to open an Access database on a server
description: Fixes an issue in which you may receive a file already in use error message when you open an Access database.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: chriswy
appliesto: 
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---
# "File already in use" error when you try to open an Access database that's located on a server

_Original KB number:_ &nbsp; 289681

> [!NOTE]
> This article applies only to a Microsoft Access database (.accdb and .mdb). Requires knowledge of the user interface on single-user computers.

## Symptoms

When you try to open a database that is located on a server, you may receive the following error message:

> Couldn't use \<filename>; file already in use.

## Cause

If doesn't have the Create permissions for the folder in which the database is located, the Microsoft Jet database engine can't create the locking information file. The file is necessary for multiple users to open the database. So if a corresponding file doesn't already exist, a user who doesn't have the Create permissions opens the database exclusively.

> [!NOTE]
> The locking information file is:
>
> - *.ldb in Access 2003 and in earlier versions of Access
> - *.laccdb in Access 2007/2010

## Workaround

To prevent this behavior, make sure that all users who open the database have the Read, Write, and Create permissions for the folder in which the database is located.

Additionally, if you're using a security-enhanced Access database, make sure that the users who open the database also have the Read and Write permissions on the folder. The folder contains the workgroup information (.mdw) file.

## More Information

In order to open a database in shared mode, the Microsoft Jet database engine must be able to create a locking information file (`*.ldb`, or `*.laccdb`) in the same folder as the database itself.

For more information about the .ldb files, click Microsoft Access Help on the **Help** menu, type *sharing access database* in the Office Assistant or the Answer Wizard, and then click **Search** to view the content.

## References

For more information about .ldb files, see the following article:

[Introduction to lock files (.laccdb and .ldb) in Access](lock-files-introduction.md)
