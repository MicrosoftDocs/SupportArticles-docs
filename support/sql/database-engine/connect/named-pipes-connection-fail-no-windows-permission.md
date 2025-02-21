---
title: Named Pipes connection failure to SQL Server
description: This article provides a resolution for named pipes connection failures when authenticating to SQL Server.
ms.date: 03/19/2024
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Database Connectivity and Authentication
---

# Named Pipes connections cause failure to SQL Server

This article helps you to resolve a consistent authentication issue that causes a Named Pipes connections failure to SQL Server.

## Symptoms

The SQL OLE DB provider displays the ["SQL Server does not exist or access denied"](../startup-shutdown/event-id-7000-access-denied.md) error message.

Some other providers display both the following messages in a random order, whether you use integrated security or a Microsoft SQL Server login:

> A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections.
>
> Could not open a connection to SQL Server.

Some other providers might additionally display "Login timeout expired" within the error message.

## Cause

The Named Pipes connections fail because user doesn't have permission to log in to Windows.

## Resolution

Add the user to the **Users** group on the server that's running SQL Server. If SQL Server is mirrored or clustered, repeat on all computers within the group.

## More information

[Consistent authentication issues in SQL Server](consistent-authentication-connectivity-issues.md)
