---
title: Troubleshooting wrong explicit SPN account error 
description: This article provides cause, symptoms, and workarounds for troubleshooting the linked server account mapping issue.
ms.date: 11/23/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Wrong Explicit SPN Account error

This article provides the cause, symptoms, and resolution of the wrong explicit SPN account error.

## Symptoms

If the application specifies the SQL Server service account in the `ServerSPN` property of the connection string, for example:

`Provider=SQLNCLI11;Data Source=SQLProd01;initial catalog=northwind;integrated security=sspi;server spn=contoso`

If the account name is correct, then the connection will use Kerberos. If the account name isn't found, the connection will use NTLM, and if the account exists but isn't the SQL Server service account, an SSPI Context error is generated.

## Solution

You can use one of the methods explained in [Determine If I Am Connected to SQL Server using Kerberos Authentication](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Determine-If-I-Am-Connected-to-SQL-Server-using-Kerberos-Authentication) to test independent of the application.

Test the connection from a remote computer. Local connections on Windows 2008 R2 and later, use NTLM to support the per-service SID security feature to prevent one service from spoofing another.