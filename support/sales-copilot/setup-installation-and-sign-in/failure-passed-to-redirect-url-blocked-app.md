---
title: Can't sign in to Salesforce CRM when the Power Platform app is blocked
description: Resolves the Failure passed to redirect url error that occurs when the Power Platform app is blocked in Microsoft Copilot for Sales.
ms.date: 01/04/2024
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# "Failure passed to redirect url" error when signing in to Salesforce CRM

This article helps you troubleshoot and resolve sign-in issues when the Microsoft Power Platform app is blocked by an administrator in Microsoft Copilot for Sales.

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshots in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in and Teams app    |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users trying to authentication to their Salesforce instance |

## Symptoms

When you try to sign in to Salesforce CRM from the [Copilot for Sales add-in for Outlook](/microsoft-sales-copilot/use-sales-copilot-outlook), the following error message is displayed:

> Failure passed to redirect url. error=OAUTH_APP_BLOCKED error_description=this app is blocked by admin

:::image type="content" source="media/failure-passed-to-redirect-url-blocked-app/tsg-app-block-error.png" alt-text="Screenshot that shows the Failure passed to redirect URL error.":::

In Salesforce CRM, the Microsoft Power Platform app is shown as blocked on the **Connected Apps OAuth Usage** page.

:::image type="content" source="media/failure-passed-to-redirect-url-blocked-app/power-platform-blocked.png" alt-text="Screenshot that shows Microsoft Power Platform is blocked in Salesforce CRM." lightbox="media/failure-passed-to-redirect-url-blocked-app/power-platform-blocked.png":::

## Cause

The Microsoft Power Platform app in Salesforce CRM is blocked by an administrator.

Copilot for Sales connects to Salesforce CRM through the Microsoft Power Platform connected app. When the Microsoft Power Platform app is blocked by an administrator, the Salesforce authentication process fails with the error message.

## Resolution

Copilot for Sales uses the Microsoft Power Platform connected app to connect to Salesforce CRM. Ensure that the connected app isn't blocked in Salesforce CRM.

1. Sign in to Salesforce CRM as an administrator.
1. Go to **Setup** > **Platform Tools** > **Apps** > **Connected Apps** > **Connected Apps OAuth Usage**.
1. For the **Microsoft Power Platform** app, select **Unblock**.

    The **Microsoft Power Platform** app disappears from the list, but it's unblocked.

    After the first successful sign-in from the first user using Copilot for Sales, the **Microsoft Power Platform** app appears in the list again.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]