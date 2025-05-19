---
title: Couldn't remove the permission set when disabling Salesforce server-to-server flow
description: Resolves an error that occurs when the server is unable to delete the permission set during the disable process.
ms.date: 05/13/2025
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# Couldn't remove the permission set when disabling Salesforce server-to-server flow

This article helps you troubleshoot the "Couldn't remove the permission set. It may be read-only, missing, or restricted." error when you disable Salesforce Server-to-server flow.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | Administrator   |

## Symptoms

When you try to disable Salesforce with server-to-server flow, the following error message is displayed.

> Couldn't remove the permission set. It may be read-only, missing, or restricted.

## Cause

When a disable request is received, the server attempts to delete deployed resources, such as the connected app and permission set. The error occurs when the current user doesn't have the permissions to delete the permission set or the permission set is already deleted.

## Resolution

To resolve this issue, confirm that the permission set exists.

Open the Salesforce Developer Console and run the following query to search for the permission set. Confirm that the **Copilot for Sales Permission Set** permission set exists.

```sql
SELECT Id, Name, Label, Description FROM PermissionSet WHERE Name = 'CopilotForSalesPermissionSet'
```

If this issue persists, contact [Microsoft support](/microsoft-sales-copilot/get-support) for further assistance.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
