---
title: Local SQL Server can't connect to a linked server when RSA encryption is used
description: This article provides a resolution for an error that prevents a client computer from connecting to the linked server.
ms.date: 04/18/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, aartigoyle, v-jayaramanp
ms.custom: sap:Database Connectivity and Authentication
---

# Local SQL Server can't connect to a linked server when RSA encryption is used

This article helps you resolve an error in Microsoft SQL Server that prevents a client computer from establishing a connection with a linked server.

## Symptoms

You might receive the following error message if there's a mismatch in encryption settings both on the client and server:

> An existing connection was forcibly closed by the remote host (OS error 10054)

## Cause

The 10054 error might occur in the following situations:

- If the SQL Server certificate uses RSA to encrypt the public key but cipher suites for the client and server differ.

- If RSA is disabled on the server.

## Resolution

To resolve this error, modify the following registry key value on the server to enable RSA:

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\PKCS] "Enabled"=dword:0xffffffff`

> [!NOTE]
> You must restart the server for the change to take effect.

Enabling RSA encryption on the server usually doesn't create any security risk for your environment.

For more information about the Transport Layer Security (TLS) and RSA configuration, see [Restrict cryptographic algorithms and protocols](../../../windows-server/certificates-and-public-key-infrastructure-pki/restrict-cryptographic-algorithms-protocols-schannel.md).

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
