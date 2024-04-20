---
title: You cannot stop the current process in the Process Monitor
description: This article provides a resolution for the problem where you cannot stop the current process in the Process Monitor.
ms.reviewer: theley, v-erikjo, kyouells
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# You cannot stop the current process in the Process Monitor in Microsoft Dynamics GP 10.0

This article helps you resolve the problem where you cannot stop the current process in the Process Monitor.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866350

## Symptoms

When you run the Process Monitor in Microsoft Dynamics GP 10.0, you cannot stop the current process.

> [!NOTE]
> To start the Process Monitor, click **Process Monitor** on the **Microsoft Dynamics GP** menu.

## Cause

This problem occurs when a process is stuck in the SY01300 (Process Monitor Information) table.

## Resolution

To resolve this problem, clear the Process Monitor Information table in Microsoft SQL Server. To do this, use one of the following methods.

> [!NOTE]
> Before you use one of the following methods, make sure that all users are logged off from Microsoft Dynamics GP.

### Method 1: Use SQL Server Management Studio

If you use Microsoft SQL Server Management Studio, follow these steps:

1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.
2. In the **Connect to Server** dialog box, follow these steps:

   1. In the **Server name** box, type the name of the server that hosts the Microsoft Dynamics GP databases.
   2. In the **Authentication** list, click **SQL Authentication**.
   3. In the **Login** box, type *sa*.
   4. In the **Password** box, type the password for the sa user, and then click **Connect**.

3. On the **File** menu, point to **New**, and then click **Query with Current Connection**.
4. On the **Database** menu, select the company for which the Process Monitor is stuck, and then run the following statement to delete all the records from the SY01300 table:

    ```sql
    DELETE SY01300
    ```

> [!NOTE]
> The Delete statement will only clear the contents of the table. The table will not be deleted from the Database.

### Method 2: Use Microsoft SQL Query Analyzer

If you use Microsoft SQL Query Analyzer, follow these steps:

1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.
2. In the **Connect to SQL Server** dialog box, follow these steps:

   1. In the **SQL Server** box, type the name of the server that hosts the Microsoft Dynamics GP databases.
   2. Click the **SQL Server Authentication** option.
   3. In the **Logon name** box, type *sa*.
   4. In the **Password** box, type the password for the sa user, and then click **OK**.

3. Select the company for which the Process Monitor is stuck on the Database menu, and then run the following statement to delete all the records from the SY01300 table:

    ```sql
    DELETE SY01300
    ```

    > [!NOTE]
    > The Delete statement will only clear the contents of the table. The table will not be deleted from the Database.
