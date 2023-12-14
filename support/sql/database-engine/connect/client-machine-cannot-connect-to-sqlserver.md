---
title: Client machine can't connect to SQL Server using SQL authentication
description: This article provides a resolution when the client machine cannot connect SQL Server by SSMS that uses the SQL authentication.
ms.date: 12/14/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Client machine can't connect to SQL Server by using SQL authentication

This article helps you to resolve a scenario where a client machine is unable to access the SQL Server through SQL Server Management Studio (SSMS) using the SQL authentication.

## Symptoms

You see the following error message:

> "An existing connection was forcibly closed by the remote host (OS error 10054)".

## Cause

The error message might be shown in either of the following situations:

- If SQL Server certificate uses RSA to encrypt public key, cipher suites should be matched for client and server. In case it's not matched, the communication between client and server might not be secure.

- If RSA is disabled on the server, the server won't be able to use RSA cipher suites for encryption.

## Resolution

To resolve this error, on the SQL Server, modify the following Registry key value to enable RSA:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\PKCS] "Enabled"=dword:0xffffffff`

> [!NOTE]
> You must  reboot the server for the change to take effect.

Enabling RSA on the SQL Server means that the server supports RSA encryption, and generally this will not cause any risk to your environment.

For more details about the TLS and RSA configuration, see [Restrict cryptographic algorithms and protocols](../../../windows-server/windows-security/restrict-cryptographic-algorithms-protocols-schannel.md).

