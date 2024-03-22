---
title: Opportunity summary not displayed in deal rooms
description: Resolves an issue where the opportunity summary isn't displayed in deal rooms.
ms.date: 01/10/2024
ms.topic: troubleshooting-problem-resolution
author: sbmjais
ms.author: shjais
ms.custom: sap:Teams Collaboration Spaces\Deal room template for CRM opportunities
---
# Opportunity summary isn't displayed in deal rooms

This article helps you troubleshoot and resolve issues when the opportunity summary isn't displayed in deal rooms.

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshots in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales app in Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365 and Salesforce      |
|**Users**     | Users trying to update a CRM record from Copilot for Sales |

## Symptoms

When you create a deal room from Copilot for Sales in Outlook, and then open it in the Copilot for Sales app in Microsoft Teams, the [opportunity summary](/microsoft-sales-copilot/view-opportunity-summary) isn't displayed in the deal room. The following message is displayed instead:

> To unlock AI-powered opportunity summaries, install the Copilot for Sales Teams app.

:::image type="content" source="media/opportunity-summary-not-displayed/unlock-ai-powered-opportunity-summaries-error.png" alt-text="Screenshot that shows the message instead of the opportunity summary.":::

## Cause

The Copilot for Sales Teams app isn't installed.

When you [set up a deal room](/microsoft-sales-copilot/set-up-team-deal-room-template) from Copilot for Sales in Outlook, the Copilot for Sales Teams app and bot are automatically installed for the selected team, and the opportunity summary is displayed in the deal room. If the Copilot for Sales Teams app isn't installed for the team, a message is displayed instead of the opportunity summary in the deal room.

## Resolution

To resolve this issue, you must manually install the Copilot for Sales Teams app and bot for the team, and then generate the opportunity summary again.

1. In Microsoft Teams, hover over the team name, and then select **More options (...)** > **Manage team**.

2. Go to the Apps tab, and then select **Get more apps**.

3. Search for **Copilot for Sales**, and then select its card.

4. Select the down arrow next to **Open**, and then select **Add to a team**.

    :::image type="content" source="media/opportunity-summary-not-displayed/add-copilot-for-sales-to-a-team.png" alt-text="Screenshot that shows the option to add the Copilot for Sales app to a team.":::

    The **Add Copilot for Sales to a team** dialog is displayed with the team name preselected.

5. Select **Set up a bot**.

    :::image type="content" source="media/opportunity-summary-not-displayed/set-up-bot-option.png" alt-text="Screenshot that shows the Set up a bot button on the Add Copilot for Sales to a team page to set up a bot.":::

6. Open the deal room channel and select **Start a post**.

7. In the message box, type *@Copilot for Sales*, select the Copilot for Sales app, type *show opportunity summary*, and then select **Post** to generate the opportunity summary.

    :::image type="content" source="media/opportunity-summary-not-displayed/opportunity-summary-generate.png" alt-text="Screenshot that shows the prompt to generate the opportunity summary.":::

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
