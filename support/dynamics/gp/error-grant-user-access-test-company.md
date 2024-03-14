---
title: Error when you grant a user access to a test company
description: This article provides a resolution for a problem that occurs when a user already exists in the company database.
ms.reviewer: theley, kyouells
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Error message when you try to grant a user access to a test company in Microsoft Dynamics GP (The user could not be added to one or more databases)

This article helps you resolve the problem that occurs when a user already exists in the company database.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 929601

## Symptoms

When you try to grant a user access to a test company in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:

> The user could not be added to one or more databases.

Additionally, if debugging is enabled in the Dex.ini file, the following information is logged in the Dexsql.log file that is generated:

> [Microsoft][ODBC SQL Server Driver][SQL Server]User, group, or role 'XXXX' already exists in the current database.*/

## Cause

This problem occurs if the user already exists in the test company database.

## Resolution

To resolve this problem, follow these steps:

1. Delete the user from the test company database. To do this, follow the appropriate steps.

   - In SQL Server Enterprise Manager, follow these steps:

        1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Enterprise Manager**.
        2. Expand **Microsoft SQL Servers**, expand **SQL Server Group**, and then expand the instance of Microsoft SQL Server.
        3. Expand **Databases**, expand the test company database, and then click **Users**.
        4. In the right Navigation pane, right-click the user in question, and then click **Delete**.
        5. Click **Yes** when you are prompted to delete the user.

   - In SQL Server Management Studio in SQL Server 2005 or in SQL Server 2008, follow these steps:

        1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, or point to **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.
        1. In the **Server name** box, type the name of the instance of SQL Server.
        1. In the **Authentication** list, click **SQL Authentication**.
        1. In the **User name** box, type **sa**.
        1. In the **Password** box, type the password for the sa user, and then click **Connect**.
        1. In the **Object Explorer** area, expand **Databases**, expand the test company database, expand **Security**, and then expand **Users**.
        1. Right-click the user in question, and then click **Delete**.
        1. Verify that the information is correct, and then click **OK**.

2. Grant access to the test company for the user. To do this, follow the appropriate steps.

   For Microsoft Business Solutions - Great Plains 8.0 and for Microsoft Dynamics GP 9.0, follow these steps:

   1. Start Microsoft Business Solutions - Great Plains 8.0 or Microsoft Dynamics GP 9.0.

   2. Log on as the sa user.

   3. On the **Tools** menu, point to **Setup**, point to **System**, and then click **User Access**.

   4. Click the user in question, click to select the **Access** check box, and then click **OK** to grant access to the test company that has live data.

   For Microsoft Dynamics GP 2010 and Microsoft Dynamics GP 10.0, follow these steps:

   1. Start Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010.
   2. Log on as the sa user.

   3. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **System**, and then click **User Access**.

   4. Click the user in question, click to select the **Access** check box, and then click **OK** to grant access to the test company that has live data.

## More information

When a user is granted access to a test company, the user is saved to the SYSUSERS table in the company database. Then, a record of this event is saved to the SY60100 table in the DYNAMICS database.

When the live company database is backed up, the SYSUSERS table is saved together with all the other tables in the live company database. This backup is then restored into the test company. Additionally, the SYSUSERS table is restored into the test company together with all the other tables in the backup.

When you try to grant the user access to the test company, Microsoft Dynamics GP tries to add the user to the SYSUSERS table. In this situation, you receive the error message that is mentioned in the [Symptoms](#symptoms) section because the user already exists in this table.

## References

[KB - Set up a test company that has a copy of live company data for Microsoft Dynamics GP by using Microsoft SQL Server](https://support.microsoft.com/help/871973)
