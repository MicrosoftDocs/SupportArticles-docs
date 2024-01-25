---
title: Connection to the linked server failed errors
description: This article provides symptoms, cause, and resolution for troubleshooting the error that occurs when there is a failure in connecting to the linked server.
ms.date: 01/25/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Connection to the linked server failed

This article helps you to resolve the errors that occur when the client is not able to establish a connection with the linked server fails.

## Symptoms

The following error messages are shown:

> TCP Provider: An existing connection was forcibly closed by the remote host.

> OLE DB provider "MSOLEDBSQL" for linked server "PAYMENT GATEWAY" returned message "Client unable to establish connection". (Microsoft SQL Server, Error: 10054)

> Source SQL Version SQL 2019 Enterprise Edition

> Destination SQL Version SQL 2016 Enterprise Edition

  :::image type="content" source="media/connection-to-linked-server-failed/connection-to-linked-server-failed.png" alt-text="Connection to the linked server has failed.":::

## Cause

There were communication problems as a result of a change in the client and SQL Server ciphers after the patches were installed.

## Resolution

To check the cipher's value on the client and server machines, follow these steps:

1. Open PowerShell with administrative privileges and run the following command on both servers that's your client and main server.

   ```powershell
   Get-ItemPropertyValue  -Path HKLM:\System\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002\ -Name Functions
   ```

1. Check and compare these two values from both machines. If they're different, then it means the ciphers are different for both servers.

See the [Scenario 2: Matching TLS protocols on the client and the server, but no matching TLS cipher suites](tls-exist-connection-closed.md).
