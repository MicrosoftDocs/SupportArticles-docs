---
title: Trouble connecting to Salesforce error when accessing Salesforce with server-to-server flow
description: Resolves an error that occurs due to invalid client ID of the connected app in Salesforce.
ms.date: 05/12/2025
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# "Trouble connecting to Salesforce" error when accessing Salesforce with server-to-server flow

This article helps you troubleshoot and resolve the "Trouble connecting to Salesforce" error when you access Salesforce with server-to-server flow.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | All users  |

## Symptoms

When a user tries to access Salesforce with server-to-server flow, the following error message is displayed.

> Trouble connecting to Salesforce.

The related error message reads "Couldn't get Client ID for access token retrieval from Salesforce. The connected app might be misconfigured.".

## Cause

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user. An access token is retrieved with the client ID and the secret of the connected app. The error occurs when the client ID is invalid.

## Resolution

To resolve this issue, contact Microsoft support and provide the following information:
- If the connected app "Copilot for Sales Connected App" was deleted accidentally. 
- If the connected app is still available, get the client ID of the connected app.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]