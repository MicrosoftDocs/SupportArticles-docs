---
title: Use Ntdsutil to manage AD files
description: Describes how to manage the Active Directory database file, Ntds.dit, from the command line.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-database-issues-and-domain-controller-boot-failures, csstroubleshoot
ms.subservice: active-directory
---
# How to use Ntdsutil to manage Active Directory files from the command line in Windows Server 2003

This article describes how to manage the Active Directory (AD) database file, Ntds.dit, from the command line.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 816120

## How to start your computer in Directory Services Restore mode

Windows Server 2003 Directory Service opens its files in exclusive mode, which means that the files can't be managed while the server is operating as a domain controller.

To start the server in Directory Services Restore mode, follow these steps:

1. Restart the computer.
2. After the BIOS (Basic Input/Output System) information is displayed, press F8.
3. Use the DOWN ARROW to select **Directory Services Restore Mode(Windows Server 2003 domain controllers only)**, and then press **ENTER**.
4. Use the UP and DOWN ARROWS to select the Windows Server 2003 operating system, and then press **ENTER**.
5. Sign in with your administrative account and password.

## How to install Support Tools and start Ntdsutil

To install Windows Support Tools, follow these steps:

1. Insert the Windows Server 2003 installation CD in the CD-ROM or DVD-ROM drive.
2. Select **Start**, select **Run**, type `drive_letter :\Support\Tools\suptools.msi`, and then press **ENTER**.

To start Ntdsutil, select **Start**, select **Run**, type ntdsutil in the **Open** box, and then press **ENTER**.

> [!NOTE]
> To access the list of available commands, type ?, and then press **ENTER**.

## How to move the database

You can move the Ntds.dit data file to a new folder. If you do so, the registry is updated so that Directory Service uses the new location when you restart the server.

To move the data file to another folder, follow these steps:

1. Select **Start**, select **Run**, type ntdsutil in the **Open** box, and then press **ENTER**.
2. At the Ntdsutil command prompt, type files, and then press **ENTER**.
3. At the file maintenance command prompt, type move DB to **new location** (where **new location** is an existing folder that you've created for this purpose), and then press **ENTER**.
4. To quit Ntdsutil, type quit, and then press **ENTER**.
5. Restart the computer.

## How to move log files

Use the move logs to command to move the directory service log files to another folder. For the new settings to take effect, restart the computer after you move the log files.

To move the log files, follow these steps:

1. Select **Start**, select **Run**, type ntdsutil in the **Open** box, and then press **ENTER**.
2. At the Ntdsutil command prompt, type files, and then press **ENTER**.
3. At the file maintenance command prompt, type move logs to **new location** (where **new location** is an existing folder that you've created for this purpose), and then press **ENTER**.
4. Type quit, and then press **ENTER**.
5. Restart the computer.

## How to recover the database

To recover the database, follow these steps:

1. Select **Start**, select **Run**, type ntdsutil in the **Open** box, and then press **ENTER**.
2. At the Ntdsutil command prompt, type files, and then press **ENTER**.
3. At the file maintenance command prompt, type recover, and then press **ENTER**.
4. Type quit, and then press **ENTER**.
5. Restart the computer.

> [!NOTE]
> You can also use Esentutl.exe to perform database recovery when the procedure described earlier in this article fails (for example, the procedure may fail when the database is inconsistent). To use Esentutl.exe to perform database recovery, follow these steps:

1. Select **Start**, select **Run**, type cmd in the **Open** box, and then press **ENTER**.
2. Type **esentutl /r path \ntds.dit**, and then press **ENTER**. **path** refers to the current location of the Ntds.dit file.
3. Delete the database log files (.log) from the WINDOWS\Ntds folder.
4. Restart the computer.

For additional information about the esentutl.exe utility, at the command prompt, type **esentutl /?**, and then press **ENTER**.

> [!NOTE]
> This procedure involves transaction logs to recover data. Transaction logs are used to make sure that committed transactions are not lost if your computer fails or if it experiences unexpected power loss. Transaction data is written first to a log file, and then it is written to the data file. After you restart the computer after it fails, you can rerun the log to reproduce the transactions that were committed but that were not recorded to the data file.

## How to set paths

You can use the set path command to set the path for the following items:

- Backup: Use this parameter with the set path command to set the disk-to-disk backup target to the folder that is specified by the location variable. You can configure Directory Service to do an online disk-to-disk backup at scheduled intervals.
- Database: Use this parameter with the set path command to update the part of the registry that identifies the location and file name of the data file. Use this command only to rebuild a domain controller that has lost its data file and that isn't being restored by means of typical restoration procedures.
- Logs: Use this parameter with the set path command to update the part of the registry that identifies the location of the log files. Use this command only if you're rebuilding a domain controller that has lost its log files and isn't being restored by means of typical restoration procedures.
- Working Directory: Use this parameter with the set path command to set the part of the registry that identifies Directory Service's working folder to the folder that is specified by the location variable. To run the set path command, follow these steps:

1. Select **Start**, select **Run**, type ntdsutil in the **Open** box, and then press **ENTER**.
2. At the Ntdsutil command prompt, type files, and then press **ENTER**.
3. At the file maintenance command prompt, type **set path object location**, and then press **ENTER**. **object** refers to one of the following items:

    - Backup
    - Database
    - Logs
    - Working Directory
  
    **location** refers to the location (folder) to which you want to set the object identified in the command.

4. Type quit, and then press **ENTER**.
