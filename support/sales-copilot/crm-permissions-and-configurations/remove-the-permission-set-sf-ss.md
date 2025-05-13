---
title: Couldn't remove the permission set. It may be read-only, missing, or restricted error when disabling Salesforce server-to-server flow
description: Resolves an error that occurs when you disable Salesforce Server-to-Server flow and receive the message. Couldn’t remove the permission set. It may be read-only, missing, or restricted.
ms.date: 05/13/2025
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# "Couldn't remove the permission set. It may be read-only, missing, or restricted" error when disabling Salesforce server-to-server flow

This article helps you troubleshoot the error "Couldn’t remove the permission set. It may be read-only, missing, or restricted." when you disable Salesforce Server-to-server flow.

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

When you try to disable Salesforce with server-to-server flow, you receive the following error message:

> Couldn’t remove the permission set. It may be read-only, missing, or restricted.

## Cause

When a disable request is received, the server attempts to delete deployed resources, such as the connected app, permission set, and others. This error indicates that the current user either lacks the necessary permissions to delete the connected app or the app has already been removed.

## Resolution

1. Ensure that the user logged into the Teams admin settings has the necessary permissions to modify all data and manage permission sets. If the current user lacks these permissions, either assign the appropriate access or switch to a user who has them.

2. Open the Salesforce Developer Console and run the following query to search for the permission set. Confirm that the specified permission set exists.

SELECT Id, Name, Label, Description FROM PermissionSet WHERE Name =                 
'CopilotForSalesPermissionSet'

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
