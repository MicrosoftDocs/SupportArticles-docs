---
title: Connection error 10054 occurs in SQL Server post upgrade
description: This article provides a resolution for the 10054 error that you might experience after you upgrade SQL Server.
ms.date: 05/01/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, aartigoyle, v-jayaramanp
ms.custom: sap:Connection issues
---

# A connection error 10054 might occur post SQL Server upgrade

After a Microsoft SQL Server upgrade, you experience a connection error. The error is likely to continue even after you use the local system account for the SQL Server Agent service.

## Symptoms

After you upgrade Microsoft SQL Server Standard Edition (STD), SQL Server Agent starts and stops immediately. Additionally, you receive one or more of the following error messages:

> SQL Server does not accept the connection (error: 10054). Waiting for SQL Server to allow connections. Operation attempted was: Verify Connection on Start.

> SQLServer Error: 10054, SSL Provider: An Existing connection was forcibly closed by the remote host. [SQLSTATE 08001]

> SQLServer Error: 10054, Client unable to establish connection [SQLSTATE 08001]

## Cause

Sometimes after a Microsoft SQL Server upgrade, TLS is disabled and you might experience a connection error. Check whether the TLS protocol is disabled after the upgrade is installed.

## Resolution

To resolve the error, follow these steps:

1. Enable TLS by setting the following registry entries:

    `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS1.0`

    `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS1.1`

    `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS1.2`

1. Restart the computer to make sure that the change is applied.

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
