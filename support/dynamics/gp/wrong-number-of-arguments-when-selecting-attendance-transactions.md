---
title: Wrong number of arguments error when selecting Attendance Transactions
description: Describes a problem that occurs when you select  Attendance Transactions in Navigation Pane after upgrading to Microsoft Dynamics GP 9.0.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Unhandled script exception: Wrong number of arguments" error when selecting Attendance Transactions in Navigation Pane after upgrading

This article provides a resolution for the issue that you receive an Unhandled script exception when selecting Attendance Transactions in Navigation Pane after upgrading to Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 923961

## Symptoms

Consider the following scenario:

- You upgrade to Microsoft Dynamics GP 9.0.
- You start Microsoft Dynamics GP 9.0.
- In the Navigation Pane, you select **Attendance Transactions** in the **HR & Payroll Lists** section.

In this scenario, you receive the following error message:

> Unhandled script exception: Wrong number of arguments passed to system 2808 from script 'VirtualField_AddToWindow'.

## Resolution

To resolve this problem, delete a record from the SY07210 table. To do this, follow these steps:

1. Follow the appropriate step, depending on whether you are using Microsoft SQL Server or Microsoft SQL Server Desktop Engine (MSDE):

   - If you are using SQL Server, start SQL Query Analyzer. To do this, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
   - If you are using MSDE, start the Support Administrator Console. To do this, select **Start**, point to **Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

2. Run the following statement against the DYNAMICS database.

    ```sql
    Delete SY07210 where DICTID = 414
    ```

3. Verify that you do not receive the error message that is mentioned in the Symptoms section. To do this, follow these steps:

   1. In the Navigation Pane, select **HR & Payroll Lists**.
   2. Select **Attendance Transactions**.
