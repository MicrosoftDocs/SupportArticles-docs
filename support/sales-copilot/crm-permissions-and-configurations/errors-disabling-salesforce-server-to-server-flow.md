---
title: Errors When Disabling Salesforce With Server-to-server Flow
description: Resolves errors that might occur when disabling Salesforce with server-to-server flow in Microsoft Copilot for Sales.
ms.date: 05/23/2025
author: sbmjais
ms.author: shjais
ms.reviewer: marrabi
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# Errors that occur when disabling Salesforce with server-to-server flow

This article helps you solve errors that might occur when you try to disable Salesforce with server-to-server flow in Microsoft Copilot for Sales.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Administrator  |

## "Couldn't get connected app details for the Salesforce organization" error

### Symptoms

When you try to disable Salesforce with server-to-server flow, the following error message might occur:

> Couldn't get connected app details for the Salesforce organization.

### Cause

When a disable request is received, the server attempts to delete deployed resources, such as the connected app and permission set. The error occurs when the server can't retrieve the connected app information during the deletion process.

### Resolution

To resolve this issue, try disabling Salesforce again. If the issue persists, gather the error details and contact [Microsoft support](/microsoft-sales-copilot/get-support).

## "Couldn't remove the connected app" error

### Symptoms

When you try to disable Salesforce with server-to-server flow, the following error message might occur:

> Couldn't remove the connected app. It may be read-only, missing, or restricted.

### Cause

When a disable request is received, the server attempts to delete deployed resources, such as the connected app and permission set. The error occurs when the current user doesn't have the permissions to delete the connected app, or the app has already been deleted.

### Resolution

To resolve this issue, confirm that the connected app exists.

1. Sign in to Salesforce CRM as an administrator.

1. Go to **Setup** > **Apps** > **Connected Apps** > **Manage Connected Apps**.

1. Confirm that the **Copilot for Sales Connected App** connected app exists.

If this issue persists, contact [Microsoft support](/microsoft-sales-copilot/get-support) for further assistance.

## "Couldn't remove the permission set" error

### Symptoms

When you try to disable Salesforce with server-to-server flow, the following error message might occur:

> Couldn't remove the permission set. It may be read-only, missing, or restricted.

### Cause

When a disable request is received, the server attempts to delete deployed resources, such as the connected app and permission set. The error occurs when the current user doesn't have the permissions to delete the permission set, or the permission set has already been deleted.

### Resolution

To resolve this issue, confirm that the permission set exists.

1. Open the Salesforce Developer Console.

1. Run the following query to confirm the permission set exists:

    ```sql
    SELECT Id, Name, Label, Description FROM PermissionSet WHERE Name = 'CopilotForSalesPermissionSet'
    ```

If this issue persists, contact [Microsoft support](/microsoft-sales-copilot/get-support) for further assistance.

## An error occurs when a resource can't be removed

### Symptoms

When you try to disable Salesforce with server-to-server flow, one of the following error messages might occur:

- > Couldn't remove the permission set assignment due to an invalid reference key.
- > Connection user ID not found or already removed.
- > Couldn't remove the permission assignment. Something else depends on it.
- > Couldn't remove the permission assignment because the assignment ID does not exist.
- > Couldn't find the connected app. It may have been deleted earlier.
- > Couldn't find the permission set. It may have been deleted earlier.
- > Couldn't find the connection user. It may have been deleted earlier.

### Cause

When a disable request is received, the server attempts to delete deployed resources, such as the connected app and permission set. The error occurs when a resource either no longer exists or can't be deleted due to dependencies from other components.

### Resolution

To resolve this issue, try disabling the connection again. If the issue persists, gather the error details and contact [Microsoft support](/microsoft-sales-copilot/get-support).

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
