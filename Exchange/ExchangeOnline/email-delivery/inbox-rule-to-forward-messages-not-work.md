---
title: Inbox rule to forward emails doesn't work
description: Provides a workaround to an issue in which a forward rule doesn't work for a Microsoft 365 account.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: v-six, nocapo
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
---
# Inbox rule to forward messages doesn't work in Microsoft 365

_Original KB number:_ &nbsp; 4021948

## Symptoms

Your Inbox rule that has an action forward messages doesn't work in Microsoft 365.

## Cause

This behavior is by design when the rule is forwarding messages to 10 or more individual recipients. This is a result of the forwarded limit in Microsoft 365, which is described at [Exchange Online Limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits).

## Workaround

To work around this behavior, create a distribution group or a Microsoft 365 group, and then add the individual recipients to the group. For details, see [Create a group in the Microsoft 365 admin center](/microsoft-365/admin/create-groups/create-groups).
