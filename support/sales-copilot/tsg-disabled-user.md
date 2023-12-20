---
title: Unable to sign in to Dynamics 365
description: Troubleshoot and resolve error messages in Sales Copilot when a user is either disabled or not a member of any business unit in Dynamics 365.
ms.date: 12/20/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
---

# Unable to sign in to Dynamics 365

This article helps you troubleshoot and resolve error in Sales Copilot when a user is either disabled or not a member of any business unit in Dynamics 365.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365        |
|**Users**     | Users who are either disabled or not a member of any business unit in Dynamics 365  |

## Symptom

When Dynamics 365 users try to sign in to Sales Copilot, the following error message is displayed: `Access needed`

:::image type="content" source="media/tsg-disabled-user-error.png" alt-text="Screenshot showing access needed error.":::

## Cause

The **Access needed** error message is displayed because of one of the following reasons:
- User is either disabled or not a member of any business unit in Dynamics 365
- User isn't a member of Microsoft Entra ID security group.

## Solution 1: Enable the user in Dynamics 365

1. Sign in to Dynamics 365 with the System Administrator credentials.

2. Go to **Settings** > **Advanced Settings**.

3. On the command bar, select **Settings** > **Security**.

4. Select **Users**, and then change the view to **Disabled users**.

    If the affected user is shown as disabled, enable the user.

## Solution 2: Add the user as a member of Microsoft Entra ID security group

1. Sign in to [Power Platform Admin Center](https://admin.powerplatform.microsoft.com) with the System Administrator credentials.

2. In the left navigation pane, under **Admin centers**, select **Microsoft Entra ID**.
    The **Microsoft Entra admin center** opens.

1. In the left navigation pane, under **Identity**, select **Groups** > **All Groups**.

1. Find the security group to which the user needs to be assigned, and then select to open it.

1. Under **Manage**, select **Members**, and then select **Add members**.

1. Find and add the user to the security group.

## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.