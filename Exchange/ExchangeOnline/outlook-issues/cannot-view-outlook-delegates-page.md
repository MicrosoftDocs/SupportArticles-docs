---
title: Cannot view Outlook Delegates page
description: Fixes an issue in which users can't view delegate permissions in Outlook in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Client Connectivity
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kellybos, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Users can't view the Outlook Delegates page in Microsoft 365

_Original KB number:_ &nbsp; 4038583

## Symptoms

Users can't view delegate permissions in Microsoft Outlook in Microsoft 365. Additionally, they receive the following error message:

> The Delegates page is not available. Cannot access the Outlook folder.

## Cause

Outlook can't correctly retrieve the delegate information from the local free/busy object in the mailbox. This issue may occur after the manager's or delegate's mailbox is moved to a new forest.

## Resolution

To resolve this issue, set a new temporary delegate in the manager's mailbox by using Outlook Web App (OWA) to force updating of the local free/busy object. To do this, follow these steps:

1. Sign in to the mailbox through OWA.
2. Open the calendar.
3. Select **Share** from the menu at the top.

   :::image type="content" source="media/cannot-view-outlook-delegates-page/share-button-on-outlook-page.png" alt-text="Screenshot of the Share button on the Outlook page.":::

4. Enter a user or group, and then select **Delegate**  from the drop-down menu.

   :::image type="content" source="media/cannot-view-outlook-delegates-page/selecting-delegate.png" alt-text="Screenshot of the selecting Delegate in the drop-down menu page.":::

5. Select **Share**, and then select **Done**.

   :::image type="content" source="media/cannot-view-outlook-delegates-page/share-page.png" alt-text="Screenshot of Share page.":::

The manager should now be able to return to Outlook to continue management of the delegates from the client.
