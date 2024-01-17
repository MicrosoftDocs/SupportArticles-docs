---
title: Troubleshooting the bad server name in connection string
description: This article provides a workaround for the consistent authentication issue when there is a bad server name in connection string.
ms.date: 01/17/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Bad server name in connection string

This article helps you to resolve the issues that might arise from the consistent authentication issue related to bad server name in a connection string.

## Symptoms

The SQLOLEDB and SQLNCLI11 OLE DB providers that use the TCP or Named Pipes protocols show either of the following error messages:

```output
Login failed for user 'userx' - This error message is shown when the providers use an SQL login.
Login failed for user 'CONTOSO\user1' - This error message is shown when the providers use a Windows login.
```

The Microsoft ODBC Driver 13 for SQL Server generates the following error message:

> Login failed for user 'CONTOSO\user1'

The SqlClient .NET Provider displays the following error message when you use the TCP protocol and a SQL login or a Windows login:

> Login failed for user ''.

The SqlClient .NET Provider displays the following error message when you use the Named Pipes protocol and a SQL login or a Windows login:

> Login failed for user 'CONTOSO\user1'.

You might also see either of the following error messages in the SQL Server error log:

```output
'Login failed for user'. Reason: Could not find a login matching the name provided.
'Login failed for user 'CONTOSO\USER1'. Reason: Could not find a login matching the name provided.
```

## Cause

You might experience these errors if you deploy an application that uses a DEV or QA server into production and also if you don't update the connection string.

## Solution

To resolve these error messages, follow these steps:

1. Check that you're connecting to the correct server.

1. If the server isn't the appropriate one, then update the connection string to point to the correct server.

1. If the connection string is correct, then provide the login access to the database by creating a user in the database and map to that login.

1. If you're using a Windows login, add it to a local group or domain group that's allowed to connect to the database server.
