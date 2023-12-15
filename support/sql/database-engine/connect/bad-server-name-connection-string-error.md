---
title: Troubleshooting bad server name in connection string issue
description: This article provides symptoms and resolution for troubleshooting the bad server name in connection string error.
ms.date: 11/27/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Bad server name in connection string error

This article helps you to resolve the problem related to the bad server name error. This error can be a common issue if you deploy an application that uses a DEV or QA server into production and you fail to update the connection string.

## Symptoms

SQLOLEDB and SQLNCLI11 OLE DB providers over TCP or Named Pipes show the following error messages:

- `Login failed for user 'userx'.`- Message is shown when the providers use an SQL login.
- `Login failed for user 'CONTOSO\user1'.`- Message is shown the providers use a Windows login.

The SQL Server and ODBC Driver 13 ODBC drivers show the following error message:

> Login failed for user 'CONTOSO\user1'

The SqlClient .NET Provider shows the following error messages:

> "Login failed for user ''. -when using TCP and a SQL login or a Windows login"
> "Login failed for user 'CONTOSO\user1'. - when using Named Pipes and a SQL login or a Windows login"

Check whether the SQL Server error log has one of the following messages:

> "'Login failed for user'. Reason: Could not find a login matching the name provided."
> "'Login failed for user 'CONTOSO\USER1'. Reason: Could not find a login matching the name provided."

## Resolution

To resolve this issue, follow these steps:

1. Validate that you're connecting to the appropriate server.

1. If the server isn't the appropriate one, then use the connection string.

1. If the connection string is correct, add the login to the database.

1. If you're using a Windows login, add it to a local group or domain group that's allowed to connect to the database server.
