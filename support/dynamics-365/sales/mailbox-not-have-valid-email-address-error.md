---
title: Mailbox doesn't have a valid email address
description: Fixes an issue in which you get the "Mailbox doesn't have a valid email address" error when using the Server-Side Synchronization in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# "Mailbox doesn't have a valid email address" error occurs when using Server-Side Synchronization

This article helps you fix an issue in which you get the "Mailbox doesn't have a valid email address" error when using the Server-Side Synchronization in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2016  
_Original KB number:_ &nbsp; 3214684

## Symptoms

When you test and enable a mailbox in Dynamics 365, you encounter one of the following errors in the Alerts area:

> Appointments, contacts, and tasks can't be synchronized because the mailbox \<Mailbox Name> doesn't have a valid email address. Specify a valid email address in the mailbox record, and then enable the mailbox for appointments, contacts, and tasks synchronization.
>
> **Email Server Error Code**: Exchange.server returned ErrorNonExistentMailbox error.

> A general mailbox access error occurred while sending the email message "Your mailbox is now connected to Dynamics 365". Mailbox [Mailbox Name] didn't synchronize. The owner of the associated email server profile Microsoft Exchange Online has been notified.
>
> **Email Server Error Code**: Exchange server returned ErrorInvalidOperation exception.

> Email can't be received for the mailbox [Mailbox Name] because the mailbox record doesn't have a valid email address. The mailbox didn't synchronize. A notification about this is posted on the alerts wall for the owner of the email server profile Microsoft Exchange Online.
>
> **Email Server Error Code**: Exchange.server returned ErrorNonExistentMailbox error.

## Cause

This error can occur for one of the following reasons:

- The mailbox for the user could not be found because the email address is not correct.
- The email address is for a distribution group, which is not a mailbox.
- The mailbox is configured to use an Exchange Online profile but the user's mailbox is located in Exchange on-premises

## Resolution

To fix this issue, use the following steps:

1. Verify the e-mail address of the mailbox record in Dynamics 365 matches the e-mail address in Exchange. The error includes a link to the mailbox record in Dynamics 365. You can use this link to quickly verify the Email Address field.
2. Verify the email address is for an actual mailbox and not a distribution group. Distribution groups are not mailboxes that store email. Distribution groups are used to distribute emails to the mailboxes that are members of the group.
3. If the user's mailbox is located in Exchange on-premises, make sure you are using an [Exchange Server (Hybrid) profile](/power-platform/admin/connect-exchange-server-on-premises#create-an-email-server-profile) in Dynamics 365 instead of an Exchange Online profile.

## More information

When you click **View Details**, you see error details like the following:

> \>Error : \<ResponseMessageType xmlns:q1="`https://schemas.microsoft.com/exchange/services/2006/messages`" p2:type="q1:FindItemResponseMessageType" ResponseClass="Error" xmlns:p2="`https://www.w3.org/2001/XMLSchema-instance`">\<q1:MessageText> **Mailbox does not exist.** \</q1:MessageText>\<q1:ResponseCode> **ErrorNonExistentMailbox** \</q1:ResponseCode>\<q1:DescriptiveLinkKey>0\</q1:DescriptiveLinkKey>\</ResponseMessageType>

> \>Error : \<ResponseMessageType xmlns:q1="`https://schemas.microsoft.com/exchange/services/2006/messages`" p2:type="q1:ItemInfoResponseMessageType" ResponseClass="Error" xmlns:p2="`https://www.w3.org/2001/XMLSchema-instance`">\<q1:MessageText> **SendOnly cannot be used by a user without a mailbox.  Use SendAndSaveCopy and specify a folder ID in a mailbox to send an item from an account that doesn't have a mailbox.** \</q1:MessageText>\<q1:ResponseCode> **ErrorInvalidOperation** \</q1:ResponseCode>\<q1:DescriptiveLinkKey>0\</q1:DescriptiveLinkKey>\<q1:Items />\</ResponseMessageType>
