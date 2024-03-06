---
title: Connection to the linked server fails
description: This article discusses errors that might occur if the connection to the linked server fails.
ms.date: 03/06/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# "Connection to the linked server has failed" error after you update Windows Server

This article helps you resolve multiple errors that occur when a connection to the linked server fails after the latest Windows Server updates are installed.

## Symptoms

The following error entries are logged in the \<LogName\> log.

> TCP Provider: An existing connection was forcibly closed by the remote host.

> OLE DB provider "MSOLEDBSQL" for linked server "LinkedServer Name" returned message "Client unable to establish connection". (Microsoft SQL Server, Error: 10054)

You might also receive the following messages:

> Source SQL Version SQL 2019 Enterprise Edition

> Destination SQL Version SQL 2016 Enterprise Edition

  :::image type="content" source="media/connection-to-linked-server-failed/connection-to-linked-server-failed.png" alt-text="Screenshot that shows that multiple errors occur after the connection to the linked server fails.":::

## Cause

The ciphers for the SQL Server client and server were modified after you installed Windows Server updates. As a result, there were issues with communication.

## How to check cipher values

To check the cipher values on the client and server computers, follow these steps:

1. Open an administrative PowerShell session, and then run the following command on both the client and main server:

   ```PowerShell
   Get-ItemPropertyValue  -Path HKLM:\System\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002\ -Name Functions
   ```

1. Compare the values from both computers to determine whether the ciphers differ.

## Resolution

To resolve the problem, follow these steps:

1. If a network trace isn't available, check the functions value in this registry subkey:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002`

1. Run the following PowerShell command to find the Transport Layer Security (TLS) functions:

   ```PowerShell
   Get-ItemPropertyValue  -Path HKLM:\System\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002\ -Name Functions
   ```

1. Use the **Ciphers Suites** tab in the [**IIS Crypto**](https://www.nartac.com/Products/IISCrypto/) tool to check whether there are any matching algorithms. If no matching algorithms are found, contact Microsoft Support.

[!INCLUDE [third-party-contact-disclaimer](../../../includes/third-party-contact-disclaimer.md)]

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
