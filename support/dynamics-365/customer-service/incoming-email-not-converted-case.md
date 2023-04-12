---
title: Incoming email isn't converted to a case
description: Provides a solution to an issue where incoming email isn't converted to a case in Dynamics 365 Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Incoming email isn't converted to a case

This article provides a solution to an issue where incoming email isn't converted to a case.

## Symptom

Email-to-case conversion isn't functioning.

## Cause

Email-to-case conversion may not work for any of the following reasons:
- Email sync with the system
- QueueItem isn't found
- Email is coming from an unknown sender
- Automatic Rule Creation and Update Rule configuration issues
- Contact and account have different email address
- Email sent using only the "Bcc" field

## Resolution

Follow any of the below steps to diagnose and resolve the issue.

1. Check whether the email is syncing with the system: Navigate to **Activities** and look for the Email activity. If email isn't syncing with the system, there may be an issue with the email router or server-side sync configuration.
1. Check whether the email activity is created but a related QueueItem isn't found. If an active **Automatic Record Creation and Update Rule** exists for a specific queue, QueueItem is marked as inactive, and disappears from the QueueItem View.
1. If the email is coming from an unknown sender, check for the **Create contact for unknown sender** option. Go to the **Automatic Record Creation and Update Rule** configuration and check whether the **Create contact for unknown sender** box is checked. If the **Create contact for unknown sender** check box isn't checked, incoming email from an unknown sender won't be converted to a case.
1. Check whether **Automatic Record Creation and Update Rule** is configured properly by going to system jobs and checking for a failure message. For more information about configuration failure scenarios and resolution for sample configuration failure, see [Configuration failure scenarios and resolutions](#troubleshoot-error-messages).

   > [!NOTE]
   > The Customer field in the case entity can be a contact or an account. If a matching incoming email address isn't found for a contact or an account, and **Create contact for unknown sender** box is checked, the system creates contact for incoming email address and links it to the case's customer field.

1. Check whether the contact and account exist with the same incoming email address. A case that's created from incoming email will resolve customer field on the case as Account.

1. Ensure that the queue email address is in the **To** or **Cc** fields of incoming mails. Emails sent with the queue address in the **Bcc** field won't be processed.
