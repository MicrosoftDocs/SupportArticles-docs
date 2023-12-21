---
title: Sign in issue when app is blocked
description: Troubleshoot and resolve sign in issues when app is blocked.
ms.date: 12/20/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# Sign in issue when app is blocked

This article helps you troubleshoot and resolve sign in issues when app is blocked by the administrator.

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

1. When trying to sign in to Salesforce CRM from Copilot for Sales add-in for Outlook, the following error message is displayed: `Failure passed to redirect url. error=OAUTH_APP_BLOCKED error_description=this app is blocked by admin`

    :::image type="content" source="media/tsg-app-block-error.png" alt-text="Screenshot showing app blocked error.":::

2. In Salesforce CRM, Microsoft Power Platform is shown as blocked on the **Connected Apps OAuth Usage** page.

    :::image type="content" source="media/tsg-app-blocked.png" alt-text="Screenshot showing app blocked in Salesforce CRM.":::

## Cause

The Microsoft Power Platform app in Salesforce CRM is blocked by an administrator.

Copilot for Sales connects to Salesforce CRM through the **Microsoft Power Platform** connected app. When the **Microsoft Power Platform** app is blocked by an administrator, the Salesforce authentication process fails, threreby resulting in the error message.

## Solution

Copilot for Sales uses the **Microsoft Power Platform** connected app to connect to Salesforce CRM. Ensure that the connected app is not blocked in Salesforce CRM.

1. Sign in to Salesforce CRM as an administrator.
1. Go to **Setup** > **Platform Tools** > **Apps** > **Connected Apps** > **Connected Apps OAuth Usage**.
1. For the **Microsoft Power Platform** app, select **Unblock**.
    The **Microsoft Power Platform** app disappears from the list, but it's unblocked.
    After the first successful sign-in from the first user using Copilot for Sales, the **Microsoft Power Platform** app appears in the list again.


## Is your issue still not resolved?

Visit the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

