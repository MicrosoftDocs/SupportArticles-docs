---
title: Error occurs when you create or change client-only rules that apply to messages received from 20 or more people
description: This article describes an issue in which users cannot create or change client-only rules that apply to email messages that are received from 20 or more people. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - MET150
ms.custom: 
  - Outlook for Windows
  - CI 105069
  - CSSTroubleshoot
ms.reviewer: gquintin,tasitae,EXOL_Triage
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
ms.date: 10/30/2023
---

# Error in Outlook when you create or change client-only rules that apply to messages from 20 or more people

## Symptoms

In Microsoft Outlook, you either create a new client-only message rule or change an existing rule. When you save the rule or open the **Manage Rules & Alerts** window to view the rules, you receive one or both of the following error messages:

- > The rules on this computer do not match the rules on Microsoft Exchange. Only one set of rules can be kept. You will usually want to keep the rules on the server. Which rules do you want to keep?
- > One or more rules cannot be uploaded to Microsoft Exchange and have been deactivated. This could be because some of the parameters are not supported, or there is insufficient space to store all of your rules.

## Cause

This issue occurs if a client-only rule is created or changed to contain a total of 20 or more people who are selected from the Global Address List (GAL).

For example, the rule shown in the following screenshot is "(client-only)." This rule works because it includes only two people who were selected from the GAL in the "from" rule criteria. However, if the "from" criteria contained 20 or more people, the rule would cause the issue to occur.

:::image type="content" source="./media/create-modify-client-only-rule-with-error/Outlook-Rules.png" alt-text="Screenshot of the Rules and Alerts dialog box." border="false":::

Note: This issue occurs if the rule's action causes the rule to become a client-only rule. For example, any of the following rules can make this change:

- Assign it to the category
- Permanently delete it
- Flag message for follow up at this time
- Clear the Message Flag
- Print it
- Play a sound
- Mark it as read
- Display a specific message in the New Items Alert window
- Display a Desktop Alert

## Workaround

To work around this issue, use one of the following methods:

- Create multiple identical rules, and add 19 or fewer people per rule
- Create a [Distribution Group](/exchange/recipients-in-exchange-online/manage-distribution-groups/manage-distribution-groups) that includes the people who you want to include in the client-only rule. Then, add that distribution group to the rule
