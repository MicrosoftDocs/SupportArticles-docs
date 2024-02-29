---
title: Troubleshoot connection issues after implementing cipher suite policies on a server
description: This article provides troubleshooting guidance for issues that occur after you implement cipher suite policies.
ms.date: 01/08/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# "Client unable to establish connection" error after implementing cipher suite policies on a server

This article helps you resolve issues that occur after you implement cipher suite policies on a server.

## Symptoms

After you implement cipher suite policies on a server, you receive the following error message:

> An existing connection was forcibly closed by the remote host. [SQLSTATE 42000] (Error 10054) OLE DB provider "" for linked server "DB name" returned message "Client unable to establish connection."

## Cause

This error might occur for either of the following reasons.

### Cause 1

If a cipher suite doesn't include RC4, any attempt to use RC4 for encryption fails. Similarly, if a cipher suite includes RC4 but one of the parties involved doesn't, the handshake fails, and no connection is established.

### Cause 2

There is a mismatch in TLS versions. This issue might occur if the client initiates the connection by using TLS 1.0. Modern cipher suites often don't support TLS 1.0 because they prefer more secure versions, such as TLS 1.2.

## Solution

To resolve this issue, use the appropriate solution.

### Solution for Cause 1

Follow these steps:

1. Check whether the `msds-supportedEncryptionType` property is set. If the property isn't set, only RC4 is enabled.
1. Set the value for this property to *28* to enable RC4, AES128, and AES256. 

### Solution for Cause 2

Follow these steps:

1. Make sure that the client driver supports TLS 1.2. If it doesn't, update the driver.
1. Add the following ciphers to the local policy to support TLS 1.0 communication:

   - `TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA`
   - `TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA`
   - `TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA`
   - `TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA` 
