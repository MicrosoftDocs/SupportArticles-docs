---
title: Troubleshooting the bad server name in connection string
description: This article provides cause, symptoms, and workarounds for troubleshooting the bad server name in connection string error.
ms.date: 12/18/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Bad server name in connection string

This article helps you to resolve the issue related to the bad server name.

## Symptoms

The SQLOLEDB and SQLNCLI11 OLE DB providers using the TCP or Named Pipes protocols show either of the following error messages:

- "Login failed for user 'userx'".- Message is shown when the providers use an SQL login.
- "Login failed for user 'CONTOSO\user1'".- Message is shown the providers use a Windows login.

The Microsoft ODBC Driver 13 for SQL Server generates the following error message:

"Login failed for user 'CONTOSO\user1'"

The SqlClient .NET Provider displays the following error message in either of the following scenarios:

When you use a TCP protocol and a SQL login or a Windows login:

> Login failed for user ''.

When you use Named Pipes protocol and a SQL login or a Windows login.

> Login failed for user 'CONTOSO\user1'.

You might also see either of the following error messages in the SQL Server error log:

> 'Login failed for user'. Reason: Could not find a login matching the name provided.
> 'Login failed for user 'CONTOSO\USER1'. Reason: Could not find a login matching the name provided.

These errors might be generated if you deploy an application that uses a DEV or QA server into production and you fail to update the connection string.

## Solution

To resolve this issue, follow these steps:

1. Validate that you are connecting to the appropriate server.

1. If the server isn't the appropriate one, then the connection string.

1. If the connection string is correct, add the login to the database.

1. If it's a Windows login, add it to a local group or domain group that's allowed to connect to the database server.
