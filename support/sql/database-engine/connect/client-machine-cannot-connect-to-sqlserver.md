---
title: Client machine can't connect to SQL Server using SQL authentication
description: This article provides symptoms, cause, and resolution for troubleshooting the error that occurs when there is a failure in connecting to the linked server.
ms.date: 03/04/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Client machine can't connect to SQL Server by using SQL authentication

This article helps you to resolve the errors that occur when the client is not able to establish a connection with the linked server fails.

## Symptoms

You might see the following error message:

> An existing connection was forcibly closed by the remote host (OS error 10054)

## Cause

The error might be shown in the following cases:

- If SQL Server certificate uses RSA to encrypt public key, cipher suites should be matched for client and server. In case it doesn't match, you might see the previous error message.

- If RSA is disabled on the server.

## Resolution

To resolve this error message, go to SQL Server and modify the following registry key value to enable RSA:

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\PKCS] "Enabled"=dword:0xffffffff`

:::image type="content" source="media/client-machine-cannot-connect-to-sqlserver/client-machine-cannot-connect-to-sqlserver.png" alt-text="The screenshot shows how to modify the registry key to enable RSA.":::

> [!NOTE]
> You must reboot the server for the change to take effect.

Enabling RSA on the SQL Server side means that the server supports RSA encryption, and generally this won't bring any risk to your environment.

For more details about the TLS and RSA configuration, see [Restrict cryptographic algorithms and protocols - Windows Server Opens in new window or tab](../../../windows-server/certificates-and-public-key-infrastructure-pki/restrict-cryptographic-algorithms-protocols-schannel.md).

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
