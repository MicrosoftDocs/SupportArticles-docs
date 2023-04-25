---
title: Incoming email isn't converted to a case
description: Provides a resolution for the issue where an incoming email isn't converted to a case in Dynamics 365 Customer Service.
ms.reviewer: laalexan
ms.date: 04/11/2023
---
# Incoming email isn't converted to a case

This article provides a resolution for the issue where an incoming email isn't converted to a case in Dynamics 365 Customer Service.

## Symptoms

Email-to-case conversion isn't working in Dynamics 365 Customer Service.

## Cause

Email-to-case conversion may not work for any of the following reasons:

- The email is syncing with the system.
- A QueueItem isn't found.
- The email is coming from an unknown sender.
- **Automatic Rule Creation and Update Rule** configuration issues.
- The contact and account have different email addresses.
- The email is sent using only the **Bcc** field.

## Resolution

To fix this issue, follow any of the below steps to diagnose and resolve the issue.

1. Check whether the email is syncing with the system: Navigate to **Activities** and look for the email activity. If email isn't syncing with the system, there may be an issue with the email router or server-side sync configuration.
1. Check whether the email activity is created but a related QueueItem isn't found. If an active **Automatic Record Creation and Update Rule** exists for a specific queue, the QueueItem is marked as inactive and disappears from the QueueItem view.
1. If the email is coming from an unknown sender, check for the **Create contact for unknown sender** option. Go to the **Automatic Record Creation and Update Rule** configuration and check whether the **Create contact for unknown sender** box is selected. If the **Create contact for unknown sender** check box isn't selected, an incoming email from an unknown sender won't be converted to a case.
1. Check whether the **Automatic Record Creation and Update Rule** feature is configured properly by going to system jobs and checking for a failure message. For more information about configuration failure scenarios and resolution for sample configuration failure, see [Troubleshoot common email error messages](common-email-error-messages.md).

   > [!NOTE]
   > The **Customer** field in the case entity can be a contact or an account. If a matching incoming email address isn't found for a contact or an account, and the **Create contact for unknown sender** check box is selected, the system creates a contact for the incoming email address and links it to the case's **Customer** field.

1. Check whether the contact and account have the same incoming email address. A case that's created from an incoming email will resolve the **Customer** field on the case as **Account**.
1. Ensure the queue email address is in the **To** or **Cc** fields of incoming emails. Emails sent with the queue address in the **Bcc** field won't be processed.
