---
title: Server-to-server authorization failed error when accessing Salesforce with server-to-server flow
description: Resolves an error that occurs due to invalid secret of the connected app in Salesforce.
ms.date: 05/19/2025
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# "Server-to-server authorization failed" error when accessing Salesforce with server-to-server flow

This article helps you troubleshoot and resolve the "Server-to-server authorization failed" error when you access Salesforce with server-to-server flow.

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

> Server-to-server authorization failed.

## Error 1: Couldn't get client credentials to access Salesforce

## Cause 1

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user. An access token is retrieved with the client ID and the secret of the connected app. The error occurs when the secret is invalid.

## Resolution 1

To resolve this issue, contact [Microsoft support](/microsoft-sales-copilot/get-support) and provide the following information:
- If the connected app "Copilot for Sales Connected App" was updated accidentally. 
- If the connected app is still available, get the ID of the connected app.

## Error 2: Session ID isn't allowed for use REST API access at Salesforce

## Cause 2

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The error occurs when appropriate OAuth scope is not set for the connected app.

## Resolution 2

To resolve this issue, contact your administrator to set the appropriate OAuth scope for the connected app Confirm that the connection is still active in admin settings.

1. Sign in to Salesforce CRM as an administrator.
1. Go to **Setup** > **Platform Tools** > **Apps** > **App Manager**.
1. On **Copilot for Sales Connected App** row, select the down arrow, and then select **Edit**.
1. Under **API (Enable OAuth Settings)**, confirm that **Manage user data via APIs (api)** is selected in the **Selected OAuth Scopes** list. If it's not selected, check if the setting was changed manually by mistake. If yes, revert the changes. 
    
    If you don't select **Manage user data via APIs (api)**, the connected app won't be able to access Salesforce data.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]