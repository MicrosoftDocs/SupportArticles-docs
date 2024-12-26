---
title: Error occurred while synchronizing or receiving an email
description: Fixes the 80040216, ServiceUnavailable, IncomingMailboxInternalCrmError, or ErrorInternalServerTransientError error during server-side synchronization in Dynamics 365.
ms.reviewer: 
ms.date: 12/26/2024
ms.custom: sap:Email and Exchange Synchronization
---
# An error occurs when receiving or synchronizing an email in a Microsoft Dynamics 365 mailbox

This article helps you resolve error messages logged in a Microsoft Dynamics 365 mailbox record during server-side synchronization.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4477141, 4471977, 4471949, 4471948

## Symptoms

One of the following alerts is logged in the [Alerts](/power-platform/admin/monitor-email-processing-errors#view-alerts) section of a Dynamics 365 mailbox record:

- > An error occurred while synchronizing the item \<Item Name\> from Microsoft Dynamics 365 for the mailbox \<Mailbox Name\>.
  >
  > **Email Server Error Code**: Crm.80040216. An unexpected error occurred.

- > An error occurred in receiving email for the mailbox \<Mailbox Name\> while connecting to the email server. The owner of the associated email server profile \<Profile Name\> has been notified. The system will try to receive email again later.
  >
  > **Email Server Error Code**: Http server returned ServiceUnavailable exception

- > An internal Microsoft Dynamics 365 error occurred while receiving email through the mailbox \<Mailbox Name\>. The owner of the associated email server profile \<Profile Name\> has been notified. The system will try to receive email again later.
  >
  > **Email Server Error Code**: IncomingMailboxInternalCrmError

- > An unexpected error occurred while receiving email. Mailbox \<Mailbox Name\> didn't synchronize. The owner of the associated email server profile \<Profile Name\> has been notified.
  >
  > **Email Server Error Code**: ErrorInternalServerTransientError

## Cause

The error messages might occur when [server-side synchronization](/power-platform/admin/server-side-synchronization) tries to synchronize an item with Microsoft Exchange but encounters issues such as internal errors or a 503 (Service Unavailable) error. Typically, these are temporary problems, and synchronization usually succeeds in the next cycle (approximately every 15 minutes).

## Resolution

- If the issue doesn't persist during the next synchronization cycle (typically in 15 minutes), you can ignore it.
- If the issue persists and the mentioned item isn't being synchronized by server-side synchronization, you can contact Microsoft Support through the **Help + Support** experience in the [Power Platform admin center](https://admin.powerplatform.microsoft.com/support). 
- Additionally, there might be an issue with your email server, so you can first verify that you can send and receive emails successfully with your email service.
