---
title: Troubleshoot LSASS errors with SQL Server authentication
description: This article provides a resolution for consistent authentication errors to SQL Server that are related to local security subsystem.
ms.date: 02/27/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Troubleshooting local security subsystem errors in SQL Server

This article helps you resolve a consistent authentication issue when connecting to SQL Server that's related to an unresponsive Local Security Authority Subsystem Service ([LSASS](/windows-server/security/credentials-protection-and-management/credentials-protection-and-management)).

## Symptoms

You might experience security subsystem issues related to LSASS. The Windows authentication driver might show the "The login is from an untrusted domain and can't be used with Windows authentication" error message.

Check whether the Microsoft SQL Server error log shows the following entries:

> SSPI handshake failed with error code 0x80090311, state 14 while establishing a connection with integrated security; the connection has been closed. Reason: AcceptSecurityContext failed. The Windows error code indicates the cause of failure.

> SSPI handshake failed with error code 0x80090304, state 14 while establishing a connection with integrated security; the connection has been closed. Reason: AcceptSecurityContext failed. The Windows error code indicates the cause of failure.

You might also see Kerberos errors in the system event log on the server that's running SQL Server during the same time range. The error code that follows indicates:

> Error - 2146893039 (0x80090311): No authority could be contacted for authentication.

## Cause

These errors occur when the LSASS stops responding.

## Resolution

To resolve these errors, follow these steps:

1. Check whether your Service Principal Name (SPN) is registered correctly on the domain controller (DC).

1. Use the `setspn -Q` or `setspn -L` command to query your SPN and SPNs, respectively, in your account.
