---
title: Couldn't remove a resource when disabling Salesforce server-to-server flow
description: Resolves an error that occurs when a resource can't be removed while disabling Salesforce server-to-server flow.
ms.date: 05/09/2025
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# Couldn't remove a resource when disabling Salesforce server-to-server flow

This article helps you troubleshoot an error that occurs when a resource can't be removed while disabling Salesforce server-to-server flow.

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

When you try to disable Salesforce with server-to-server flow, one of the following error messages is displayed.

- Couldn't remove the permission set assignment due to an invalid reference key.
- Connection user ID not found or already removed.
- Couldn't remove the permission assignment. Something else depends on it.
- Couldn't remove the permission assignment because the assignment ID does not exist.
- Couldn't find the connected app. It may have been deleted earlier.
- Couldn't find the permission set. It may have been deleted earlier.
- Couldn't find the connection user. It may have been deleted earlier.

## Cause

When a disable request is received, the server attempts to delete deployed resources, such as the connected app and permission set. The error occurs when a resource either no longer exists or cannot be deleted due to dependencies from other components.

## Resolution

To resolve this issue, try disabling the connection again. If the issue persists, gather the error details and contact [Microsoft support](/microsoft-sales-copilot/get-support).

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
