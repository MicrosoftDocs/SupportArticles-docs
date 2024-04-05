---
title: Incorrect server name in a connection string
description: This article provides a resolution for the consistent authentication issue where a specified server name isn't correct in a connection string.
ms.date: 04/05/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Incorrect server name in SQL Server connection string

This article helps you to resolve an authentication issue where the specified server name within a database connection string is incorrect.

## Symptoms

The error messages that you might experience are associated with login failures that occur when attempting to connect to a SQL Server database using different connection providers.

- You might see either of the following error messages associated with the SQLOLEDB and SQLNCLI11 OLE DB Providers, which use either TCP or Named Pipes:

  - If you use a SQL login, the error message "Login failed for user 'userx'" indicates that the provided credentials are incorrect. A possible reason could be that user name wasn't spelt correctly.

  - If you use a Windows login, the error message "Login failed for user 'CONTOSO\user1'" indicates that the server name "CONTOSO\user1" isn't correct.

   These messages indicate authentication issues when attempting to connect to a Microsoft SQL Server.

- Following is an error message you might see when you connect to a database using the Microsoft ODBC Driver 13 for SQL Server:

  > Login failed for user 'CONTOSO\user1'

- The SqlClient .NET provider displays the following error message when you use the TCP protocol and a SQL Server login or a Windows login:

  > Login failed for user ''.

  The empty user name might indicate that the connection string lacks the required login credentials.

- The SqlClient .NET provider displays the following error message (which specifically mentions the user) when you use the Named Pipes protocol and a SQL Server login or a Windows login:

  > Login failed for user 'CONTOSO\user1'.

- You should see either of the following error message along with the reason in the SQL Server ERRORLOG. This can be a common issue if you deploy an application from a development (DEV) or quality assurance (QA) environment to production without updating the connection string:

  ```output
    'Login failed for user'. Reason: Could not find a login matching the name provided.
    'Login failed for user 'CONTOSO\USER1'. Reason: Could not find a login matching the name provided.
  ```

## Cause

These errors might occur because of any of the following reasons:

- The syntax of the connection string might not be correct.
- The server name in the connection string might be incorrect.
- The user credentials might be incorrect.

## Solution

To resolve these errors, follow these steps:

1. Check the connection string format. A connection string format must contain the required parts such as server name, database name, user name, password, and other parameters.
1. Check the server name in the connection string.
1. If you're using a named instance, include the instance name.
1. If the targeted server isn't correct, update the connection string to point to the correct server.
1. If the connection string is correct, provide the login access to the database. To do this, create a user in the database, and then map to that login.
1. If you're using a Windows login, add it to a local group or domain group that's allowed to connect to the database server.
