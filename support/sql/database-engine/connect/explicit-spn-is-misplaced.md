---
title: Troubleshooting the explicit misplaced SPN issue 
description: This article provides cause, symptoms, and workarounds for troubleshooting the explicit SPN is missing issue.
ms.date: 12/06/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Explicit misplaced SPN error

This article helps you to resolve the explicit misplaced SPN error.

## Symptoms

If the SPN you specify in the connection string exists on a service account that's not used by SQL Server, you will receive an "SSPI Context" error message.

## Solution

To resolve this error, follow these steps:

1. Use `SETSPN -L domain\svcacct` to list SPNs on the SQL Server service account.

1. Use `SETSPN -Q spnName` to find what account the SPN is on. You can move the SPN using `SETSPN -D` and `SETSPN -A` or choose an SPN already in the correct account.

## See also

[Troubleshoot consistent authentication issues](consistent-authentication-connectivity-issues.md)
---
title: Troubleshooting the explicit misplaced SPN issue in SQL Server
description: This article provides a workaround for the SQL Server consistent authentication problem where the explicit SPN is missing.
ms.date: 02/27/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Explicit misplaced SPN issue in SQL Server

This article helps you resolve a SQL Server consistent authentication problem that affects the explicit misplaced Service Principal Name (SPN).

## Symptoms

If the SPN that you specify in the connection string exists on a service account that's not used by Microsoft SQL Server, you receive a Security Support Provider Interface (SSPI) context error message.

If the SPN isn't registered correctly, you might receive the following error message:

> The target principal name is incorrect. Cannot generate SSPI context.

If you try to create an SPN that already exists, you receive the following error message:

> Duplicate SPN found, aborting operation!

## Cause

The explicit misplaced SPNs can cause issues in Kerberos authentication and prevent clients from connecting to the service.

## Resolution

If you are experiencing explicit misplaced SPNs, you might have to create or re-create the SPN for the service. To create or re-create the SPN by using the `SETSPN` command, follow these steps:

1. Run the `SETSPN -L domain\svcacct` command to list SPNs on the SQL Server service account.
1. Run the `SETSPN -Q spnName` command to learn which service account the SPN is registered on.
1. Run the `SETSPN -D` command to remove the SPN from the service.
1. Run the `SETSPN -A` command to add the SPN to the service.
1. Move the SPN by using `SETSPN -D`, or select an SPN that already exists in the correct account.
