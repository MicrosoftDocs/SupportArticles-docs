---
title: Error when you install Microsoft Dynamics CRM
description: This article provides a resolution for the problem where the error The Kerberos subsystem encountered an error, The SQL Server instance name must be the same as the computer name occurs.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# "The Kerberos subsystem encountered an error, The SQL Server instance name must be the same as the computer name" error when you install Microsoft Dynamics CRM

This article helps you resolve the problem where the error **The Kerberos subsystem encountered an error, The SQL Server instance name must be the same as the computer name** occurs.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2841195

## Symptoms

When installing Microsoft Dynamics CRM 2011 Server, the following error may occur:

> The SQL Server instance name must be the same as the computer name.

## Cause

The Microsoft SQL Server machine name has been changed after the Microsoft SQL Server had been installed

## Resolution

Utilize the steps below to resolve the error message:

1. On the Microsoft SQL server, select **Start** and open SQL Server Management Studio.
2. Connect to the Server and instance that will contain the Microsoft Dynamics CRM databases.
3. Select **New Query** from the toolbar.
4. Enter the two lines below and then select the execute button on the toolbar

   ```sql
   Select @@SERVERNAME

   Select * from sysservers
   ```

5. Observing the results will show a mismatch.
6. Clear the previous lines and enter the line below. You will need to replace the `<servername>` with the name in the svrname column from step 4.

   ```sql
   sp_dropserver '<servername>'
   ```

7. Clear the previous line and enter the line below. You will need to replace the `<servername>` with the value of the `select @@servername` from step 4.

   ```sql
   sp_addserver '<servername>', 'local'
   ```

8. Enter the two lines below and then select the execute button on the toolbar:

   ```xml
   sp_helpserver

   select @@servername
   ```

9. Last Restart the SQL Server Service for this instance of SQL.
