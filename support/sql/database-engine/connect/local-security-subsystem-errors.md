---
title: Troubleshooting local security subsystem errors
description: This article provides symptoms and resolution for the local security subsystem related consistent authentication issues.
ms.date: 01/22/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Local security subsystem errors

This article helps to resolve the issue that might arise due to a consistent authentication issue related to the LSASS not responding to  of  local security subsystem errors.

## Symptoms

The driver shows the "The login is from an untrusted domain and can't be used with Windows authentication" error message.

Check if the SQL Server error log shows the following messages:

> SSPI handshake failed with error code 0x80090311, state 14 while establishing a connection with integrated security; the connection has been closed. Reason: AcceptSecurityContext failed. The Windows error code indicates the cause of failure.

> SSPI handshake failed with error code 0x80090304, state 14 while establishing a connection with integrated security; the connection has been closed. Reason: AcceptSecurityContext failed. The Windows error code indicates the cause of failure.

You might also see Kerberos errors in the system event log on the SQL Server machine for the same time range. The following error code has a specific meaning:

> Error - 2146893039 (0x80090311): No authority could be contacted for authentication.

## Cause

These errors occur when the local security authority subsystem service (LSASS) stops responding.

## Resolution

To resolve these error messages, follow these steps:

1. Check whether your Service Principal Name (SPN) is registered correctly on the Domain Controller (DC).

1. Use the `setspn -Q` or `setspn -L` commands to query your SPN and SPNs under your account respectively.
