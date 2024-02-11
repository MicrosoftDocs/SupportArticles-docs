---
title: Named pipes connections failure issue 
description: This article provides a resolution for the named pipes connections failure consistent authentication error.
ms.date: 01/24/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Troubleshooting the Named Pipes connections issue

This article helps you to resolve consistent authentication issue that causes the Named Pipes connections failure error.

## Symptoms

The SQLOLEDB provider displays a ["SQL Server does not exist or access denied"](../startup-shutdown/event-id-7000-access-denied.md) error message.

Some other providers display both the following messages in a random order, whether you use integrated security or a Microsoft SQL Server login:

> A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections.
> 
> Could not open a connection to SQL Server.

Some other providers might additionally display "Login timeout expired" within the error message.

## Cause

The Named Pipes connections fail because the user doesn't have permission to log in to Windows.

## Resolution

Add the user to the Users group on the server that's running SQL Server. If SQL Server is mirrored or clustered, take the same action on all computers within the group.
