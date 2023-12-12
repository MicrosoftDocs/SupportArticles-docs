---
title: Troubleshooting the SQL logins are not enabled error 
description: This article provides symptoms and resolution for troubleshooting the SQL logins are not enabled error.
ms.date: 12/06/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# "SQL Logins are not enabled" error

This article helps you to resolve the "SQL Logins are not enabled" error. This error occurs when the SQL Server login account is disabled.

## Symptoms

All providers will return some variation of the "Login failed for user '\<username\>'" message.

## Resolution

This error can be resolved in one of the following methods:

Check if the SQL error log contains the error message "Login failed for user '\<username\>'. Reason: An attempt to log in using SQL authentication failed. Server is configured for Windows authentication only."

- Use an integrated login. For example, for OLE DB Providers, add `INTEGRATED SECURITY=SSPI` to the connection string, and for ODBC drivers, add `TRUSTED_CONNECTION=YES`. The .NET Provider accepts either syntax.  

    > [!NOTE]
    > This might lead to other issues if they aren't configured correctly to allow integrated authentication and will need to be troubleshot as a separate issue.

- Enable SQL logins on the server:
    a. In SQL Server Management Studio, right-click on the SQL Server name in the **Object Explorer** and select **Properties**.
    b. In the **Security** pane, select **SQL Server and Windows Authentication** mode and select **OK**. Restart SQL Server for the change to take place.

    > [!NOTE]
    > This might lead to other issues, such as defining an SQL login.

- Try to specify a local Windows account or a domain account for the username. Only SQL logins are allowed. The application should be using integrated security.
