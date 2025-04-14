---
title: Copilot Studio Bots Affect Workstreams And Agent Transfers
description: Helps resolve issues related to bot management and prevent disruptions in chat queues and agent transfers in Microsoft Dynamics 365 Customer Service.
ms.reviewer: ghoshsoham
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/14/2025
ms.custom: sap:Cases or Incidents, DFM
---
# Workstreams and agents are affected by changes made to other Copilot Studio bots

This article addresses issues encountered when adding or managing Copilot Studio bots in Dynamics 365 Customer Service that impact workstreams and agent transfers.

## Symptoms

You might encounter the following issues when working with [Copilot Studio bots](/dynamics365/customer-service/administer/configure-bot-virtual-agent) in Dynamics 365 Customer Service:

- Adding a new bot to a workstream inadvertently updates or replaces bots or agents in other existing chat or messaging workstreams.
- Bots don't work correctly, causing chat queues to fail.
- Certain bot versions can't be retrieved in the Customer Service admin center.

## Cause

The issue can occur if the `iscustomizable` flag is enabled for the bot skill. When this flag is enabled, any changes made to one bot or workstream can inadvertently affect other bots or workstreams.

## Resolution

To prevent a bot from affecting other workstreams, follow these steps to disable the `iscustomizable` flag for the bot skill:

1. Navigate to **Settings** > **Solutions** in Dynamics 365 Customer Service, and locate the solution that contains the bot and skills.

2. Verify that the `iscustomizable` flag isn't enabled for the skill in question.

For more information, see [Use managed properties](/power-platform/alm/use-managed-properties).

If the issue persists, you can manually edit the XML file of the solution to disable the `iscustomizable` flag:

1. Export the solution containing the bot and skills.
2. Open the solution file in a text editor.
3. Locate the `iscustomizable` flag for the relevant skill.
4. Set the `iscustomizable` flag to **false**.
5. Save the changes to the XML file.
6. Import the modified solution back into Dynamics 365.

By setting the `iscustomizable` flag to **false**, the skill becomes non-editable, ensuring that changes to one bot or workstream don't unintentionally impact others.
