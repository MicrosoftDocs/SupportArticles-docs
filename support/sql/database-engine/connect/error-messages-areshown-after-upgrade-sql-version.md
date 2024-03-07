---
title: Connection error occurs in SQL Server after a program upgrade  
description: This article provides a resolution for an error that you experience after you upgrade SQL Server.
ms.date: 03/06/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Error 10054 after a SQL Server upgrade

After a Microsoft SQL Server upgrade, you experience a connection error. The error might continue even after you use the local system account for the SQL Server Agent service.

## Symptoms

After you upgrade Microsoft SQL Server Standard Edition (STD), SQL Server Agent starts and stops immediately. Additionally, you receive the following error messages:

> SQL Server does not accept the connection (error: 10054). Waiting for SQL Server to allow connections. Operation attempted was: Verify Connection on Start.

> SQLServer Error: 10054, SSL Provider: An Existing connection was forcibly closed by the remote host. [SQLSTATE 08001]

> SQLServer Error: 10054, Client unable to establish connection [SQLSTATE 08001]

## Cause

One possible cause of the error is that Transport Layer Security (TLS) might be disabled. Also, check whether the TLS protocol continues to be disabled after the upgrade is installed.

## Resolution

To resolve the error, follow these steps:

1. Enable TLS by setting the following registry entries:

    `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS1.0`

    `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS1.1`

    `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS1.2`

1. Restart the computer to make sure that the change is applied.

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
