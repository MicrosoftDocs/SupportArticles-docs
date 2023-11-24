---
title: Troubleshooting explicit SPN is missing issue 
description: This article provides cause, symptoms, and workarounds for troubleshooting the explicit SPN is missing issue.
ms.date: 11/23/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Explicit SPN is missing error

## Symptoms

If you specify a non-existent SPN explicitly in the ServerSPN property of the connection string, then the connection will be made using NTLM authentication.

## Solution

1. Use `SETSPN -L domain\serviceacct` to list all SPNs for the SQL Server service account.

1. Add the missing SPN or change the connection string to use an existing one.

For further information, see [Register a Service Principal Name for Kerberos connections](/sql/database-engine/configure-windows/register-a-service-principal-name-for-kerberos-connections?view=sql-server-ver16).

It is best to test the connection from a remote machine because even with proper Kerberos configuration, local connections will always use NTLM.