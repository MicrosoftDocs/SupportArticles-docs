---
title: Inbox rule to forward emails doesn't work
description: Provides a workaround to an issue in which a forward rule doesn't work for an Office 365 account.
author: AmandaAZ
ms.author: v-weizhu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-online
localization_priority: Normal
ms.reviewer: v-six, nocapo
ms.custom:
- CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Exchange Online
---
# Inbox rule to forward messages doesn't work in Office 365

This article provides a workaround for an issue where the Inbox rule to forward messages doesn't work for a Microsoft Office 365 account.

_Original KB number:_ &nbsp; 4021948

## Symptoms

Your Inbox rule that has an action forward messages doesn't work in Office 365.

## Cause

This behavior is by design when the rule is forwarding messages to 10 or more individual recipients. This is a result of the forwardee limit in Office 365, which is described at [Exchange Online Limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits).

## Workaround

To work around this behavior, create a distribution group or an Office 365 group, and then add the individual recipients to the group. For details, see [Create an Office 365 group in the admin center](/microsoft-365/admin/create-groups/create-groups?redirectSourcePath=%252farticle%252fCreate-an-Office-365-group-in-the-admin-center-74a1ef8b-3844-4d08-9980-9f8f7a36000f).
