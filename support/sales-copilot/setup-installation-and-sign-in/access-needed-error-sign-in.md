---
title: Access needed error when signing in to Dynamics 365 
description: Resolves the Access needed error in Microsoft Copilot for Sales when a user is either disabled or not a member of any business unit in Microsoft Dynamics 365.
ms.date: 01/10/2024
author: sbmjais
ms.author: shjais
ms.custom: sap:Setup, Installation and Sign-in\CRM Sign-In & Sign Out
---
# "Access needed" error when signing in to Dynamics 365 

This article helps you troubleshoot and resolve the "Access needed" error in Microsoft Copilot for Sales when a user is either disabled or not a member of any business unit in Microsoft Dynamics 365.

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshot in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365        |
|**Users**     | Users who are either disabled or not a member of any business unit in Dynamics 365  |

## Symptoms

When a Dynamics 365 user tries to sign in to Copilot for Sales, the following error message is displayed:

> Access needed

:::image type="content" source="media/access-needed-error-sign-in/access-needed-error.png" alt-text="Screenshot that shows the Access needed error.":::

## Cause

The **Access needed** error message is displayed because of one of the following reasons:

- The user is either disabled or not a member of any business unit in Dynamics 365.
- The user isn't a member of the Microsoft Entra ID security group.

## Resolution 1: Enable the user in Dynamics 365

1. Sign in to Dynamics 365 with the System Administrator credentials.
2. Go to **Settings** > **Advanced Settings**.
3. On the command bar, select **Settings** > **Security**.
4. Select **Users**, and then change the view to **Disabled users**.

    If the affected user is shown as disabled, enable the user.

## Resolution 2: Add the user as a member of the Microsoft Entra ID security group

1. Sign in to the [Power Platform Admin Center](https://admin.powerplatform.microsoft.com) with the System Administrator credentials.
1. In the left navigation pane, under **Admin centers**, select **Microsoft Entra ID**.

    The **Microsoft Entra admin center** opens.

1. In the left navigation pane, under **Identity**, select **Groups** > **All Groups**.
1. Find the security group to which the user needs to be assigned, and then select to open it.
1. Under **Manage**, select **Members**, and then select **Add members**.
1. Find and add the user to the security group.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
