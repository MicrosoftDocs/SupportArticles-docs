---
title: First Salesforce CRM user can't access Copilot for Sales
description: Resolves the error message that occurs in Microsoft Copilot for Sales related to signing in to Salesforce.
ms.date: 12/26/2023
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# First Salesforce CRM user can't access Copilot for Sales

This article helps you troubleshoot and resolve the error messages that occurs in Microsoft Copilot for Sales related to signing in to Salesforce.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | First user who tries to sign-in to Salesforce CRM from Copilot for Sales   |

## Symptoms

When the first user in an organization tries to sign-in to Salesforce CRM from Copilot for Sales, a trial environment needs to be created. When the user doesn't have permission to create a trial environment, the following error message is displayed:

> Updated setting required  
> To use this app, ask your Power Platform admin to let you use Copilot for Sales, and include the error details in your request.

:::image type="content" source="media/first-user-cant-create-trial-environment/updated-setting-required-error.png" alt-text="Screenshot that shows the error that occurs when a user can't access Copilot for Sales.":::

## Cause

Tenant's administrators have disabled trial environment creation for non-administrator users.

## Resoluton

As a tenant administrator, followg these steps to allow users to create trial environments:

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/) with your administrator credentials.
2. In the left navigation pane, select **Settings**.
3. On the **Tenant settings** page, select **Trial environment assignments**.
4. In the **Trial environment assignments** panel, select **Everyone**.

    :::image type="content" source="media/first-user-cant-create-trial-environment/erveryone-option-in-tenant-settings.png" alt-text="Screenshot that shows how to update trial environment assignments.":::

5. Select **Save**.

## More information

If your issue is still not resolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
