---
title: The execution of a SSIS package stops responding
description: Describes a problem in which the execution of a Microsoft SSIS package stops responding if you enable DTC transactions for the package and enable the ValidateExternalMetadata property for a component in a data flow task.
ms.date: 09/02/2020
ms.custom: sap:Integration Services
ms.reviewer: kayokon, hisashik, ksaito
---
# The execution of an SSIS package stops responding when you enable DTC transactions for a package in Microsoft SQL Server

This article helps you resolve the problem in which the execution of a Microsoft SQL Server Integration Services (SSIS) package stops responding if you enable DTC transactions for the package and enable the `ValidateExternalMetadata` property for a component in a data flow task.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2253391

## Symptoms

Consider the following scenario:

- You create an SSIS package in SQL Server.
- The SSIS package contains a data flow task and some other tasks.
- The `TransactionOption` property of the SSIS package is set to Required to use DTC transactions.
- The other tasks run in a DTC transaction before the execution of the data flow task.
- You add a component to the data flow task.
- The `ValidateExternalMetadata` property of a data flow component is set to True.
- The data flow task contains an OLE DB Destination component that has the data access mode set to Table or view, or to Table name or view name variable.

When you run the package in this scenario, the execution stops responding. Additionally, if you debug the SSIS package in Visual Studio, you receive messages that resemble the following in the **Progress** view:

> SSIS package "Package.dtsx" starting.
>
> Information: 0x4004300A at Data Flow Task, DTS.Pipeline: Validation phase is beginning.
Information: 0x4001100A at Package: Starting distributed transaction for this container.
Information: 0x4004300A at Data Flow Task, DTS.Pipeline: Validation phase is beginning.

## Cause

This problem occurs because the connection in the data flow is not enrolled in the DTC transaction. This causes the execution of the `sp_cursoropen` stored procedure to be blocked. This is a design feature because a connection cannot be enrolled in a DTC transaction during the validation process. In the scenario that is described in the [Symptoms](#symptoms) section, the validation process of a data flow component is blocked when you run the package because the connection in the data flow task has not been enrolled in the DTC transaction.

## Resolution

To resolve this problem, use one of the following methods:

- Set `ValidateExternalMetadata` for all component in the data flow task to **False**.
- Set the data access mode of the OLE DB Destination component to one of the following modes:

  - Table or view - fast load  
  - Table name or view name variable - fast load
  - SQL command

## More information

The Table or View  data access mode is blocked but other data access modes are not blocked because the different commands issued by the data provider for each data access mode. To obtain more details about this issue, use SQL Server Profiler to see the different commands issued by the data provider.

- For more information about how to use SQL Server Profiler, see [SQL Server Profiler Templates and Permissions](/sql/tools/sql-server-profiler/sql-server-profiler-templates-and-permissions).

- For more information about how to troubleshoot SSIS packages, see [Troubleshooting Package Development](/previous-versions/sql/sql-server-2005/ms137625(v=sql.90)).
