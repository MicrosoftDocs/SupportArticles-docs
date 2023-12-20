---
title: Troubleshooting local security subsystem errors
description: This article provides symptoms and resolution for the local security subsystem related errors.
ms.date: 12/20/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Local security subsystem errors

This article helps to resolve the problem related to local security subsystem errors. The 

## Symptoms

The local security subsystem errors occur when the local security authority subsystem service (LSASS) stops responding.

The driver shows the "The login is from an untrusted domain and can't be used with Windows authentication" error message.

Check if the SQL Server error log shows the following messages:

> SSPI handshake failed with error code 0x80090311, state 14 while establishing a connection with integrated security; the connection has been closed. Reason: AcceptSecurityContext failed. The Windows error code indicates the cause of failure.

> SSPI handshake failed with error code 0x80090304, state 14 while establishing a connection with integrated security; the connection has been closed. Reason: AcceptSecurityContext failed. The Windows error code indicates the cause of failure.

You might also see Kerberos errors in the system event log on the SQL Server machine for the same time range. The following error code has a specific meaning:

> Error -2146893039 (0x80090311): No authority could be contacted for authentication. This is an Active Directory issue.

## Resolution

Check whether your Service Principal Name (SPN) is registered correctly on the Domain Controller (DC). You can use `setspn -Q` or `setspn -L` to query your service principal name and SPNs under your account respectively. 
