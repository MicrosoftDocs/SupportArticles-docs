---
title: Incoming email isn't converted to a case
description: Provides a resolution for the issue where an incoming email isn't converted to a case in Dynamics 365 Customer Service.
ms.reviewer: sdas, ghoshsoham
ms.author: shchaur
ms.date: 04/18/2025
ms.custom: sap:E-Mail\Case isn't getting created with record creation rule
---
# Incoming email isn't converted to a case

This article provides a resolution for the issue where an incoming email isn't converted to a case in Dynamics 365 Customer Service. Also, to diagnose and fix the issues, you can use the **Activity monitor** available on the **Record creation and update rules** page, and configure the options to view skipped scenarios, failed scenarios, or all scenarios for a time period. For more information, see [Manage activity monitor to review and track rules](/dynamics365/customer-service/automatically-create-update-records?tabs=customerserviceadmincenter#manage-activity-monitor-to-review-and-track-rules).

## Symptom 1

Email-to-case conversion isn't working in Dynamics 365 Customer Service.

### Cause 1: The email isn't syncing with the system

#### Resolution

To check whether the email is syncing with the system, navigate to **Activities** and look for the email activity. If email isn't syncing with the system, there may be an issue with the email router or server-side sync configuration.

### Cause 2: Email activity is created but related QueueItem isn't found

#### Resolution

You need to check whether the email activity is created but a related QueueItem isn't found. If an active **Automatic Record Creation and Update Rule** exists for a specific queue, the QueueItem is marked as inactive and disappears from the QueueItem view.

### Cause 3: The email is coming from an unknown sender

#### Resolution

If the email is coming from an unknown sender, check for the **Create contact for unknown sender** option. Go to the **Automatic Record Creation and Update Rule** configuration and check whether the **Create contact for unknown sender** box is selected. If the **Create contact for unknown sender** check box isn't selected, an incoming email from an unknown sender won't be converted to a case.

### Cause 4: Automatic Record Creation and Update Rule configuration issues

#### Resolution

You need to check whether the **Automatic Record Creation and Update Rule** feature is configured properly by going to system jobs and checking for a failure message. For more information about configuration failure scenarios and resolution for sample configuration failure, see [Troubleshoot common email error messages](common-email-error-messages.md).

> [!NOTE]
> The **Customer** field in the case entity can be a contact or an account. If a matching incoming email address isn't found for a contact or an account, and the **Create contact for unknown sender** check box is selected, the system creates a contact for the incoming email address and links it to the case's **Customer** field.

### Cause 5: The contact and account have different email addresses

#### Resolution

You need to check whether the contact and account have the same incoming email address. A case that's created from an incoming email will resolve the **Customer** field on the case as **Account**.

### Cause 6: The email is sent using only the Bcc field

#### Resolution

To fix this issue, ensure the queue email address is in the **To** or **Cc** fields of incoming emails. Emails sent with the queue address in the **Bcc** field won't be processed.

### Cause 7: The email is a reply to the tracked email

#### Resolution

If the incoming email is in response to an already tracked email associated with a case, no new case will be created. If the **InReplyTo** value matches the **MessageId** of an email that's already in Dynamics 365, server-side synchronization correlates the new email with the existing one, and the "Automatic record creation and Update" rule skips case creation for the new email. For more information, see [Specify which emails are automatically tracked](/power-platform/admin/email-message-filtering-correlation).

### Cause 8: Contact creation failed when the incoming email is from an unknown sender

#### Resolution

By default, a contact for an unknown email sender is created with the email owner context. A case might not get created if the email owner doesn't have the required permissions. Alternatively, you may choose to use the rule owner permissions to create the new contact by configuring the `msdyn_ArcCreateContactWithRuleOwner` environment variable. For more information, see [Create contacts for unknown senders using rule owner context](/dynamics365/customer-service/automatically-create-update-records?tabs=customerserviceadmincenter#create-contacts-for-unknown-senders-using-rule-owner-context).

### Cause 9: No active "Automatic record creation and Update" rule exists for the queue to which the email was sent

#### Resolution

Navigate to the "Automatic record creation and Update" rules and ensure that an active "Automatic record creation and Update" rule exists for the queue to which the email was sent. If no "Automatic record creation and Update" rule exists for the queue to which the email was sent, a case won't be created since there won't be any matching rule and condition.

## Symptom 2

When you use Automatic Record Creation (ARC) rules in Dynamics 365 Customer Service, you might receive one of the following error messages at runtime:

- > Error matching conditions. Contact Microsoft Support

- > Unknown error matching rules. Contact Microsoft Support

As a result, the ARC rule fails to create cases from emails.

### Cause

This issue occurs when the account under which the ARC rules are running is deleted or disabled. This causes the associated Power Automate flow to become disconnected.

### Resolution

To resolve this issue, follow these steps:

1. Go to **Customer Service admin center** > **Case Settings** > **Automatic Record Creation and Update Rules**.
2. Verify the account under which the ARC rules are running. Ensure that the account is active and isn't deleted or disabled.
3. Disable the affected ARC rule.
4. Re-enable the ARC rule to re-establish the connection with the associated Power Automate flow.

### More information

[Set up rules to automatically create or update records](/dynamics365/customer-service/administer/automatically-create-update-records)
