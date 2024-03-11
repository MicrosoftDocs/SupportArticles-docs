---
title: Local SQL Server can't connect to a linked server when RSA encryption is used
description: This article provides a resolution for an error that prevents a client computer from connecting to the linked server.
ms.date: 03/04/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Local SQL Server can't connect to a linked server when RSA encryption is used

This article helps you resolve errors in Microsoft SQL Server that prevent a client computer from establishing a connection with the linked server.

## Symptoms

You receive the following error message:

> An existing connection was forcibly closed by the remote host (OS error 10054)

## Cause

The error might occur in the following situations:

- If the SQL Server certificate uses RSA to encrypt the public key but cipher suites for the client and server differ.

- If RSA is disabled on the server.

## Resolution

To resolve this error, modify the following registry key value on the server to enable RSA:

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\PKCS] "Enabled"=dword:0xffffffff`

:::image type="content" source="media/client-machine-cannot-connect-to-sqlserver/client-machine-cannot-connect-to-sqlserver.png" alt-text="Screenshot that shows how to modify the registry key to enable RSA.":::

> [!NOTE]
> You must restart the server for the change to take effect.

Enabling RSA encryption on the server usually doesn't create any security risk for your environment.

For more details about the TLS and RSA configuration, see [Restrict cryptographic algorithms and protocols - Windows Server Opens in new window or tab](../../../windows-server/certificates-and-public-key-infrastructure-pki/restrict-cryptographic-algorithms-protocols-schannel.md).

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
