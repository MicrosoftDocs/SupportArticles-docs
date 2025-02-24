---
title: Connection error when adding node to Always On environment
description: This article helps you resolve the problem of intermittent connection errors in SQL Server when a new node is added to the Always On environment.
ms.date: 04/30/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, v-jayaramanp
ms.custom: sap:Database Connectivity and Authentication
---

# Intermittent connection errors occur when adding a node to the Always On environment in SQL Server

You experience intermittent connection errors when you add a new node to the existing Always On environment.

## Symptoms

When you try to connect to a server that's running Microsoft SQL Server, the following error message appears intermittently:

> The connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - An existing connection was forcibly closed by the remote host.)

## Cause

This error might occur if a there's a mismatch in security protocols between the database and the application servers.

## Resolution

To fix this error, resolve the mismatch between the security protocols. Node1 encrypts information by using AES128/256. Node2 encrypts information by using RC4. To troubleshoot this error, follow these steps:

1. Download [IIS Crypto](https://www.nartac.com/Products/IISCrypto/Download).
1. Install the GUI version of the IIS Crypto tool on the server.
1. Configure **Cipher Suites**.
1. Open the **IIS Crypto** tool on the server.
1. In the IIS Crypto interface, select **Cipher Suites** in the left panel.  
1. In the list, clear all checkboxes for ciphers that start with "TLS_DHE*".

    > [!NOTE]
    > The list might not be in any particular order.  

1. After you clear the relevant cipher selections, select **Apply** to save the changes.

    :::image type="content" source="media/intermittent-connection-errors-when-a-new-node-is-added/intermittent-connection-add-new-nodes.png" alt-text="Screenshot that shows clearing all ciphers that aren't required." lightbox="media/intermittent-connection-errors-when-a-new-node-is-added/intermittent-errors-when-adding-a-node-big.png":::

1. Restart the server.

   After the changes have been applied, restart the server to make sure that the new cipher suite configuration takes effect.

  > [!NOTE]
  > This troubleshooting process forces the client to communicate by using a different cipher suite that has an improved security implementation.

Always make sure that you have the appropriate backups available. Also, consider testing any changes in a controlled, staged, or test environment before you apply them to the production computers. If the issue persists or if you have any other concerns, contact your network team.

[!INCLUDE [third-party-disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
