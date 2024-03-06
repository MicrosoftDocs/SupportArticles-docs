---
title: Errors are shown after upgrading SQL version  
description: This article provides a workaround for the errors that you might see after upgrading the SQL Server version.
ms.date: 03/06/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Errors are seen after upgrading the version of SQL Server

You experience an error message after you upgrade from a lower SQL Server version of Standard Edition (STD) to a higher SQL version of STD. You might still continue to see the error even after using the local system account for the SQL Server Agent service.

## Symptoms

After patching the operating system, the SQL Server Agent for SQL instance starts and stops immediately.

> SQL Server does not accept the connection (error: 10054). Waiting for SQL Server to allow connections. Operation attempted was: Verify Connection on Start.

> SQLServer Error: 10054, SSL Provider: An Existing connection was forcibly closed by the remote host. [SQLSTATE 08001]

> SQLServer Error: 10054, Client unable to establish connection [SQLSTATE 08001]

## Cause

One of the possible causes of this issue is that Transport Layer Security (TLS) might be disabled. Also, check if the TLS continues to be disabled after the Windows patches are installed.

## Workaround

To resolve these errors, follow these steps:

1. Enable TLS by setting the following registry entries:

    `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS1.0`

    `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS1.1`

    `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS1.2`

1. Reboot the computer to make sure that the change is applied.

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
