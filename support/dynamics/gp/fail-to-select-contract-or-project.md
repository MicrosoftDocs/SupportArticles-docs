---
title: Error when you select a contract or project
description: Describes a problem that occurs if an invalid record exists in the PA000001 table. You must remove this invalid record. A resolution is provided.
ms.topic: troubleshooting
ms.reviewer: theley, ppeterso
ms.date: 03/13/2024
ms.custom: sap:Project Accounting
---
# Error message when you select a contract or when you select a project in Microsoft Dynamics GP: "This Contract is being used by another user" or "This Project is being used by another user"

This article provides a solution to an error that occurs when you select a contract or when you select a project in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 940834

## Symptoms

You experience one of the following symptoms in Microsoft Dynamics GP:

- When you select a contract in the Contract Maintenance window, you receive the following error message:

    > This Contract is being used by another user. Please select another Contract Number.

- When you select a project in the Project Maintenance window, you receive the following error message:

    > This Project is being used by another user. Please select another Contract Number.

## Cause

This problem occurs if an invalid record exists in the PA Proj Contr Activity Master table.

> [!NOTE]
> The PA Proj Contr Activity Master table is the PA000001 table.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To resolve this problem, follow these steps:

1. Have all users exit Microsoft Dynamics GP.
2. Select a contract, or select a project.
3. If you still receive one of the error messages that is mentioned in the "Symptoms" section, remove the invalid record from the PA000001 table. To do this, follow these steps:

    1. Back up the company database.

    2. Open one of the following query tools, depending on the version of Microsoft SQL Server that you are using:

        - SQL Query Analyzer
        - SQL Server Management Studio
        - Support Administrator Console

    3. Run the following statement against the company database.

        ```sql
        Select * from PA000001
        ```

        > [!NOTE]
        > The PA000001 table works as an activity table. Therefore, if no user is in the system, you do not expect any records to exist in this table. If a record still exists in this table, the record is an invalid record.

    4. Run the following statement against the company database to remove the invalid record from the PA000001 table.

        ```sql
        Delete PA000001
        ```
