---
title: Opportunity summary not displayed in deal rooms
description: Troubleshoot and resolve issues when the opportunity summary isn't displayed in deal rooms.
ms.date: 12/20/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
ms.custom:
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:11/21/2023
  - ai-gen-desc
---

# Opportunity summary not displayed in deal rooms

This article helps you troubleshoot and resolve issues when the opportunity summary isn't displayed in deal rooms.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot app in Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365 and Salesforce      |
|**Users**     | Users trying to update a CRM record from Sales Copilot |

## Symptom

When you create a deal room from Sales Copilot in Outlook, and then open it in the Sales Copilot app in Microsoft Teams, the opportunity summary isn't displayed in the deal room. The following message is displayed instead: `To unlock AI-powered opportunity summaries, install the Sales Copilot Teams app.`

:::image type="content" source="media/tsg-oppty-summary-error.png" alt-text="Screenshot showing a message instead of opportunity summary.":::

## Cause

Sales Copilot Teams app isn't installed.

When you set up a deal room from Sales Copilot in Outlook, the Sales Copilot Teams app and bot are automatically installed for the selected team, and opportunity summary is displayed in the deal room. If the Sales Copilot Teams app isn't installed for the team, a message is displayed instead of the opportunity summary in the deal room.

## Solution

To resolve this issue, you must manually install the Sales Copilot Teams app and bot for the team, and then generate the opportunity summary again.

1. In Microsoft Teams, hover over the team name, and then select **More options (...)** > **Manage team**.

2. Go to the Apps tab, and then select **Get more apps**.

3. Search for **Sales Copilot**, and then select its card.

4. Select the down arrow next to **Open**, and then select **Add to a team**.

    :::image type="content" source="media/tsg-oppty-summary-add-team.png" alt-text="Screenshot showing option to add the app to a team.":::

    The **Add Sales Copilot to a team** dialog box is displayed with the team name preselected.

5. Select **Set up a bot**.

    :::image type="content" source="media/tsg-oppty-summary-bot.png" alt-text="Screenshot showing button to set up a bot.":::

6. Open the deal room channel, and select **Start a post**.

7. In the message box, type `@Sales Copilot`, select the Sales Copilot app, type `show opportunity summary`, and then select **Post** to generate the opportunity summary.

    :::image type="content" source="media/tsg-oppty-summary-generate.png" alt-text="Screenshot showing prompt to generate opportunity summary.":::

## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
