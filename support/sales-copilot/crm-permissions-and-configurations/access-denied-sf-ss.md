---
title: Access denied for this user error when accessing Salesforce with server-to-server flow
description: Resolves an error that occurs due to invalid permissions of the connected app in Salesforce.
ms.date: 05/12/2025
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# "Access denied for this user" error when accessing Salesforce with server-to-server flow

This article helps you troubleshoot and resolve the "Access denied for this user" error when you access Salesforce with server-to-server flow.

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

> Access denied for this user.

The related error message reads "User doesn't have admin permission to access the connected app."

## Cause

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user. An access token is retrieved with the credentials of the connected app. The error occurs when the integration user is not approved to access the connected app.

## Resolution

To resolve this issue, you must fix the connected app configuration in Salesforce. 

1. Sign in to Salesforce CRM as an administrator.
1. Go to **Setup** > **Platform Tools** > **Apps** > **Connected Apps** > **Managed Connected Apps**.
1. On the **Connected Apps** page, select **Copilot for Sales Connected App**.
1. Under **Custom Connected App Handler**, ensure that the value of **Run As** is set to **Copilot for Sales Integration User**.
1. Go to **Administration** > **Users** > **Users** and confirm that the profile of the integration user is **CopilotForSalesIntegrationProfile**.

Also, check is there were unintended changes made to the connected app configuration. If yes, revert the changes to the original configuration.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
