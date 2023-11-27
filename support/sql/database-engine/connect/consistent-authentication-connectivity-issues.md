---
title: Introduction to consistent authentication issues
description: This article introduces to consistent authentication issues, the types of error messages, and workarounds to troubleshoot various problems.
ms.date: 11/27/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Consistent authentication problems

A consistent authentication issue in SQL Server typically refers to problems related to authentication and authorization of users or applications trying to access the SQL Server database. These issues can lead to authentication failures, access denied errors, or other security-related problems.

> [!NOTE]
> The commands provided in this article are for Windows systems only.

## Recommended pre-requisites for consistent authentication problems

To troubleshoot consistent authentication issues, follow these steps:

1. See the recommended [prerequisites and checklist for troubleshooting SQL Server connectivity issues](resolve-connectivity-errors-checklist.md).
1. Collect data to troubleshoot SQL consistent authentication issues.

   This will help you to get a macro perspective of the scope of an issue, that is whether the issue affects single or multiple machines or whether only machines in a specific data center are affected. This can help you focus on the troubleshooting steps. It will also prepare you to discuss the problem with Microsoft Support should you choose to do so.

1. Make sure you understand the application architecture and summarize the issue like the following description:

    - There are two domains involved: contoso and fabrikam.

    - The client `sparky.contoso.com` runs on Windows 2012.

    - The user `contoso\johndoe` runs on EDGE and connects to a web server `(http://web01.contoso.com/accounting)` using integrated security.

    - The IIS app pool runs as `contoso\web_svc`.

    - The web server connects to SQL Server 2014 (SQLProd01.fabrikam.com\Accounting on port 1433) using the SqlClient .NET 4.6.2 Provider and assigns the user credentials to SQL Server using integrated security.

    - The SQL Server service account is `fabrikam\sql_svc_01`.

1. Collect the SPN information based on the service accounts identified in the description. For example:

    `SETSPN -L CONTOSO\WEB_SVC > c:\temp\spns.txt` - Creates a new file.
    `SETSPN -L FABRIKAM\SQL_SVC_01 >> c:\temp\spns.txt` - Appends to a file.

## Types of errors

Before you start to troubleshoot errors, it's important to understand what each error means and also what is the type of error. It's also important to understand the category of the error because the troubleshooting steps also vary. This section provides various types of consistent authentication errors.

- Directory Services specific error messages - Refers to the Active Directory error messages. If the SQL Server ERRORLOG file contains the following messages, then this is an Active Directory issue. This might happen if the domain controller can't be contacted by Windows on the SQL Server computer, or the local security service (LSASS) is having a problem.

> Error -2146893039 (0x80090311): No authority could be contacted for authentication.
> Error -2146893052 (0x80090304): The Local Security Authority cannot be contacted.

- [Login failed error codes](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver16&preserve-view=true#additional-error-information) - If you are troubleshooting a "Login Failed" error message, the SQL Server ERRORLOG file can provide more information in the SQL State value with error 18456 (Login Failed).

- [Login failed error messages](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver16&preserve-view=true) - Refers to some of the common login failures. For more information, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver16&preserve-view=true).
  - [Login failed for user '(null)'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?view=sql-server-ver16&preserve-view=true#login-failed-for-user-(null))
  - [Login failed for user ''](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Login failed for user 'NT AUTHORITY\ANONYMOUS LOGON'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Login failed for user 'username'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Login failed for user 'DOMAIN\username'](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - Login failed. The login is from an untrusted domain and cannot be used with Windows authentication.
  - [SQL Server does not exist or access denied](network-related-or-instance-specific-error-occurred-while-establishing-connection.md) - This can also be a network error.
- [SSPI context messages](/troubleshoot/sql/database-engine/connect/cannot-generate-sspi-context-error?branch=main)

## Categorization of error messages

Before you start with troubleshooting, it is important to understand the nature of an error and the category that it belongs to. This section provides error messages grouped based on a category. Some errors might appear in more than one category. Each of these error scenarios has the symptoms and the solutions as well. Following are the error categories.

- Following are the errors specific to failed login:
  - [Bad password](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Invalid username](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [SQL logins are not enabled](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Named Pipes connections fail because the user doesn't have permission to log into Windows](named-pipes-connection-fail-no-windows-permission.md).

- Following are the errors specific to the different aspects of SQL Server:
  - [Database offline](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Database permissions](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [No Login](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error)
  - [Linked Server Account Mapping](linked-server-account-mapping-error.md)
  - [Proxy Account](proxy-account-error.md)
  - [Bad metadata](bad-metadata-error.md)

- Following are the errors specific to Connection String:
  - [Bad server name in Connection String](bad-server-name-connection-string-error.md)
  - [Wrong database name in Connection String](wrong-database-name-in-connection-string.md)
  - [Wrong explicit SPN account](wrong-explicit-spn-account-connection-string.md)
  - [Explicit SPN is missing](cannot-generate-sspi-context-error.md)
  - [Explicit Misplaced SPN](cannot-generate-sspi-context-error.md)
  - [Explicit SPN is duplicated](cannot-generate-sspi-context-error.md)

- Following are the errors specific to the local Windows permissions or Policy settings.
  - [Access via Group](access-through-group-windows-permissions.md)
  - [Network login disallowed](network-login-disallowed.md)
  - [Service account not trusted for delegation](service-account-not-trusted-for-delegation.md)
  - [Only admins can login](only-admins-can-login.md)
  - [Local Security Subsystem Issues](local-security-subsystem-issues.md)
  - [Corrupt user profile](corrupt-user-profile.md)
  - [Credential Guard is enabled](/windows/security/identity-protection/credential-guard/considerations-known-issues)

- Following are the errors specific to NTLM:
  (To be added)

- Issues specific to Active Directory and Domain Controller - To be added

- Miscellaneous issues - To be added.
