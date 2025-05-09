---
title: Server-to-Server Setup Disable Action Failed with Error Couldn’t remove a resource
description: This article helps you troubleshoot the error that couldn’t remove a resource when you disable Salesforce Server-to-server flow.
ms.date: 05/09/2025
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# Server-to-Server Setup Disable Action Failed with Error Couldn’t remove a resource

This article helps you troubleshoot the error that couldn’t remove a resource when you disable Salesforce Server-to-server flow.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | Administrator  |

## Symptoms

When administrator try to disable Salesforce with server-to-server flow, you receive the following error message:

> Couldn’t remove the permission set assignment due to an invalid reference key.

You see the error "Couldn’t remove the permission set assignment due to an invalid reference key." on the UI.

## Cause

When a "disable" request is received, the server attempts to delete the associated deployed resources—such as the connected app, permission set, and related components. This error typically occurs when a resource either no longer exists or cannot be deleted due to dependencies from other components.

You may encounter the following errors in the UI:

- Failed to remove the permission set assignment due to an invalid reference key.
- Connection user ID not found or may have already been removed.
- Unable to remove the permission assignment due to existing dependencies.
- Failed to remove the permission assignment because the assignment ID doesn’t exist.
- Connected app not found; it may have been deleted previously.
- Permission set not found; it may have been deleted previously.
- Connection user not found; it may have been deleted previously.

## Resolution

Please try again. If the problem continues, note the error details shown on the UI and contact support team for assistance.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
