---
title: Troubleshooting local security subsystem issues
description: This article provides cause, symptoms, and workarounds for troubleshooting the local security subsystem issues.
ms.date: 11/25/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Local security subsystem issues

This article helps to resolve the problem related to local security subsystem issues.

## Cause

To be added

## Symptoms

The driver shows the "The login is from an untrusted domain and cannot be used with Windows authentication" error message.

The SQL Server Errorlog will have the following messages:

`SSPI handshake failed with error code 0x80090311, state 14 while establishing a connection with integrated security; the connection has been closed. Reason: AcceptSecurityContext failed. The Windows error code indicates the cause of failure`

`SSPI handshake failed with error code 0x80090304, state 14 while establishing a connection with integrated security; the connection has been closed. Reason: AcceptSecurityContext failed. The Windows error code indicates the cause of failure.`

You might also see Kerberos errors in the System event log on the SQL Server machine for the same time range. The following error codes have specific meanings:

"Error -2146893039 (0x80090311): No authority could be contacted for authentication. This is an Active Directory issue."

## Resolution

To be added
