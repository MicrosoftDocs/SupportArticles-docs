---
title: Event ID 1814 is logged in the System log
description: This article provides resolutions for the problem where SQL Server fails to start and Event ID 1814 is logged in the System log.
ms.date: 01/28/2020
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: ramakoni
---
# Event ID 1814 and SQL Server doesn't start

_Applies to:_ &nbsp; SQL Server

## Symptoms

If the Microsoft SQL Server service can't create the Tempdb file during startup, the service doesn't start when you use Service Control Manager, and you receive the following error message:

> Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event log.  
If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 1814.

## Cause

This problem can occur because of the following reasons:

- The hard disk that was hosting Tempdb was removed or the drive letter changed for some reason.
- There are space constraints at the OS layer.

## Resolution

1. Open the Application log, and verify that you see error message entries that resemble the following:

    ```output
    Log Name:      Application  
    Source:        MSSQLSERVER  
    Date:          <Datetime>  
    Event ID:      5123  
    Task Category: Server  
    Level:         Error  
    Keywords:      Classic  
    User:          N/A  
    Computer:      <Server name>  
    Description:
    CREATE FILE encountered operating system error 3(The system cannot find the path specified.)
    while attempting to open or create the physical file <FilePath>.

    Log Name:      Application  
    Source:        MSSQLSERVER  
    Date:          <Datetime>  
    Event ID:      17204  
    Task Category: Server  
    Level:         Error  
    Keywords:      Classic  
    User:          N/A  
    Computer:      <Server name>  
    Description:
    FCB::Open failed: Could not open file <FilePath> for file number 1.  OS error: 3(The system cannot find the path specified.).

    Log Name:      Application  
    Source:        MSSQLSERVER  
    Date:          <Datetime>  
    Event ID:      1814  
    Task Category: Server  
    Level:         Information  
    Keywords:      Classic  
    User:          N/A
    Computer:      <Server name>  
    Description:
    Could not create tempdb. You may not have enough disk space available.
    Free additional disk space by deleting other files on the tempdb drive and then restart SQL Server.
    Check for additional errors in the operating system error log that may indicate why the tempdb files could not be initialized.
    ```

1. To resolve the problem, move the Tempdb file to a different location by using the procedure that's mentioned in the **Failure Recovery Procedure** section of [Move System Databases](/sql/relational-databases/databases/move-system-databases#Failure).
