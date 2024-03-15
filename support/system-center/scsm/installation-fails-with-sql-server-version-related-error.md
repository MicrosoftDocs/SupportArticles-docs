---
title: Can't specify SQL Server to host the Service Manager database
description: Fixes an issue where you can't specify the SQL Server to host the Service Manager database when you install or upgrade System Center 2012 Service Manager.
ms.date: 03/14/2024
ms.reviewer: khusmeno
---
# System Center Service Manager installation fails with SQL Server version-related error

This article helps you fix an issue where you can't specify the SQL Server to host the Service Manager database when you install or upgrade System Center 2012 Service Manager.

_Original product version:_ &nbsp; System Center 2012 Service Manager  
_Original KB number:_ &nbsp; 2719717

## Symptoms

While either installing a fresh copy of System Center 2012 Service Manager or upgrading System Center 2012 Service Manager, you receive the following error message after specifying the SQL Server to host the Service Manager database:

> The SQL Server name is not running version SQL Server 2008 SP2 or SQL Server 2008 R2. Please update it to the newest version and retry.

> [!NOTE]
> The server in question already has SQL Server 2008 R2, SQL Server 2008 SP2, or a later version installed.

## Cause

This issue can occur if there is an issue with the SQL Server MOF file.

## Resolution

To resolve this issue, recompile the MOF file:

1. Open a command prompt with Administrator rights on the SQL Server where you want to install the Service Manager databases.
2. Change to the following directory:

   `C:\Program Files (x86)\Microsoft SQL Server\100\Shared`

3. At this location, execute the following command:

   ```console
   mofcomp sqlmgmproviderxpsp2up.mof
   ```

   The successful completion of the above command should generate output similar to the following:

   > Microsoft (R) MOF Compiler Version 6.1.7600.16385  
   > Copyright (c) Microsoft Corp. 1997-2006. All rights reserved.  
   > Parsing MOF file: sqlmgmproviderxpsp2up.mof  
   > MOF file has been successfully parsed  
   > Storing data in the repository...  
   > Done!

Once complete, restart the Service Manager installation.
