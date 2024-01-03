---
title: Troubleshoot connection issues after implementing cipher suite policies
description: This article provides symptoms and resolution for troubleshooting issues in connection that occur when implementing cipher suite policies.
ms.date: 01/04/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Issues in connection after implementing cipher suite policies on a server

This article helps you resolve the issues that might occur after you implement the cipher suite policies on a server.

## Symptoms

> An existing connection was forcibly closed by the remote host. [SQLSTATE 42000] (Error 10054) OLE DB provider "" for linked server "DB name" returned message "Client unable to establish connection".

There are many causes for the error message.

## Cause 1

If a cipher suite doesn't include RC4, any attempt to use RC4 for encryption will fail. Similarly, if a cipher suite includes RC4 but one of the parties involved doesn't, the handshake will fail, and the connection won't be established.

## Solution 1

To resolve this issue, follow these steps:

1. Check whether the `msds-supportedEncryptionType` property is set. When the property isn't set, it enables only RC4.
1. Set the value as *28* to enable RC4, AES128, and AES256.

## Cause 2

**TLS_DHE Ciphers Enabled** - This issue also occurs when the client or server is hosted on Windows 2012, 2016, and higher versions. Despite both OS versions possessing the same cipher (TLS_DHE*), Windows 2012 and 2016+ handle cryptography keys within the TLS differently. This can result in communication errors.

## Solution 2

To resolve this issue, remove all ciphers starting with "TLS_DHE*" from the local policy. For more information about errors that occur when applications try to connect to SQL Server in Windows, see [Applications experience forcibly closed TLS connection errors when connecting SQL Servers in Windows](../../../windows-server/identity/apps-forcibly-closed-tls-connection-errors.md).

## Cause 3

**Mismatch in TLS version** - This issue might occur when the client initiates the connection using TLS 1.0. Modern cipher suites often don't support TLS 1.0, preferring more secure versions like TLS 1.2.

## Solution 3

To fix this problem, follow these steps:

1. Make sure that the client's driver supports TLS 1.2 (update if necessary).

1. Add the following ciphers to the local policy to support TLS 1.0 communication:

   - `TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA`
   - `TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA`
   - `TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA`
   - `TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA`
