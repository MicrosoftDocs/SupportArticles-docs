---
title: Server-to-server authentication failed error when accessing Salesforce with server-to-server flow
description: Resolves an error that occurs due to misconfiguration of the connected app and integration user in Salesforce.
ms.date: 05/12/2025
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# "Server-to-server authentication failed" error when accessing Salesforce with server-to-server flow

This article helps you troubleshoot and resolve the "Server-to-server authentication failed" error when you access Salesforce with server-to-server flow.

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

> Server-to-server authentication failed.

The related error message can be one of the following:
- Client credentials flow is disabled in Salesforce.
- Couldn't get access token for client credentials flow in Salesforce.

## Cause

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user. An access token is retrieved with the credentials of the connected app. The error occurs when the connected app or the integration user is misconfigured.

## Resolution

To resolve this issue, ensure that the connected app and integration user configuration are correct. 

1. Sign in to Salesforce CRM as an administrator.
1. Go to **Setup** > **Platform Tools** > **Apps** > **App Manager**.
1. On **Copilot for Sales Connected App** row, select the down arrow, and then select **Edit**.
1. Under **API (Enable OAuth Settings)**, ensure that **Enable Client Credentials Flow** is selected.
1. Go to **Apps** > **Connected Apps** > **Managed Connected Apps**.
1. On the **Connected Apps** page, select **Copilot for Sales Connected App**.
1. Under **Custom Connected App Handler**, ensure that the value of **Run As** is set to **Copilot for Sales Integration User**.
1. Open user details for the **Copilot for Sales Integration User** user and confirm the following:
    1. Profile of the integration user is **CopilotForSalesIntegrationProfile**.
    1. User is associated with **Copilot for Sales connected app permission set** permission set.
    1. User is associated with **Salesforce API Integration** permission set license assignments.

Also, check if there were unintended changes made to the connected app or integration user configuration. If yes, revert the changes to the original configuration.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]