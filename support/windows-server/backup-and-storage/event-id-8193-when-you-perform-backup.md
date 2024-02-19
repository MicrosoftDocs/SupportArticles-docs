---
title: Event ID 8193 when you perform a backup
description: Describes an issue that triggers event ID 8193 when you try to perform a VSS backup in Windows Server 2012 and earlier versions of Windows. A resolution is provided.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
---
# "VSS Error XML document is too long. hr = 0x80070018" error when you perform a backup in Windows

This article provides a solution to an error that occurs when you perform a backup in Windows.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3098315

## Symptoms

When you perform a backup in Windows Server 2012 and earlier (back to Windows Server 2008), one of the following errors is logged in the Application log:

> Log Name: Application  
Source: VSS  
Event ID: 8193  
Level: Error  
Description:  
Volume Shadow Copy Service error: Unexpected error calling routine  
XML document is too long. hr = 0x80070018, The program issued a command but the command length is incorrect.  
>
> Operation: Writer Modifying Backup Document
>
> Context: Execution  
Context: Requestor  
Writer Instance ID: {14BE9B90-62D7-4A2D-B57F-53D21EAB0789}

## Cause

When a Volume Shadow Copy Service (VSS)-based backup is performed, each of the subscribed VSS writers is queried for a list of components. The problem that's described in the [Symptoms](#symptoms) section occurs when that list generates a metadata file that's larger than the size limitation.

Common causes:

- Too many files in the TemporaryInternetFiles directory-specifically, in C:\\Windows\\Microsoft.NET\\Framework64\\v2.0.50727\\TemporaryInternetFiles. This causes the System Writer to hit the size limit of the VSS metadata file.
- VSS Writer has added too many components to its metadata file.

## Resolution

If there are too many files in TemporaryInternetFiles, back up and then delete the files from the C:\\Windows\\Microsoft.NET\\Framework64\\v2.0.50727\\TemporaryInternetFiles location. Then, the system writer should be able to complete without errors.

If you can't identify the writer that's causing the failure, collect a sample of the writer metadata document, and then review the components for each writer.

To collect VSS writer metadata, follow these steps:

1. From an administrative command prompt, run the following commands:

    ```console
    diskshadow /l
    C:\Metadata.txt
    list writers detailed
    Exit
    ```

2. After the file that's generated is collected, review and count each writer's components.
3. After the application writer is identified, reduce the number of components until the limitation is no longer exceeded.

Example of application components

Each component is represented by the lines between the "+ Component" name and the "- Component Dependencies:" reference. And each is counted as one component.

Hyper-V example

> "Microsoft Hyper-V VSS Writer:\006F792F-99EA-4A4A-A241-F8853A3B0CB6"  
\- Name: 006F792F-99EA-4A4A-A241-F8853A3B0CB6  
\- Logical path:  
\- Full path: \\006F792F-99EA-4A4A-A241-F8853A3B0CB6  
\- Caption: Offline\\i$  
\- Type: VSS_CT_FILEGROUP [2]  
\- Is selectable: TRUE  
\- Is top level: TRUE  
\- Notify on backup complete: FALSE  
\- Components:  
\- File List: Path = D:\\Hyper-V\\Virtual Machines\\, Filespec = 006F792F-99EA-4A4A-A241-F8853A3B0CB6.xml  
\- File List: Path = D:\\Hyper-V\Snapshots, Filespec = A544BB47-0349-4EED-ABDC-DFE66CAF2927.xml  
\- File List: Path = D:\\Hyper-V\\Snapshots\\A544BB47-0349-4EED-ABDC-DFE66CAF2927, Filespec = *  
\ Paths affected by this component:  
\- D:\\Hyper-V\\Snapshots  
\- D:\\Hyper-V\\Snapshots\\A544BB47-0349-4EED-ABDC-DFE66CAF2927  
\- D:\\Hyper-V\\Virtual Machines\\  
\- Volumes affected by this component:  
\- \\\\?\\Volume{9710864d-1433-11e5-93ef-806e6f6e6963}\\ [D:\\]

SQL example:

> \- Component Dependencies:SQL - + Component "SqlServerWriter:\\SQL2012\\model"  
\- Name: model  
\- Logical path: SQL2012  
\- Full path: \\SQL2012\\model  
\- Caption:  
\- Type: VSS_CT_FILEGROUP [2]  
\- Is selectable: TRUE  
\- Is top level: TRUE  
\- Notify on backup complete: TRUE  
\- Components:  
\- File List: Path = C:\\Program Files\\Microsoft SQL Server\\MSSQL11.MSSQLSERVER\\ MSSQL\DATA, Filespec = model.mdf  
\- File List: Path = C:\\Program Files\\Microsoft SQL Server\\MSSQL11.MSSQLSERVER\\MSSQL\\DATA, Filespec = modellog.ldf  
\- Paths affected by this component:  
\- C:\\Program Files\\Microsoft SQL Server\\MSSQL11.MSSQLSERVER\\MSSQL\\DATA  
\- Volumes affected by this component:  
\- \\\\?\\Volume{e18ba371-5b9e-11e4-9400-806e6f6e6963}\\ [C:\\]  
\- Component Dependencies:
