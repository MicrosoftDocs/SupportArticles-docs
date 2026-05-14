---
title: First Salesforce CRM user can't access Sales agent
description: Resolves an error message that occurs in Sales agent related to signing in to Salesforce.
ms.date: 05/14/2026
ms.custom: sap:Setup, Installation and Sign-in\CRM Sign-In & Sign Out
ms.reviewer: shjais, v-shaywood
---
# First Salesforce CRM user can't access Sales agent

This article helps you troubleshoot and resolve an error message that occurs in Sales agent related to signing in to Salesforce.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales agent in Outlook        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | The first user who tries to sign in to Salesforce CRM from Sales agent.   |

## Symptoms

When the first user in an organization tries to sign in to Salesforce CRM from Sales agent, a trial environment needs to be created. When the user doesn't have permission to create a trial environment, the following error message is displayed:

> Updated setting required  
> To use this app, ask your Power Platform admin to let you use Sales, and include the error details in your request.

## Cause

Tenant's administrators have disabled trial environment creation for non-administrator users.

## Resolution

As a tenant administrator, follow these steps to allow users to create trial environments:

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/) with your administrator credentials.
2. In the left navigation pane, select **Settings**.
3. On the **Tenant settings** page, select **Trial environment assignments**.
4. In the **Trial environment assignments** panel, select **Everyone**.

    :::image type="content" source="media/first-user-cant-create-trial-environment/erveryone-option-in-tenant-settings.png" alt-text="Screenshot that shows how to update trial environment assignments." lightbox="media/first-user-cant-create-trial-environment/erveryone-option-in-tenant-settings.png":::

5. Select **Save**.

## More information

If your issue is still unresolved, go to the [Sales agent - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
