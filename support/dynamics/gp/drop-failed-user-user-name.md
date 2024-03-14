---
title: Drop failed for User user name
description: Provides a solution to an error that occurs when you try to grant a user access to or remove user access from a company in Microsoft Dynamics GP.
ms.reviewer: theley, kyouells
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "This user cannot be removed from one or more databases" or "Drop failed for User" Error message when you try to grant a user access to or remove user access from a company in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to grant a user access to or remove user access from a company in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 919723

## Symptoms

When you try to grant a user access to a company in Microsoft Dynamics GP, you receive the following error message:
> This user cannot be removed from one or more databases.

When you try to remove user access from a company, you receive the following error message:
> Drop failed for User '**user name**'.

Additionally, if debugging is enabled in the Dex.ini file, the following information is logged in the Dexsql.log file that is generated:

> [Microsoft][ODBC SQL Server Driver][SQL Server]The database principal owns a schema in the database, and cannot be dropped.*/

You experience this problem after you upgrade Microsoft Dynamics GP databases to SQL Server 2005/SQL Server 2008 or if a user owns one or more schemas.

## Cause

This problem occurs if the Microsoft Dynamics GP user that you're attempting to remove from the company database owns a schema within that company database

> [!NOTE]
> A schema is not used for all Microsoft Dynamics GP users.

## Resolution

To resolve this problem, follow these steps:

1. On the computer that is running SQL Server 2005 or SQL Server 2008, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005** or **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
2. Sign in to SQL Server by using the **sa** user name together with the corresponding password.
3. On the **File** menu, point to **New**, and then select **Database Engine Query**.
4. Download the MassDropUserSchemas.sql script.
5. Paste the contents of the script into a blank query window.
6. On the **Query** menu, select **Execute**.
7. Sign in to Microsoft Dynamics GP.
8. Use the appropriate method:
   - In Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 2010, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **System**, and then select **User Access**.
   - In Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **System**, and then select **User Access**.
9. Grant the user access to a Microsoft Dynamics GP company. Or, remove the user access from the Microsoft Dynamics GP company.

If the same error occurs, there could be one or more schemas that are owned by that user. Follow these steps to verify that the user doesn't own another schema:

1. Sign in to the SQL Server Management Studio. To do it, follow the steps one and two of the previous processes.
2. In the Object Explorer window, expand **Databases**, expand **\<Database name>**, expand **Security**, and expand **Users**.
3. Right-click on the user and then select **Properties**.
4. On the first page that appears, there are two boxes with items. It can be selected. The items are labeled as **Schemas owned by this user** and **Database role membership**. Note the name of the schema.
5. Select **Cancel** to close the Properties window.
6. In the **Object Explorer** pane, collapse the Users folder and expand the Schemas folder.
7. Right-click on the schema noted from step 4 and select **Properties**. The page **Schema Properties-\<SchemaName>** should appear.
8. Change the **Schema Owner** from the current user to the new user name. For example, if the schema name is DYNGRP and the owner is different, change the owner name to DYNGRP.
9. Follow the steps 7-9 of the previous process to remove or give company access for a user.
