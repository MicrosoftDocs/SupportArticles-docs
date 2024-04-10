---
title: Incorrect server name in a connection string
description: This article provides a resolution for the consistent authentication issue in which a specified server name isn't correct in a connection string.
ms.date: 04/05/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Incorrect server name in SQL Server connection string

This article helps you resolve an authentication issue in which the specified server name within a database connection string is incorrect.

## Symptoms

When you try to connect to a Microsoft SQL Server database by using different connection providers, you receive one of the following error messages that are associated with login failures:

- You receive either of the following error messages that indicate authentication issues and that are associated with the SQLOLEDB and SQLNCLI11 OLE DB providers that use either the TCP or Named Pipes protocol:

  - If you use a SQL Server login, the error message, "Login failed for user 'userx'," indicates that the provided credentials are incorrect. A possible reason for the error is that the user name is spelled incorrectly.

  - If you use a Windows login, the error message, "Login failed for user 'CONTOSO\user1'," indicates that the server name, "CONTOSO\user1," is incorrect.

- The following error message is returned if you try to connect to a database that uses the Microsoft ODBC Driver 13 for SQL Server:

  > Login failed for user 'CONTOSO\user1'

- The SqlClient .NET provider displays the following error message if you use the TCP protocol and either a SQL Server login or a Windows login:

  > Login failed for user ''.

  **Note:** The empty user name might indicate that the connection string lacks the required login credentials.

- The SqlClient .NET provider displays the following error message (that specifically mentions the user) if you use the Named Pipes protocol and a SQL Server login or a Windows login:

  > Login failed for user 'CONTOSO\user1'.

- You see either of the following error message together with an explanation in the SQL Server error log. This issue might be common if you deploy an application from a development (DEV) or quality assurance (QA) environment to production without updating the connection string.

  ```output
    'Login failed for user'. Reason: Could not find a login matching the name provided.
    'Login failed for user 'CONTOSO\USER1'. Reason: Could not find a login matching the name provided.
  ```

## Cause

These errors might occur for any of the following reasons:

- The syntax of the connection string is incorrect.
- The server name in the connection string is incorrect.
- The user credentials are incorrect.

## Solution

To resolve these errors, follow these steps:

1. Check the connection string format. A connection string format must contain the required parameters, such as server name, database name, user name, and password.
1. Check the server name in the connection string.
1. If you're using a named instance, include the instance name.
1. If the targeted server is incorrect, update the connection string to point to the correct server.
1. If the connection string is correct, provide the login access to the database. To do this, create a user in the database, and then map to that login.
1. If you're using a Windows login, add the login to a local group or domain group that's allowed to connect to the database server.
