---
title: Permission error when you use a volume mount point
description: This article provides a resolution for the problem that occurs when you assign a root folder of the volume mount point to the SQL Server system folders.
ms.date: 11/04/2020
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: mide
---
# Permission error occurs when you use a volume mount point in SQL Server Setup

This article helps you resolve the problem that occurs when you assign a root folder of the volume mount point to the SQL Server system folders.

_Original product version:_ &nbsp; SQL Server, Windows Server 2012 Datacenter, Windows Server 2012 Datacenter, Windows Server 2012 Standard, Windows Server 2012 Standard  
_Original KB number:_ &nbsp; 2867841

## Symptoms

When you install Microsoft SQL Server on Windows Server 2012, the installation fails if you assign a SQL Server system folder (such the DATA or LOG files location) to a volume mount point root folder. Additionally, you receive the following error message:

> While updating permission setting for folder 'T:\DATA\System Volume Information' the permission setting update failed for file 'T:\DATA\System Volume Information\ResumeKeyFilter.Store'. The folder permission setting were supposed to be set to 'D:P(A;OICI;FA;;;BA)(A;OICI;FA;;;SY)(A;OICI;FA;;;CO)(A;OICI;FA;;;S-1-5-80-3880718306-3832830129-1677859214-2598158968-1052248003)'.

## Cause

This problem occurs because SQL Server Setup does not have permission to access the `\System Volume Information\ResumeKeyFilter.Store` file.

## Resolution

To resolve this problem, create a subfolder in the volume mount point, and assign the new subfolder to the SQL Server system folders.

## More information

When SQL Server Setup configures SQL Server system folders, Setup tries to change the permissions of folders and the files that are in those folders. But if you set the system folders to a root folder of the volume mount point, the `\System Volume Information\ResumeKeyFilter.Store` file is created on Windows Server 2012. SQL Server Setup cannot change the permissions of `ResumeKeyFilter.Store` because SYSTEM is the only permission that is set on this file.
