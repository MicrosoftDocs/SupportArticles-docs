---
title: Error message after you restore a SQL Server 2008 32-Bit Dynamics POS 2009 database to a SQL Server 2008 64-Bit instance and try to run any report 
description: This article describes how to resolve the error message that states that execution of user code in .NET Framework is disabled. Provides a resolution.
ms.reviewer: randyh
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Execution of user code in .NET Framework is disabled" error after restoring a SQL Server 2008 32-Bit Dynamics POS 2009 database to a 64-Bit instance and running any report

This article provides a resolution for the **Execution of user code in .NET Framework is disabled** error that occurs after you restore a SQL Server 2008 32-Bit Microsoft Dynamics POS 2009 database to a SQL Server 2008 64-Bit instance and run any report.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2120850

## Symptoms

You receive the following error message after you restore a SQL Server 2008 32-Bit Microsoft Dynamics POS 2009 database to a SQL Server 2008 64-Bit instance and try to run any report:

> Execution of user code in the .NET Framework is disabled. Enable "clr enabled" configuration option.

## Cause

This error is generated because the CLR assembly is not enabled during the restore.

## Resolution

To enable the CLR assembly, follow these steps:

1. Open SQL Server Management Studio.
2. Connect to the POS 2009 instance you are using.
3. Right-click on the database and select **New Query**.
4. Paste the following SQL statement into the New Query window and run the following script:

    ```sql
    EXEC sp_configure 'clr enabled', 1; RECONFIGURE WITH OVERRIDE;
    ```

5. Press F5 to run the SQL Statement.
