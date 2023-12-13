---
title: Troubleshooting intermittent connection errors
description: This article provides symptoms and resolution for troubleshooting the intermittent connection errors.
ms.date: 12/13/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Intermittent connection errors occur when a new node is added to the Always On environment

There are intermittent connection errors when you add a new node to the existing Always On environment. When you try to connect to the SQL Server, the following intermittent error message is shown:

> "The connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - An existing connection was forcibly closed by the remote host.)"

## Symptoms

One of the possible reasons for this issue could be due to a mismatch between security protocols between the database and the application machine.

## Resolution

You can address the intermittent error message by resolving the mismatch between security protocols. Node1 encrypts information using AES128/256, while Node2 uses RC4. To troubleshoot this problem, follow these  steps:

1. Download [IIS Crypto](https://www.nartac.com/Products/IISCrypto/Download).
1. Download and install the GUI version of the IIS Crypto tool on the server.
1. Configure **Cipher Suites**.  
1. Launch the **IIS Crypto** tool on the server.
1. In the IIS Crypto interface, select **Cipher Suites** in the left panel.  
1. Uncheck all ciphers that start with "TLS_DHE*" from the list.  

  > [!NOTE]
  > The list may not be in any order.  

1. After unchecking the relevant ciphers, select **Apply** to save the changes.

    (Screenshot to be added)

1. Reboot the server.

After the changes have been applied, reboot the server to make sure the new cipher suite configuration takes effect.

> [!NOTE]
> This troubleshooting process forces the client to communicate using a different cipher suite with improved security implementation.

By following these steps, you should be able to resolve the intermittent connection error caused by the security protocol mismatch between the user and the computer.

Always make sure you have the proper backups and consider testing any changes in a controlled, staged, or test environment before applying them to the production computers. If the issue persists or if there are any concerns, contact the network team.

[!INCLUDE [third-party-disclaimer](../../../includes/third-party-disclaimer.md)]
