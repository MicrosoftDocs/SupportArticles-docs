---
title: Accept button is missing on a calendar from a sharing invitation
description: Describes a scenario in which the Accept button is missing when a user tries to open a calendar from a sharing invitation in Outlook on the web.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: alinastr, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't open a calendar from a sharing invitation in Outlook on the web

_Original KB number:_ &nbsp; 3187214

## Problem

A user can't open a calendar from a sharing invitation in Outlook on the web because the **Accept** button is missing. Additionally, an .eml file is attached to the sharing invitation.

## Cause

This issue occurs if a disclaimer transport rule is applied to calendaring messages, and **Wrap** is specified as the fallback action.

:::image type="content" source="media/cannot-open-calendar-from-sharing-invitation/disclaimer.png" alt-text="Screenshot of the disclaimer transport rule showing the fallback action set to Wrap.":::

## Solution

To resolve this issue, use one of the following methods:

- Change the fallback action of the disclaimer transport rule from **Wrap** to **Ignore**.
- Change the disclaimer transport rule to skip calendaring sharing invitations. For example, add an exception that specifies the following conditions:

    Except if: **The subject or body** > **subject or body includes any of these words** > has invited you to view their Microsoft Exchange Calendar or Sharing invitation or Sharing request or I'd like to share my calendar with you or You're invited to share this calendar

   :::image type="content" source="media/cannot-open-calendar-from-sharing-invitation/exception.png" alt-text="Screenshot of the exception that's added to the disclaimer transport rule.":::

For more information about how to set up disclaimers, see [Organization-wide disclaimers, signatures, footers, or headers in Exchange Server](/Exchange/policy-and-compliance/mail-flow-rules/signatures).

## More information

For more information about transport rules in Exchange Online, see [Mail flow rules (transport rules) in Exchange Online](/exchange/security-and-compliance/mail-flow-rules/mail-flow-rules).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
