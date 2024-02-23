---
title: Meeting status shows as failed
description: Describes a behavior in which specific users can't receive meeting requests in Outlook because of Delegate Access is enabled.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: scottlan
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 10/30/2023
---
# Specific users can't receive meeting requests in Outlook because of Delegate Access is enabled

_Original KB number:_ &nbsp; 4022896

## Symptoms

Some specific users in your organization cannot receive meeting invitations in a Microsoft Outlook client. After you run [message tracking](/Exchange/mail-flow/transport-logs/message-tracking) for the specific recipient on Microsoft Exchange Server, the status for this meeting is shown as **Failed** for this specific user in the message trace result. For example, the results resemble the following screenshot:

:::image type="content" source="./media/specific-users-not-receive-meeting-requests/meeting-status.png" alt-text="Screenshot of the failed meeting status.":::

Additionally, you notice the following error message in the message trace result:

> [Stage DeliverPreDelivery]:StoreDriverRules; Message is deleted by mailboxrules

This display resembles the following screenshot:

:::image type="content" source="./media/specific-users-not-receive-meeting-requests/error-message.png" alt-text="Screenshot of the error message in the message events box.":::

## Status

This is the expected behavior if the user did the following actions:

- Turned on [Delegate Access](https://support.office.com/article/Allow-someone-else-to-manage-your-mail-and-calendar-9684b670-7588-4eea-8717-9e5799047540) in the Outlook client
- Set the delivery option to **My delegates only**, as shown in the following screenshot:

  :::image type="content" source="./media/specific-users-not-receive-meeting-requests/delivery-option.png" alt-text="Screenshot of the delivery option in Delegate Access.":::
