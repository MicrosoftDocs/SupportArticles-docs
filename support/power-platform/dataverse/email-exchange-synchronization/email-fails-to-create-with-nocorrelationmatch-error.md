---
title: Email fails to create with a NoCorrelationMatch sync error
description: An email fails to be created with a NoCorrelationMatch sync error in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 04/17/2025
ms.custom: sap:Email and Exchange Synchronization
---
# An email fails to be created with a NoCorrelationMatch sync error in Microsoft Dynamics 365

This article provides a resolution for the issue where an email message fails to be created in Microsoft Dynamics 365 due to a **NoCorrelationMatch** sync error.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4339713

## Symptoms

When reviewing email messages analyzed for automatic promotion by Dynamics 365, you notice an email message that fails to be created with a **NoCorrelationMatch** sync error.

## Cause

When evaluating an email in your mailbox, Dynamics 365 checks multiple conditions to determine if the message should automatically be created as an [email activity](/power-apps/developer/data-platform/email-activity-entities). These conditions include the characteristics of the email, such as the email addresses in the **From**, **To**, and **Cc** fields, and whether the email is a reply to an email initially sent from Dynamics 365. Your personal options for email tracking also affect which emails are tracked automatically. A **NoCorrelationMatch** error indicates that no users or queues are configured to promote this email automatically.

For example, if user Christopher Reed receives an email from one of his contacts and his personal options are set with the default configuration to only track **Email messages in response to Microsoft Dynamics 365 email**, only replies to emails sent from Dynamics 365 are tracked automatically.

## Resolution

To resolve this issue, review the characteristics of the email and check your personal options for email tracking. Follow these steps:

1. Access your personal options in Dynamics 365 by selecting settings (the gear icon in the upper-right corner) and then selecting **Options**.
2. Select the **Email** tab.
3. Under the **Select the email messages to track in Microsoft Dynamics 365** section, locate the **Track** setting.
4. Adjust the option as necessary to control which emails should be tracked automatically in Dynamics 365.

For example,

- To automatically track all emails sent from your leads, contacts, or accounts, select **Email messages from Microsoft Dynamics 365 Leads, Contacts and Accounts**.
- To automatically create activities for received emails regardless of the sender, select **All email messages**.

> [!NOTE]
> A **NoCorrelationMatch** error can also occur if you have disabled the **Use correlation to track email conversations** option. You can view this setting on the **Email** tab within **System Settings**.

## More information

- For more information about email correlation, see [Email message filtering and correlation](/previous-versions/dynamicscrm-2016/administering-dynamics-365/hh699705(v=crm.8)).
- For more information about automatically creating email activities for received messages, see [Specify which emails are automatically tracked](/power-platform/admin/email-message-filtering-correlation).
