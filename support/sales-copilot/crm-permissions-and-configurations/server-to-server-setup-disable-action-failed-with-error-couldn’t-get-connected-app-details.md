---
title: Server-to-Server Setup Disable Action Failed with Error Couldn’t get connected app details
description: This article helps you troubleshoot the error "Couldn’t get connected app details for the Salesforce organization." when you disable Salesforce server-to-server flow.
ms.date: 05/09/2025
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# Server-to-Server Setup Disable Action Failed with Error Couldn’t get connected app details

This article helps you troubleshoot the error "Couldn’t get connected app details for the Salesforce organization." when you disable Salesforce server-to-server flow.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Adminstarator  |

## Symptoms

When administrator try to disable Salesforce with server-to-server flow:

> Couldn’t get connected app details for the Salesforce organization.

You see the error "Couldn’t get connected app details for the Salesforce organization." on the UI.

## Cause

Upon receiving a "disable" request, server end tries to delete deployed resources, including connected app, permission set, etc. 

This error means that failed to get the connected app information when try to remove it.

## Resolution

Please try again. If the issue persists, please gather the error details on the UI and reach out to support team.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]