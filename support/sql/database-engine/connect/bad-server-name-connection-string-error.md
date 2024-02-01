---
title: Troubleshooting incorrect server name in connection string
description: This article provides a workaround for the consistent authentication issue that occurs if a matching name is not provided during login.
ms.date: 01/24/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Login fails because of incorrect server name in connection string

This article helps you to resolve an authentication issue that occurs if the specified login name is not provided when you log in to a Microsoft SQL Server instance.

## Symptoms

The SQLOLEDB and SQLNCLI11 OLE DB providers that use the TCP or Named Pipes protocols show either of the following error messages:

```output
Login failed for user 'userx' - This error message is shown when the providers use an SQL login.
Login failed for user 'CONTOSO\user1' - This error message is shown when the providers use a Windows login.
```

The Microsoft ODBC Driver 13 for SQL Server shows the following error message:

> Login failed for user 'CONTOSO\user1'

The SqlClient .NET provider displays the following error message when you use the TCP protocol and a SQL Server login or a Windows login:

> Login failed for user ''.

The SqlClient .NET provider displays the following error message when you use the Named Pipes protocol and a SQL Server login or a Windows login:

> Login failed for user 'CONTOSO\user1'.

You will likely also see either of the following error messages in the SQL Server error log:

```output
'Login failed for user'. Reason: Could not find a login matching the name provided.
'Login failed for user 'CONTOSO\USER1'. Reason: Could not find a login matching the name provided.
```

## Cause

You experience these errors if you deploy an application that uses a DEV or QA server in production and you don't update the connection string. 

## Solution

To resolve these errors, use one of the following methods:

- If the targeted server isn't correct, update the connection string to point to the correct server.

- If the connection string is correct, provide the login access to the database. To do this, create a user in the database, and then map to that login.

- If you're using a Windows login, add it to a local group or domain group that's allowed to connect to the database server.
