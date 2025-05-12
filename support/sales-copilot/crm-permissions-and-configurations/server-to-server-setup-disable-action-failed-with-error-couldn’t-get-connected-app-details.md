---
title: Couldn’t get connected app details. Disable Action Failed error when enable Salesforce server-to-server flow
description: This article helps you troubleshoot the error "Couldn’t get connected app details for the Salesforce organization." when you disable Salesforce server-to-server flow.
ms.date: 05/12/2025
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# "Couldn’t get connected app details. Disable Action Failed" error when enable Salesforce server-to-server flow

This article helps you troubleshoot the error "Couldn’t get connected app details for the Salesforce organization." when you disable Salesforce server-to-server flow.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Administrator  |

## Symptoms

When you try to disable Salesforce with server-to-server flow, you receive the following error message:

> Couldn’t get connected app details for the Salesforce organization.

You see the error "Couldn’t get connected app details for the Salesforce organization." on the UI.

## Cause

When a disable request is received, the server attempts to delete deployed resources, such as the connected app, permission set, and others. This error indicates that the connected app information could not be retrieved during the deletion process, possibly because it no longer exists or due to access restrictions.

## Resolution

Please try again. If the problem continues, note the error details shown on the UI and contact support team for assistance.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]