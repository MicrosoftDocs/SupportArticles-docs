---
title: Email fails to create with NoCorrelationMatch sync error
description: An email fails to be created in Microsoft Dynamics 365 with a NoCorrelationMatch sync error.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# An email fails to be created in Microsoft Dynamics 365 with a NoCorrelationMatch sync error

This article provides a resolution for the issue that an email message fails to be created in Microsoft Dynamics 365 with a **NoCorrelationMatch** sync error.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4339713

## Symptoms

When reviewing email messages that were analyzed for automatic promotion by Microsoft Dynamics 365, you see an email message that failed to be created in Microsoft Dynamics 365 with a **NoCorrelationMatch** sync error.

## Cause

When Microsoft Dynamics 365 evaluates an email in your mailbox, multiple conditions are evaluated to determine if the message should automatically be created as an email activity in Microsoft Dynamics 365. Some of the conditions that are evaluated are based on the characteristics of the email such as the email addresses on the From, To, and Cc and if the email is a reply to an email initially sent from Microsoft Dynamics 365. Your personal option for email tracking also affects which emails are tracked automatically. If the evaluation results in a **NoCorrelationMatch** error, this indicates that no users or queues were configured to promote this email automatically.

For example: An email is received by user Christoper Reed from one of Christoper's contacts. If Christoper's personal options in Microsoft Dynamics 365 are configured with the default setting to only track **Email messages in response to Microsoft Dynamics 365 email**, the email would only be tracked automatically if the email was a reply to an email that was sent from Microsoft Dynamics 365.

## Resolution

Review the characteristics of the email and which option you have configured in your personal options for email tracking. To view or change your email tracking setting:

1. Access your personal options in Microsoft Dynamics 365 by selecting settings (the gear icon in upper-right corner) and then selecting **Options**.
2. Select the **Email** tab.
3. Under the **Select the email messages to track in Microsoft Dynamics 365 section,** locate the **Track** setting.
4. Adjust the option as necessary to control which emails should be tracked in Microsoft Dynamics 365 automatically.

For example: If you want to automatically track all emails sent from your leads, contacts, or accounts, select the option **Email messages from Microsoft Dynamics 365 Leads, Contacts and Accounts**. If you want every email you receive, regardless of the sender, to automatically be created as an email activity in Microsoft Dynamics 365, select the option **All email messages**.

> [!NOTE]
> A **NoCorrelationMatch** result can also be caused by having the option **Use correlation to track email conversations** disabled. You can view this setting on the **Email** tab within **System Settings**.

For more information about email correlation, see [Email message filtering and correlation](/previous-versions/dynamicscrm-2016/administering-dynamics-365/hh699705(v=crm.8)).
