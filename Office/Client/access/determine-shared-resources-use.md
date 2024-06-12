---
title: Determine who is using the shared resources
description: Discusses how to use the OS utilities to determine who is using the shared resources on your computer when an Access database is opened in exclusive mode.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 06/06/2024
---
# Determine who opened an Office Access database in the exclusive mode

_Original KB number:_ &nbsp; 824274

> [!NOTE]
> This article applies only to a Microsoft Access database (.mdb/.accdb). Requires basic macro, coding, and interoperability skills.

## Summary

In a Microsoft Office Access environment, you may not be able to determine who opened an Access database in the exclusive mode. However, you can use the operating system utilities to determine who is using shared resources on your computer.

## More Information

When you open an Access database, Access typically creates a lock file with the same name as the database file. This lock file has a .ldb/.laccdb extension, depending on what type of file is being opened (.mdb/.accdb). The .ldb/.laccdb file contains the information about who opened the Access database and about the computer that was used to open the Access database. However, when a user opens an Access database in the exclusive mode, Access does not create a lock file with a .ldb/.laccdb extension. Therefore, Access cannot use the .ldb/.laccdb file to determine who opened the database in the exclusive mode. If you try to open an Access database and another user has already opened the database in the exclusive mode, you receive one of the following error messages:

> Could not use '\<path>\\<database.mdb>'; file already in use.

> Could not use '\<path>\\<database.accdb>'; file already in use.

You do not receive any information about who opened the Microsoft Office Access database in the exclusive mode or about the computer that was used to open the Microsoft Office Access database in the exclusive mode.

You can use utility software, such as the Computer Management utility or the Server Manager utility, to determine who has an Access database open in the exclusive mode and to determine what computer has an Access database open in the exclusive mode.

For more information about how to view shared resources by using the Computer Management utility, follow these steps.

> [!NOTE]
> Because there are several versions of Microsoft Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.

1. Click **Start**.
2. Click **Help and Support**.
3. In the **Search** box, type Computer Management.
4. Click **Start Searching** to view the topics.
5. Search the Computer Management utility Help Index for "Viewing Information About Shared Resources."

If your computer runs the Microsoft Windows 2000 operating system, the Server Manager utility may be available as an executable file (Srvmgr.exe) in the **Installation Drive**: \WINNT\SYSTEM32 folder on your computer. If the Server Manager utility is not available, install the Server Manager utility and then monitor the concurrent users of the computer resources.

## References

For more information about using the Server Manager utility to monitor the concurrent users of the computer resources, see the "Viewing: User Sessions" topic in the Server Manager Help Index.

For additional information about .ldb files, see the following article

[Introduction to lock files (.laccdb and .ldb) in Access](lock-files-introduction.md)
