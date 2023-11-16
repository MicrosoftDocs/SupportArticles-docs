---
title: InvalidOutgoingMailboxEmailAddress error in mailbox alert
description: InvalidOutgoingMailboxEmailAddress error appears in Microsoft Dynamics 365 mailbox alert.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# InvalidOutgoingMailboxEmailAddress error appears in Microsoft Dynamics 365 mailbox alert

This article provides a resolution for the **InvalidOutgoingMailboxEmailAddress** error that occurs in Microsoft Dynamics 365 mailbox alert.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4500801

## Symptoms

When you select **Test & Enable Mailbox** on a mailbox record in Microsoft Dynamics 365, the test results are not success. Additionally one of the following alerts appears within the Alerts section of the mailbox:

- Email can't be sent for the mailbox [Mailbox Name] because the mailbox record doesn't have a valid email address. The mailbox didn't synchronize. A notification about this is posted on the alerts wall for the owner of the email server profile Microsoft Exchange Online.

  **Email Server Error Code**: InvalidOutgoingMailboxEmailAddress

- Email can't be received for the mailbox [Mailbox Name] because the mailbox record doesn't have a valid email address. The mailbox didn't synchronize. A notification about this is posted on the alerts wall for the owner of the email server profile Microsoft Exchange Online.

  **Email Server Error Code**: InvalidIncomingMailboxEmailAddress

## Cause

This error occurs if there is not a valid email address in the **Email Address** field of the mailbox record.

## Resolution

To fix this issue, follow these steps:

1. Correct the value in the **Email Address** field and then select **Save**.
2. Select the **Test & Enable Mailbox** button again.
3. If the test results are not success, view the message and help link in the **Alerts** tab.
