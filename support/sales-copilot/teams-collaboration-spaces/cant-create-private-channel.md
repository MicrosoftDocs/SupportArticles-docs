---
title: Can't create a private channel in Microsoft Teams
description: Resolves an issue where you can't create a private channel in Microsoft Teams.
ms.date: 02/05/2025
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:Teams Collaboration Spaces\Collaboration Space Creation and access from Outlook Side-Panel
---
# "Couldn't add channel" error when creating a private channel in Microsoft Teams

This article helps you troubleshoot and resolve issues when you can't create a private channel in Microsoft Teams.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365 and Salesforce      |
|**Users**     | All users |

## Symptoms

When you try to create a collaboration space in Microsoft Teams using an existing team with a private channel, the following error message is displayed:

> Couldn't add channel.

:::image type="content" source="media/cant-create-private-channel/couldnt-add-channel-error.png" alt-text="Screenshot that shows the error when creating a private channel.":::

## Cause

You don't have permission to create private channels in Microsoft Teams.

## Resolution

To solve this issue, contact your administrator to grant you permission to create private channels in Microsoft Teams using one of the following methods:

### Method 1: From the Microsoft 365 admin center

1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com/) as a Dynamics 365 administrator.
2. In the left pane, select **Teams & groups** > **Policies**.
3. Select the Teams policy affecting the user and select **Create private channels**.

    :::image type="content" source="media/cant-create-private-channel/create-private-channels-option.png" alt-text="Screenshot that shows how to allow the creation of a private channel from Microsoft 365 admin center." lightbox="media/cant-create-private-channel/create-private-channels-option.png":::

### Method 2: From Microsoft Teams

1. Open Microsoft Teams and navigate to the team where the user can't create a private channel.
2. Select the **More options** icon next to the team name and select **Manage team**.
3. Select the **Settings** tab.
4. Under **Member permissions**, select **Allow members to create private channels**.

    :::image type="content" source="media/cant-create-private-channel/allow-members-to-create-private-channels.png" alt-text="Screenshot that shows how to allow the creation of a private channel from Microsoft Teams.":::

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
