---
title: First Salesforce CRM user unable to access Copilot for Sales
description: Troubleshoot and resolve error messages in Copilot for Sales related to signing in to Salesforce.
ms.date: 12/20/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# First Salesforce CRM user unable to access Copilot for Sales

This article helps you troubleshoot and resolve error messages in Copilot for Sales related to signing in to Salesforce.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | First user who tries to sign-in to Salesforce CRM from Copilot for Sales   |

## Symptom

When first user in an organization tries to sign-in to Salesforce CRM from Copilot for Sales, a trial environment needs to be created. When the user doesn't have permission to create a trial environment, the following error message is displayed `To use this app, ask your Power Platform admin to let you use Copilot for Sales, and include the error details in your request.`.

:::image type="content" source="media/tsg-env-error.png" alt-text="Unable to access Copilot for Sales.":::

## Cause

First user failed to sign in to Salesforce CRM using Copilot for Sales.

Tenant's administrators have disabled trial environment creation for non-administrator users. 

## Solution

As a tenant administrator, allow users to create trial environments.

1. Sign in to [Power Platform admin center](https://admin.powerplatform.microsoft.com/) with your administrator credentials.

2. In the left navigation pane, select **Settings**.

3. On the **Tenant settings** page, select **Trial environment assignments**.

4. In the **Trial environment assignments** panel, select **Everyone**.

    :::image type="content" source="media/tsg-tenant-settings.png" alt-text="Update trial environment assignments.":::

5. Select **Save**.

## Is your issue still not resolved?

Visit the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
