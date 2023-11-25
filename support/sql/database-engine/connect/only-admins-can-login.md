---
title: Troubleshooting only admins can login error 
description: This article provides cause, symptoms, and workarounds for troubleshooting the only admins can login error.
ms.date: 11/23/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Only admins can login error

This article helps you resolve the "Only admins can login" error.

## Cause

The **CrashOnAuditFail** feature is a security feature used by system administrators to check all security events. The valid values for "CrashOnAuditFail" are 0, 1, and 2. If the key is set to 2, it means that the security event log is full.

## Resolution

To resolve the error, follow these steps:

1. Start the Registry Editor.
1. Locate the following key, and then check whether the value of this key is set to *2*:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa!crashonauditfail`

   This indicates that the security event log requires manual clearing.

1. Set the value to *0* and then reboot the server.

   You might also want to change the security event log to allow events to roll over. For more information about how the setting affects all services such as SQL, IIS, file share, and login, see [Users cannot access Web sites when the security event log is full](../../../developer/webapps/iis/general/users-cannot-access-web-sites-when-log-full.md).

  > [!NOTE]
  > This only affects integrated logins. A Named Pipe connection will also be affected with a SQL Login because Named Pipes first logs into Windows' Admin pipe before connecting to SQL Server.
