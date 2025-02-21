---
title: Error when creating an incoming email
description: Solves an InvalidSender or InvalidForwardMailItem error that occurs when creating an incoming email in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 12/31/2024
ms.custom: sap:Email and Exchange Synchronization
---
# "An error occurred while creating the incoming email" occurs in Microsoft Dynamics 365

This article provides a solution to an error that occurs when creating an incoming email in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4053783

## Symptoms

The following error is logged in [the Alerts area](/power-platform/admin/monitor-email-processing-errors#view-alerts) in a Dynamics 365 mailbox record:

> An error occurred while creating the incoming email \<Email Subject> in Microsoft Dynamics 365 for the mailbox \<Mailbox Name>.

If you select **View Details** in the alert, you see one of the following error codes:

> Email Server Error Code: InvalidSender

> Email Server Error Code: InvalidForwardMailItem

## Cause of the InvalidSender error code

The **InvalidSender** error code indicates that server-side synchronization fails to track an email due to a missing valid email address in the **From** field.

To solve this issue:

1. Locate the corresponding email in the mailbox.
2. Verify that there's a valid email address in the **From** field.

## Cause of the InvalidForwardMailItem error code

The **InvalidForwardMailItem** error code indicates that a Forward Mailbox receives the email. However, the Dynamics 365 mailbox forwarding the email to the Forward Mailbox doesn't correctly forward the email as an attachment, or that mailbox doesn't have the **Incoming Email** option set to **Forward Mailbox**.

To solve this issue:

1. Open the Dynamics 365 mailbox record that forwards the email to the Forward Mailbox.

2. In the **Synchronization Method** section, ensure that **Incoming Email** is set to **Forward Mailbox**. If another option like **Server-Side Synchronization** or **Email Router** is selected, it might explain why this error occurs.

3. If the mailbox is configured with the **Forward Mailbox** option for **Incoming Email**, verify that the mailbox is correctly configured to forward emails to the Forward Mailbox and as an attachment.

## More information

Some applications send automated emails without a valid email address in the **From** field. For example, the Clutter feature in Outlook sends messages causing the following alert:

> An error occurred while creating the incoming email "Clutter moved new and different messages" in Microsoft Dynamics 365 for the mailbox.

These alerts are informational and can be safely ignored. To prevent logging such alerts, you can change alert types in system settings.

1. Sign in to the Dynamics 365 web application as a user with the System Administrator role
1. Navigate to **Settings** > **Email Configuration**, and then select **Email Configuration Settings**.
1. Scroll down to the **Configure alerts** section and disable the **Information** checkbox.
1. Select **OK**.
