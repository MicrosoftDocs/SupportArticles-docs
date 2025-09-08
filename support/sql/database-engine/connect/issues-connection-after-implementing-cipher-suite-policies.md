---
title: Client is unable to connect after implementing cipher suite policies 
description: This article provides a resolution for an issue that occurs after you implement cipher suite policies on a SQL Server machine.
ms.date: 04/30/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, aartigoyle, v-jayaramanp
ms.custom: sap:Database Connectivity and Authentication
---

# "Client unable to establish connection" error after implementing the cipher suite policies on a SQL Server machine

This article helps you resolve issues that occur after you implement cipher suite policies on a server. If the cipher suites supported on a client and server don't match, the connection might fail.

## Symptoms

After you implement cipher suite policies on a server, you receive the following error message:

> An existing connection was forcibly closed by the remote host. [SQLSTATE 42000] (Error 10054) OLE DB provider "" for linked server "DB name" returned message "Client unable to establish connection."

## Cause 1: Rivest Cipher 4 (RC4) isn't included

If a cipher suite doesn't include Rivest Cipher 4 (RC4), any attempt to use RC4 for encryption fails. Similarly, if a cipher suite includes RC4 but one of the parties involved doesn't, the handshake fails, and no connection is established.

### Solution

Follow these steps:

1. Check whether the `msds-supportedEncryptionType` property is set. If the property isn't set, only RC4 is enabled.
1. Set the value for this property to *28* to enable RC4, AES128, and AES256.

## Cause 2: Mismatch in Transport Layer Security (TLS) versions

There is a mismatch in Transport Layer Security (TLS) versions. This issue might occur if the client initiates the connection by using TLS 1.0. Modern cipher suites often don't support TLS 1.0 because they prefer more secure versions, such as TLS 1.2.

### Solution

Follow these steps:

1. Make sure that the client driver supports TLS 1.2. If it doesn't, update the driver.
1. Add the following ciphers to the local policy to support TLS 1.0 communication:

   - `TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA`
   - `TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA`
   - `TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA`
   - `TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA`

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
