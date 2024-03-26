---
title: Description of LDB File
description: Describes LDB files that are Microsoft Access lock information files.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft Access
ms.date: 03/31/2022
---

# What is an LDB File?

LDB files are Microsoft Access lock information files. An ".LDB" file is created when an Access database is opened/accessed by a user - the file is created with the same name as the Access database, but with an ".LDB" extension. The file is used to keep track of all users that are currently accessing the database.

Because FRx uses Access databases for most of its normal operations, ".LDB" files are created in the FRx directory when the Designer, Report Launcher, or Queue Monitor applications are in use. Although ".LDB" files are typically removed when all users have closed FRx, one or more ".LDB" files may occasionally be left behind. When this occurs, these files are safe to delete - they will be re-created the next time a user launches FRx. The ".LDB" file may be used to determine which users are logged into FRx. This is useful when users must be asked to exit for a task that requires the FRx databases to be available.

To view the file, open it in Notepad. When viewing an ".LDB" file for an FRx database, all users will be shown logged in as "admin" - the computer name should be used to determine which users are currently accessing the file. If the ".LDB" file contains a computer name for a user that has already closed FRx, but the file cannot be deleted, it may be necessary to disconnect the user from the file (this can be done at the server from the Windows Control Panel). If the file is still locked after disconnecting all users, the server may need to be restarted.