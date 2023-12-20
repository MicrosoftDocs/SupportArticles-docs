---
title: Can't create private channels in Microsoft Teams
description: Troubleshoot and resolve issues when you can't create private channels in Microsoft Teams.
ms.date: 10/31/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# Can't create private channels in Microsoft Teams

This article helps you troubleshoot and resolve issues when you can't create private channels in Teams.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365 and Salesforce      |
|**Users**     | All users |

## Symptom

When you try creating a collaboration space in Outlook using an existing team with a private channel, the following error message is displayed: Couldn't add channel.

:::image type="content" source="media/tsg-private-channel.png" alt-text="Error when creating a private channel.":::

## Cause

User doesn't have permissions to create private channels in Teams.

## Solution

Ask your administrator to grant you permissions to create private channels in Teams using either of the following methods:

**Method 1: From Microsoft 365 admin center**

1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com/) as a Dynamics 365 admin.

2. In the left pane, select **Teams & groups** > **Policies**.

3. Select the Teams policy affecting user and select **Create private channels**.

    :::image type="content" source="media/tsg-private-channel1.png" alt-text="Allow creating a private channel from Microsoft 365 admin center.":::

**Method 2: From Microsoft Teams**

1. Open Microsoft Teams and navigate to the team where the user couldn't create a private channel. 

2. Select the **More options** icon next to the team name and select **Manage team**.

3. Select the **Settings** tab.

4. Under **Member permissions**, select **Allow members to create private channels**.

    :::image type="content" source="media/tsg-private-channel2.png" alt-text="Allow creating a private channel from Microsoft Teams.":::


## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.