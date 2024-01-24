---
title: Named pipes connections fail issue 
description: This article provides symptoms and resolution for troubleshooting the named pipes connections fail consistent authentication error.
ms.date: 01/24/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Troubleshooting the Named Pipes connections issue

This article helps you to resolve consistent authentication problem related to the Named Pipes connections fail error.

## Symptoms

The SQLOLEDB provider shows the ["SQL Server does not exist or access denied"](../startup-shutdown/event-id-7000-access-denied.md) error.

Some other providers display both messages in a random order, whether you use integrated security or a SQL login:

> A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections.
> Could not open a connection to SQL Server.

Some other providers might also show "Login timeout expired" as part of the message.

## Cause

The Named Pipes connections fail because the user doesn't have permission to log into Windows.

## Resolution

Add the user to the Users group on the SQL Server computer. If SQL Server is mirrored or clustered, do the same on all the machines.
