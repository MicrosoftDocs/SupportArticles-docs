---
title: Troubleshooting the named pipes error 
description: This article provides symptoms and resolution for troubleshooting the named pipes connections fail error.
ms.date: 12/20/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Named Pipes connections fail error

This article helps you to resolve problems related to the Named Pipes connections fail error.

## Symptoms

The Named Pipes connections fail because the user doesn't have permission to log into Windows.

The SQLOLEDB provider shows the [SQL Server does not exist or access denied error](../startup-shutdown/event-id-7000-access-denied.md).

Some other providers display both messages in a random order, whether you use integrated security or a SQL login:

- "A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections."
- "Could not open a connection to SQL Server."

Some other providers might also show "Login timeout expired" as part of the message.

## Resolution

Add the user to the Users group on the SQL Server machine. If SQL is mirrored or clustered, do the same on all the machines.
