---
title: Incoming emails are unexpectedly synchronized or contain unexpected or missing data
description: Provides troubleshooting information for the incoming emails are unexpectedly synchronized or contain unexpected or missing data issue in Microsoft Dataverse.
ms.date: 11/11/2024
ms.custom: sap:Email and Exchange Synchronization\Synchronization of incoming email
author: rahulmital
ms.author: rahulmital
ms.reviewer: debrau
---
# Incoming emails are unexpectedly synchronized or contain unexpected or missing data

This article provides troubleshooting information for the incoming email synchronization issues when you use server-side synchronization in Microsoft Dataverse.

## Incoming emails are unexpectedly tracked or synchronized

### Symptoms

The following email is addressed to a single recipient in Microsoft Exchange, but it's resolved to both a user and queue that share the same email address in Dataverse.

:::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/email-resolved-to-user-and-queue.png" alt-text="Screenshot that shows an email example that is resolved to both a user and queue that share the same email address in Dataverse.":::

In this case, the email is automatically accepted by **Paul Cannon's Queue** because it accepts **All email messages**, even though Paul Cannon's personal user options are set to **No email messages**.

Paul Cannon's Queue:

:::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/all-email-messages-accepeted-by-queue.png" alt-text="Screenshot that shows the Convert Incoming Email To Activities is set to All email messages.":::

Paul Cannon's user settings:

:::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/personal-user-set-to-no-mail.png" alt-text="Screenshot that shows the personal user settings.":::

### Cause

Server-side synchronization automatically tracks emails based on the [incoming email filtering method configuration](/power-platform/admin/email-message-filtering-correlation) specified for each identified (resolved) Dataverse recipient. A Dataverse recipient is resolved by locating the applicable user and queue mailboxes associated with the email addresses found in the **To**, **Cc**, and **Bcc** fields on the received email from the external system (Exchange or Google Gmail). Therefore, if an email address is associated with more than one Dataverse mailbox with different incoming email filtering method settings, emails might unexpectedly synchronize into the system.

You can examine the **To**, **Cc**, and **Bcc** fields on the email in Dataverse to identify unexpected Dataverse recipients.

### Resolution

If an email is unexpectedly synchronized into the system, first identify the Dataverse mailbox that automatically accepted the email by examining the following properties of the synchronized email in Dataverse.

- **Accepting Entity**: The user or queue that receives the email and is configured to automatically track it. For example, if a queue named "Customer Service" that is configured to track all emails receives an email, the "Customer Service" queue is considered the Accepting Entity.
  > [!NOTE]
  > This column is empty for manually tracked emails. In this case, you can refer to the **Created by** column.
- **Receiving Mailbox**: The mailbox that's processed when server-side synchronization detects that an email contains a user or queue that's configured to automatically track it.
  > [!IMPORTANT]
  > The value of this column can be different from the **Accepting Entity**. For example, suppose Paul Cannon, who is set up to automatically track replies to existing emails, receives a message. The "Customer Service" queue, which is set up to track all emails, receives the same message. Server-side synchronization might process Paul's mailbox first and recognize that another recipient, "Customer Service", is configured to automatically track the email. In this case, the **Accepting Entity** is the "Customer Service" queue, but the **Receiving Mailbox** is Paul's.

> [!NOTE]
> These fields don't appear on the Email form by default. You can add them to the form or to an **Advanced Find** view to see their values. For more information on adding fields to the Advanced Find view, see [Create, edit, or save a view using legacy advanced find](/power-apps/user/advanced-find#create-edit-or-save-a-view-using-legacy-advanced-find).
>
> :::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/accepting-entity-receiving-mailbox.png" alt-text="Screenshot that shows the Accepting Entity and Receiving Mailbox properties.":::

Once the **Accepting Entity** is identified, you can change the incoming email filtering method of the user or queue to prevent future occurrences. To do so, see [Set personal options that affect tracking and synchronization between customer engagement apps and Outlook or Exchange](/power-platform/admin/set-personal-options-affect-tracking-synchronization-between-dynamics-365-outlook-exchange).

## Duplicate emails are tracked or synchronized

Server-side synchronization can be configured to allow users to automatically create sent and received copies of the same email if the email meets the user's [incoming email filtering method](/power-platform/admin/email-message-filtering-correlation).

To avoid duplicate emails to be tracked or synchronized:

1. In Dataverse, select the gear icon > **Advanced Settings**.
2. Navigate to **Settings** > **Email Configuration** > **Email Configuration Settings**.
3. Under the **Set tracking options for emails between Microsoft Dynamics 365 users** setting, clear the **Track emails sent between Dynamics 365 users as two activities** option.

   :::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/track-emails-sent.png" alt-text="Screenshot that shows the Set tracking options for emails between Microsoft Dynamics 365 users setting.":::

