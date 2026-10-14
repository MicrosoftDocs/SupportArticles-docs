---
title: Errors When Disabling Salesforce with Server-to-Server Flow
description: Troubleshoot errors that occur when you disable Salesforce with a server-to-server flow in Sales agent, including connected app and permission set removal failures.
ms.date: 08/26/2026
ms.reviewer: marrabi, shjais, v-shaywood
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
ai-usage: ai-assisted
---
# Errors when you disable Salesforce with server-to-server flow

## Summary

This article helps you troubleshoot errors that occur when you disable Salesforce with a server-to-server flow in Sales agent. It covers errors that occur when the server can't get connected app details, can't remove the connected app or permission set, or can't remove a resource that's missing or has dependencies. It also points to the connector reset process to use as a last resort.

## Affected clients and configurations

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Microsoft Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Administrators  |

## Couldn't get connected app details for the Salesforce organization

### Symptoms

When you try to disable Salesforce with a server-to-server flow, the following error message might occur:

> Couldn't get connected app details for the Salesforce organization.

### Cause

When the server receives a disable request, it tries to delete deployed resources, such as the connected app and permission set. The error occurs when the server can't retrieve the connected app information during the deletion process.

### Solution

To resolve this issue, try disabling Salesforce again. If the issue persists, gather the error details and contact [Microsoft support](/microsoft-sales-copilot/get-support).

## Couldn't remove the connected app

### Symptoms

When you try to disable Salesforce with a server-to-server flow, the following error message might occur:

> Couldn't remove the connected app. It may be read-only, missing, or restricted.

### Cause

When the server receives a disable request, it tries to delete deployed resources, such as the connected app and permission set. This error occurs when the current user doesn't have permission to delete the connected app or the app is already deleted.

### Solution

To resolve this issue, confirm that the connected app exists.

1. Sign in to Salesforce CRM as an administrator.

1. Go to **Setup** > **Apps** > **Connected Apps** > **Manage Connected Apps**.

1. Confirm that the **Sales Connected App** connected app exists.

If this issue persists, contact [Microsoft support](/microsoft-sales-copilot/get-support) for further assistance.

## Couldn't remove the permission set

### Symptoms

When you try to disable Salesforce with a server-to-server flow, the following error message might occur:

> Couldn't remove the permission set. It may be read-only, missing, or restricted.

### Cause

When the server receives a disable request, it tries to delete deployed resources, such as the connected app and permission set. This error occurs when the current user doesn't have permission to delete the permission set or when the permission set is already deleted.

### Solution

To resolve this issue, confirm that the permission set exists.

1. Open the Salesforce Developer Console.

1. Run the following query to confirm the permission set exists:

    ```sql
    SELECT Id, Name, Label, Description FROM PermissionSet WHERE Name = 'CopilotForSalesPermissionSet'
    ```

If this issue persists, contact [Microsoft support](/microsoft-sales-copilot/get-support) for further assistance.

## Error when a resource can't be removed

### Symptoms

When you try to disable Salesforce with a server-to-server flow, you might see one of the following error messages:

> Couldn't remove the permission set assignment due to an invalid reference key.

> Connection user ID not found or already removed.

> Couldn't remove the permission assignment. Something else depends on it.

> Couldn't remove the permission assignment because the assignment ID does not exist.

> Couldn't find the connected app. It may have been deleted earlier.

> Couldn't find the permission set. It may have been deleted earlier.

> Couldn't find the connection user. It may have been deleted earlier.

### Cause

When the server receives a disable request, it tries to delete deployed resources, such as the connected app and permission set. This error occurs when a resource either no longer exists or can't be deleted because other components depend on it.

### Solution

To resolve this issue, try disabling the connection again. If the error continues, gather the error details and contact [Microsoft support](/microsoft-sales-copilot/get-support).

## Reset the Salesforce connector

If you still can't disable access after trying the solutions in this article, the artifacts in the Salesforce org and the stored credentials in Dataverse might be out of sync. As a last resort, remove both so that the org returns to a clean, unconnected state. For the full process, see [Reset Salesforce server-to-server connector](reset-salesforce-server-to-server-connector.md).

## Get help from the community

If your issue is still unresolved, go to the [Sales agent - Microsoft Community Hub](https://techcommunity.microsoft.com/category/microsoftviva/discussions/vivasales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
