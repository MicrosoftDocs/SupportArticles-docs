---
title: Connection to the linked server failed error
description: This article explains about an error that might occur An error is generated when there is a failure in connecting to the linked server.
ms.date: 03/04/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Connection to the linked server failed

This article helps you to resolve the errors that might arise when the connection to linked server fails. After Windows server patches are installed, connection to the linked server failed.

## Symptoms

You might receive the following error messages:

> TCP Provider: An existing connection was forcibly closed by the remote host.

> OLE DB provider "MSOLEDBSQL" for linked server "PAYMENT GATEWAY" returned message "Client unable to establish connection". (Microsoft SQL Server, Error: 10054)

> Source SQL Version SQL 2019 Enterprise Edition

> Destination SQL Version SQL 2016 Enterprise Edition

  :::image type="content" source="media/connection-to-linked-server-failed/connection-to-linked-server-failed.png" alt-text="Connection to the linked server has failed.":::

## Cause

After installing the Windows Server patches, there was a change in ciphers for client and SQL Server and hence there were communication issues.

## How to check cipher's value on client and server machines

To check the cipher's value on the client and server machines, follow these steps:

1. Open PowerShell with administrative privileges and run the following command on both servers that's your client and main server.

   ```PowerShell
   Get-ItemPropertyValue  -Path HKLM:\System\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002\ -Name Functions
   ```

1. Check and compare these two values from both machines. If they're different, then it means the ciphers are different for both servers.

## Resolution

To check the issue, follow these steps:

1. If a network trace isn't available, check the functions value under this registry key:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002`

1. Use the following PowerShell command to find the TLS functions:

   ```PowerShell
   Get-ItemPropertyValue  -Path HKLM:\System\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002\ -Name Functions
   ```

1. Use a tool such as [IIS Crypto](https://www.nartac.com/Products/IISCrypto/) (Ciphers suites section) to check whether there are any matching algorithms. If no matching algorithms are found, contact Microsoft Support.

[!INCLUDE [third-party-contact-disclaimer](../../../includes/third-party-contact-disclaimer.md)]
