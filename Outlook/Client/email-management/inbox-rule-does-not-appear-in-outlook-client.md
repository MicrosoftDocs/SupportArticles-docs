---
title: Inbox rule in Outlook on the web doesn't appear in Outlook for Windows
description: Provides a workaround for a behavior in which an Inbox rule in Outlook on the web doesn't appear in the classic Outlook for Windows.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 176317
ms.reviewer: gbratton, meerak, v-trisshores
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.date: 10/30/2023
---

# Inbox rule in Outlook on the web doesn't appear in Outlook for Windows

## Symptoms

You create or modify an Inbox rule in Outlook on the web or the new Outlook for Windows. You expect to see and manage the rule in the classic Outlook for Windows, but the rule doesn't appear in the **Rules and Alerts** dialog box. Instead, you see the following warning message in the dialog box:

> There are rules created with a different version of Outlook or Outlook Web Access that are not shown.

## Cause

This behavior is by design. The behavior occurs if you use Outlook on the web or the new Outlook for Windows to create or modify a rule, and the new or updated rule has one of the following conditions or actions:

**Conditions**

- Recipient address includes one or more specific words
- Message is a new or updated meeting request
- Message has a classification

**Actions**

- Assign the message a category
- Mark the message as Read
- Assign the message an importance level

> [!NOTE]
> Even though the rule doesn't appear in the **Rules and Alerts** dialog box of the classic Outlook for Windows, the rule still runs on incoming email.

## Workaround

Use Outlook on the web or the new Outlook for Windows to view, edit, run, or delete your rule.

You can safely ignore the warning message in the classic Outlook for Windows.
