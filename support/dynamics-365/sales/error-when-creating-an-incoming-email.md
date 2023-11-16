---
title: Error when creating an incoming email
description: Provides a solution to an error that occurs when you create the incoming email in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# An error occurred while creating the incoming email in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you create the incoming email in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4053783

## Symptoms

The following alert is logged within a mailbox record in Microsoft Dynamics 365:

> "An error occurred while creating the incoming email \<Email Subject> in Microsoft Dynamics 365 for the mailbox \<Mailbox Name>."

If you select **View Details** within the alert, you see the following additional information:

> "Email Server Error Code: InvalidSender"

or:

> "Email Server Error Code: InvalidForwardMailItem"

## Cause

**Cause 1:**  
If the alert includes the text **InvalidSender**, this message is logged if Server-Side Synchronization couldn't track an email because there wasn't a valid email address in the From field of the message.

**Cause 2:**  
If the alert includes the text **InvalidForwardMailItem**, this message is logged if a Forward Mailbox received the email but the Dynamics 365 mailbox that forwarded the email to the Forward Mailbox either didn't correctly forward the email as an attachment, or that mailbox doesn't have the **Incoming Email** option set to the **Forward Mailbox** option.

## Resolution

**Solution 1 (InvalidSender):**

1. Locate the corresponding email in the mailbox.
2. Verify there's a valid email address in the From field.

**Solution 2 (InvalidForwardMailItem):**

1. Open the Dynamics 365 mailbox record that forwarded the email to the Forward Mailbox.
2. Verify the **Incoming Email** setting, located within the Synchronization Method section, has the **Forward Mailbox** option selected. If another option such as **Server-Side Synchronization** or **Email Router** is selected, it would explain why this error is logged.
3. If the mailbox was already configured to use the **Forward Mailbox** option for Incoming Email, verify the mailbox is correctly configured to not just forward emails to the Forward Mailbox but that it's configured to forward the emails as an attachment.

## More information

Some applications send automated emails that don't include a valid email address in the From field. For example, the Clutter feature in Outlook sends messages that result in the following informational alert:

> "An error occurred while creating the incoming email "Clutter moved new and different messages" in Microsoft Dynamics 365 for the mailbox"

This alert can safely be ignored and is an information level alert. If you want to avoid logging of information level alerts, you can change which types of alerts are enabled within System Settings.

1. As a user with the System Administrator role, navigate to **Settings**, select **Email Configuration**, and then select **Email Configuration Settings**.
2. Scroll down to the **Configure alerts** section and remove the selection from the **Information** checkbox.
3. Select **OK**.
