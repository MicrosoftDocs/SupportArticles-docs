---
title: Troubleshooting errors specific to connection strings 
description: This article provides cause, symptoms, and workarounds for errors related to connection strings.
ms.date: 11/23/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Connection string related issues

This article helps you to troubleshoot connection string related error scenarios.

## Scenario 1 - Bad Server name in connection string

Consider the following scenario:

SQLOLEDB and SQLNCLI11 OLE DB providers over TCP or Named Pipes show the following error messages:

- "Login failed for user 'userx'." - Message is shown when the providers use an SQL login.
- "Login failed for user 'CONTOSO\user1'." - Message is shown the providers use a Windows login.

The SQL Server and ODBC Driver 13 ODBC Drivers show the following error message:

> "Login failed for user 'CONTOSO\user1'."

The SqlClient .NET Provider displays the following error messages:

> "Login failed for user ''. -when using TCP and a SQL login or a Windows login"
> "Login failed for user 'CONTOSO\user1'. - when using Named Pipes and a SQL login or a Windows login"

The SQL Server Errorlog will have one of the following messages:

> "'Login failed for user'. Reason: Could not find a login matching the name provided."
> "'Login failed for user 'CONTOSO\USER1'. Reason: Could not find a login matching the name provided."

**Solution**

This can be a common issue if you deploy an application that uses a DEV or QA server into production and you fail to update the connection string. To resolve this issue, validate that you are connecting to the appropriate server. If not, correct the connection string. If it is, then add the login to the database or if it's a Windows login, add it to a local group or domain group that's allowed to connect to the database server.

## Scenario 2 - Wrong Database Name in Connection String

The driver might generate the following error message:

"Cannot open database "northwind" requested by the login. The login failed."

Some drivers might also generate the "Login failed for user CONTOSO\user1" error message.

The SQL Server Errorlog will have one of the following message:
"Login failed for user 'CONTOSO\User1'. Reason: Failed to open the explicitly specified database 'northwind'."

**Solution**

Make sure that The database name should be clear in the error message and the Errorlog entry.
Change the connection string, if it is incorrect, or grant the user the required permissions.

## Scenario 3 - Wrong Explicit SPN Account

**Symptom**

If the application specifies the SQL Server service account in the `ServerSPN` property of the connection string, for example:

`Provider=SQLNCLI11;Data Source=SQLProd01;initial catalog=northwind;integrated security=sspi;server spn=contoso`

If the account name is correct, then the connection will use Kerberos. If the account name isn't found, the connection will use NTLM, and if the account exists but isn't the SQL Server service account, an SSPI Context error is generated.

**Solution**

You can use one of the methods explained in [Determine If I Am Connected to SQL Server using Kerberos Authentication](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Determine-If-I-Am-Connected-to-SQL-Server-using-Kerberos-Authentication) to test independent of the application.

Test the connection from a remote computer. Local connections on Windows 2008 R2 and later, use NTLM to support the per-service SID security feature to prevent one service from spoofing another.

## Scenario 4 - Explicit SPN is missing

**Symptom**

If you specify a non-existent SPN explicitly in the ServerSPN property of the connection string, then the connection will be made using NTLM authentication.

**Solution**

1. Use SETSPN -L domain\serviceacct to list all SPNs for the SQL Server service account.

1. Add the missing SPN or change the connection string to use an existing one.

For further information, see [Register a Service Principal Name for Kerberos connections](/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections?view=sql-server-ver16).

It is best to test the connection from a remote machine because even with proper Kerberos configuration, local connections will always use NTLM.

## Scenario 5 - Explicit Misplaced SPN

**Symptom**

If the SPN you specify in the connection string exists on a service account that's not used by SQL Server, you will get an "SSPI Context" error message.

**Solution**

Use SETSPN -L domain\svcacct to list SPNs on the SQL Server service account.

Use SETSPN -Q spnName to find what account the SPN is on. You can move the SPN using SETSPN -D and SETSPN -A or choose an SPN already in the correct account.