---
title: Troubleshooting errors when SQL Server agent can't start
description: This article provides a resolution for a problem in which the SQL Server agent can't start.
ms.date: 02/29/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Event ID 17052 and you can't start SQL Server agent

This article helps you resolve a problem in which you can't start the Microsoft SQL Server agent.

## Symptoms

You receive the following error messages:

> SQL Server does not accept the connection (error: 233). Waiting for Sql Server to allow connections. Operation attempted was: Verify Connection On Start.

> A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - An existing connection was forcibly closed by the remote host.) (Microsoft SQL Server, Error: 10054)

Additionally, the event viewer logs Event ID 17052.

## Cause

The `DisabledByDefault` and `Enabled` registry entries in the `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client]` subkey might be configured incorrectly. For more information, see [TLS 1.2 support for Microsoft SQL Server](tls-1-2-support-microsoft-sql-server.md).

## Resolution

To resolve these problems, follow these steps:

1. Enable the TLS 1.2 protocol for SQL Server communication as follows:

   `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]`

   `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

   `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

1. Open *Regedit.exe*.

1. Navigate to `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client]`.

1. Set the `DisabledByDefault` value to **0** and `Enabled` to **1** for both the client and server.

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
