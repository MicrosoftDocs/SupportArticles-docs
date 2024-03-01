---
title: Troubleshooting errors when SQL Server agent can't start
description: This article provides symptoms, cause, and resolution for troubleshooting the error that occurs when the SQL Server agent can't start.
ms.date: 02/29/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Unable to start SQL Server agent

This article helps you resolve the scenario where the SQL Server agent can't start.

## Symptoms

The following error messages are shown:

> SQL Server does not accept the connection (error: 233). Waiting for Sql Server to allow connections. Operation attempted was: Verify Connection On Start.

> A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - An existing connection was forcibly closed by the remote host.) (Microsoft SQL Server, Error: 10054)

> In Event Viewer Event ID : 17052 logged.

## Cause

The `DisabledByDefault` and `Enabled` registry values in the `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client]` might be configured incorrectly. For more information, see [TLS 1.2 support for Microsoft SQL Server](tls-1-2-support-microsoft-sql-server.md).

## Resolution

To resolve these errors, follow these steps:

1. Enable the TLS 1.2 for SQL Server communication as follows:

   `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]`

   `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

   `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

1. Open *Regedit.exe*.

1. Navigate to `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client]`.

1. Set the `DisabledByDefault` to *0* and `Enabled` to *1* for both client and server.

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
