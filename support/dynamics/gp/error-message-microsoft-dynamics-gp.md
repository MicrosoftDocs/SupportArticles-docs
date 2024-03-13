---
title: Error message in Microsoft Dynamics GP
description: This article provides a resolution for the problem where you receive the error message (Stored Procedure XXXX returned the following results).
ms.reviewer: kyouells
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error message in Microsoft Dynamics GP (Stored Procedure XXXX returned the following results. DBMS: 12, Microsoft Dynamics GP: 0)

This article helps you resolve the problem where you receive the error message (**Stored Procedure XXXX returned the following results**).

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852594

## Symptoms

In Microsoft Dynamics GP, you receive the following error message:

> Stored Procedure **XXXX** returned the following results. DBMS: 12, Microsoft Dynamics GP: 0

> [!NOTE]
> **XXXX** is a placeholder for the name of a stored procedure.

## Cause

This problem occurs if a temporary table cannot be created correctly on the server that is running Microsoft SQL Server.

## Resolution

To resolve this problem, follow these steps:

1. Have all users exit Microsoft Dynamics GP.
2. Stop the SQL Server service, and then start the SQL Server service to clear the temporary tables in the tempdb database. To do this, follow these steps:

   - If you use SQL Server Management Studio, follow these steps:

      1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005 or 2008**, and then click **SQL Server Management Studio**.
      2. In the Connect to Server window, follow these steps:

         1. In the **Server name** box, type the name of the server that is running SQL Server.

         2. In the **Authentication** box, click **SQL Authentication.**  

         3. In the **Login** box, type *sa*.

         4. In the **Password** box, type the password for the sa user, and then click **Connect**.

      3. In the Object Explorer pane, right-click the appropriate instance of SQL Server, and then click **Stop**.

      4. Right-click the appropriate instance of SQL Server again, and then click **Start**.

   - If you use SQL Server Enterprise Manager, follow these steps:

       1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Enterprise Manager**.

       2. Right-click the appropriate instance of SQL Server, and then click **Stop**.

       3. Right-click the appropriate instance of SQL Server again, and then click **Start**.

   - If you do not have SQL Server Management Studio or SQL Server Enterprise Manager, follow these steps:

      1. Click **Start**, click **Run** and then type *services.msc*.

      2. Click the appropriate instance of SQL Server, and then click **Stop**.

      3. Right-click the appropriate instance of SQL Server again, and then click **Start**.

> [!NOTE]
>
> - Microsoft Dynamics GP 2010 is not supported with SQL Server 2000.
> - Microsoft Dynamics GP 9.0 is not supported with SQL Server 2008.
