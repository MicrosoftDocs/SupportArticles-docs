---
title: Dynamics 365 App for Outlook experience without Server-Side Synchronization
description: Describes Dynamics 365 App for Outlook experience without Server-Side Synchronization.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-client-outlook
---
# Microsoft Dynamics 365 App for Outlook experience without Server-Side Synchronization

This article describes an issue in which you receive a notification saying that Track and Set Regarding are currently disabled if Server-Side Synchronization is inactive in Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4508591

When you use Dynamics 365 App for Outlook, you might see a notification that says:

> Track and Set Regarding are currently disabled. To use these features, please contact your admin. You can still view and interact with your Dynamics 365 data.

:::image type="content" source="media/experience-without-server-side-synchronization/notification.png" alt-text="Screenshot of the notification without Server-Side Synchronization." lightbox="media/experience-without-server-side-synchronization/notification.png":::

Dynamics 365 App for Outlook leverages Server-Side Synchronization to keep your Exchange items in sync with Dynamics 365. For example, if you track a meeting in Outlook, App for Outlook relies on Server-Side Synchronization to create the activity in Dynamics 365 and keep the two items in sync.

If we recognize that Server-Side Synchronization is inactive on your mailbox, we will not be able to provide the ability for you to track and set regarding on emails and appointments.

With this updated, instead of blocking you from using App for Outlook, we are providing the ability for you to view your Dynamics 365 information like accounts, contacts, and activities. You can continue to create, update, and manage your information since they are not related to synchronization.

To fix issues with Server-Side Synchronization, contact your administrator, who can view the status of the service and take necessary steps to address the issue.

## Additional possible cause

One other potential cause of this message is if the email address in Dynamics 365 does not match the Primary SMTP address in Microsoft Exchange. For example: If a user's mailbox in Dynamics 365 has the email address value of John@contoso.com but the primary SMTP address in Exchange is John@contoso.com, that would also cause this symptom. Update the email address in Dynamics 365 to match the primary STMP email address in Exchange. When viewing the properties of a mailbox in Exchange, the primary SMTP email address is the one that appears in bold.

## Additional information

See [Test configuration of mailboxes for Server-Side Synchronization](/power-platform/admin/connect-exchange-online#test-configuration-of-mailboxes) for more information.
