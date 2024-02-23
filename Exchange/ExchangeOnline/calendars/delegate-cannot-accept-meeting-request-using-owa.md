---
title: Delegate can't accept meeting request in OWA
description: Fixes an issue in which a delegate can't accept meeting requests in OWA when the manager is in another forest during coexistence.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kellybos, mhaque, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Delegate can't accept meeting request in OWA when manager is in another forest during coexistence

_Original KB number:_ &nbsp; 4089867

## Symptoms

As a delegate, you can't open a meeting request in Outlook Web Access (OWA) that was forwarded by your manager who is in a different forest. You can't accept or decline the meeting request, and you receive the following message in the preview pane:

> Your request can't be completed right now. Please try again later.

:::image type="content" source="media/delegate-cannot-accept-meeting-request-using-owa/meeting-request-error.png" alt-text="Screenshot of the meeting request error.":::

## Cause

This issue occurs because delegates and managers may not be moved to the cloud at the same time. OWA doesn't support the ability to accept and decline meeting requests.

## Resolution

To resolve this issue, use the Outlook for Windows client to accept or decline the meeting request.
