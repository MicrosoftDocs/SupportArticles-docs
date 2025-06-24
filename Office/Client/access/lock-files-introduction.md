---
title: Description of Access lock files (laccdb and ldb)
description: Describes automatic creation and deletion, required permissions, contents, and usage for lock files (laccdb and ldb).
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 111390
  - CSSTroubleshoot
ms.reviewer: denniwil
appliesto: 
  - Access
search.appverid: MET150
ms.date: 05/26/2025
---

# Introduction to lock files (laccdb and ldb) in Access

## Introduction

The `.laccdb` or `.ldb` file plays an important role in the multi-user scheme of the Microsoft Access database engine. The `.laccdb` or `.ldb` file is used to determine which records are locked in a shared database and by whom. The `.laccdb` file is used with .accdb databases and the `.ldb` file is used with ".mdb" databases. Both the `.laccdb` and `.ldb` files are commonly referred as lock files.

## Automatic lock file creation and deletion

For every database that's opened for shared use, a `.laccdb` or `.ldb` file is created to store computer and security names and to place extended byte range locks. The lock file always has the same name as the opened database, and it's located in the same folder as the opened database. For example, if you open (for shared use) the Northwind.accdb sample database in `C:\users\<username>\documents\`, a file named Northwind.laccdb is automatically created in the same documents folder.

Whenever the last user closes a shared database, the lock file is deleted. The only exceptions are when a user doesn't have delete rights or when the database is marked as corrupted. Then, the lock file isn't deleted because it contains information about who was using the database at the time the database was marked as corrupted.

## Required folder privileges

If you plan to share a database, the database file should be located in a folder where users have read, write, create, and delete privileges. Even if you want users to have different file privileges (for example, some read-only and some read-write), all users sharing a database must have read, write, and create permissions to the folder. You can, however, assign read-only permissions to the .accdb or .mdb file for individual users while still allowing full permissions to the folder.

> [!NOTE]
> If a user opens a database with exclusive access (by clicking the arrow to the right of the **Open** button, and then clicking **Open Exclusive**), record locking is not used. Therefore, Microsoft Access doesn't attempt to open or create a lock file. If the database is always opened for exclusive use, a user needs to have only read and write privileges to the folder.

## The lock file contents

For each person who opens a shared database, the Access database engine writes an entry in the `.laccdb` or `.ldb` file of the database. The size of each entry is 64 bytes. The first 32 bytes contain the computer name (such as JohnDoe). The second 32 bytes contain the security name (such as Admin). The maximum number of concurrent users that the Access database engine supports is 255. Therefore, the lock file size is never larger than 16 kilobytes.

> [!NOTE]
> Although a file-server solution can support up to 255 simultaneous users, if the users of your solution will be frequently adding data and updating data, it is a good idea for an Access file-server solution to support no more than 25 to 50 users. For more information, see [Chapter 1: Understanding Microsoft Access 2000 Client/Server Development](/previous-versions/office/developer/office2000/aa139930(v=office.10)).

When a user closes a shared database, the user's entry isn't removed from the lock file. However, the user's entry may be overwritten when another user opens the database. This means that you can't use the lock file alone to determine who is currently using the database.

## The lock file usage

The Access database engine uses the lock file information to prevent users from writing data to pages or records that other users have locked and to determine who has other pages or records locked. If the Access database engine detects a lock conflict with another user, it reads the lock file to get the computer and security name of the user who has the file or record locked.

In most lock conflict situations, you receive a generic "Write conflict" message that allows you to save the record, copy it to the Clipboard, or drop the changes that you made. In some circumstances, however, you receive the following error message:

> Couldn't lock table \<table name>; currently in use by user \<security name> on computer \<computer name>.

> [!NOTE]
> The state of the information in the lock file has no bearing on the state of the database. If a lock file becomes corrupted, everything in the database should still work correctly. However, you may see scrambled text instead of user names in any lock conflict messages.

With Microsoft Visual Basic for Applications, you can output a list of users who are logged into a specific database. For more information about how to do this and sample code, see [How to determine who is logged on to a database by using Microsoft Jet UserRoster in Access](determine-who-is-logged-on-to-database.md).