For more information about how the system detects if an email should be automatically promoted, see [Specify which emails are automatically tracked](/power-platform/admin/email-message-filtering-correlation).

### More scenarios

The **Track emails sent between Dynamics 365 users as two activities** setting is intended to apply to email messages sent between users. However, even if the setting is disabled, duplicate emails can still be created based on a recipient's incoming email filtering method if a queue is a sender or recipient of an email.

These scenarios are:

1. An email is sent from a Dataverse queue to a user.

   To resolve this scenario, enable the **IgnoreInternalEmailFromQueues** database setting.

2. An email is sent from a Dataverse user to a queue mailbox.

   To resolve this scenario, disable the **DoNotIgnoreInternalEmailToQueues** database setting.

For more information about how to set database settings, see [How to change default environment database settings](/power-platform/admin/environment-database-settings).

For more information about different database settings that affect server-side synchronization, see [default OrgDBOrgSettings for server-side synchronization](/power-platform/admin/orgdborgsettings).

## Old, past, or historic emails are unexpectedly tracked or synchronized

Server-side synchronization uses the [Process Email From](/power-platform/admin/best-practices-server-side-synchronization#configure-server-side-synchronization-for-customer-engagement-apps-and-exchange-online) ([ProcessEmailsReceivedAfter](/power-apps/developer/data-platform/reference/entities/emailserverprofile#BKMK_ProcessEmailsReceivedAfter)) date on each mailbox record to determine how far back the system should go to process emails. This value is maintained and updated by the system when new emails are processed in subsequent synchronization cycles after initial onboarding.

- If you have recently [tested and enabled a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) for the first time, the system will initially use the **Process Email From** (`ProcessEmailsReceivedAfter`) date on the associated email server profile record to establish the starting date for processing.

  :::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/process-email-from.png" alt-text="Screenshot that shows the Process Email From setting.":::

- If you have already tested and enabled a mailbox that uses an old date, you can customize the mailbox form and add the **Process Email From** attribute so that you can update it to use a newer value. The update takes effect on the next cycle.

  > [!NOTE]
  > The system always utilizes the greater value between the **Process Email From** date on the email server profile and the mailbox.

For more information about how the **Process Email From** date influences synchronization, see [Best practices for server-side synchronization](/power-platform/admin/best-practices-server-side-synchronization#considerations).

## Synchronized emails contain unexpected sender or recipient parties

Server-side synchronization performs email address resolution on all sender and recipient email addresses when synchronizing incoming emails into the system. This is done by retrieving all records in Dataverse which are associated with a given email address. When a match is found, the system associates one or more located records as an [activity party](/power-apps/developer/data-platform/activityparty-entity) on the email.

> [!NOTE]
> A column in Dataverse that has a format type of "[Email](/power-apps/developer/data-platform/data-type-format-conversions)" is involved in email address resolution.
>
> :::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/format-type-is-email.png" alt-text="Screenshot that shows the Email format type of a column.":::

As a result, if an email address is associated with more than one Dataverse record (such as an email address shared between a user and queue), all resolved recipients appear in their respective recipient fields.

For example, in the following screenshot, Paul Cannon's email address is associated with both the user's mailbox and a queue. Even though Paul Cannon's email address only appears once in the received email in Exchange, both of them appear as recipients.

:::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/email-address-associated-with-user-and-queue.png" alt-text="Screenshot that shows an email address that's associated with both the user's mailbox as well as a queue.":::

For more information, see:

- [When resolving recipient email addresses to rows in Dynamics 365, if there is more than one row in Dynamics 365 with the same email address, which row is it resolved to?](/dynamics365/outlook-app/user/faq-email-tracking#2-when-resolving-recipient-email-addresses-to-rows-in-dynamics-365-if-there-is-more-than-one-row-in-dynamics-365-with-the-same-email-address-which-row-is-it-resolved-to)
- [Multiple row types exist in Dynamics 365 with the same email addresses](/dynamics365/outlook-app/user/faq-email-tracking#5-multiple-row-types-exist-in-dynamics-365-with-the-same-email-addresses)

Likewise, if an email address isn't associated with a known Dataverse record, the email address appears unresolved.

#### Sender resolution order

Because an email can only have a single sender, when the sender's email address is associated with multiple Dataverse records, the system utilizes a priority order to determine the sender activity party. For more information, see [Associate an email address with a row](/power-platform/admin/associate-email-address).

## Synchronized emails have unexpected owners

When server-side synchronization synchronizes an email message to Dynamics 365, the system determines the email owner based on some factors. To understand why an email has an unexpected owner, see [How is an email record owner determined](/power-platform/admin/email-record-owner).
