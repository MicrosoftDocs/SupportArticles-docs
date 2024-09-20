---
title: Incoming Emails are unexpectedly synchronized or contain unexpected or missing data
description: Provides troubleshooting information for the incoming emails are unexpectedly synchronized or contain unexpected or missing data issue in Microsoft Dataverse.
ms.date: 09/20/2024
ms.custom: sap:E-mail and Microsoft 365 Integration\Set up and configuration of server-side synchronization
author: rahulmital
ms.author: rahulmital
---
# Incoming Emails are unexpectedly synchronized or contain unexpected or missing data

## Emails are unexpectedly tracked or synchronized

Server-Side Synchronization will automatically track emails based on the **Incoming Email Filtering Method** specified for each identified (resolved) Dataverse recipient. A Dataverse recipient is resolved by locating the applicable user and queue mailboxes associated with the email addresses found in the To, Cc, and Bcc fields on the received email from the external system (i.e. Exchange / Gmail).

If an email was unexpectedly synchronized into the system, you can identify the Dataverse mailbox that automatically accepted the email by examining the following properties of the synchronized email in Dataverse:

- **Accepting Entity**: The user or queue that received the email and was configured to automatically track it. For example, if a queue named Customer Service that has been configured to track all emails receives an email, then the Customer Service queue is considered the Accepting Entity. **Note**: This column will be empty for manually tracked emails. In this case, you can refer to the **Created by** column.
- **Receiving Mailbox**: The mailbox that was processed when server-side sync detected that an email contained a user or queue that was configured to automatically track it. **Important**: The value of this column can be different from the Accepting Entity. For example, suppose Paul Cannon, who is set up to automatically track replies to existing emails, receives a message. The Customer Service queue, which is set up to track all email, receives the same message. Server-side synchronization may process Paul's mailbox first and recognize that another recipient, Customer Service, is configured to automatically track the email. In this case, the Accepting Entity is the Sales queue, but the Receiving Mailbox is Paul's.

Please note that these fields do not appear on the Email form by default. You can add them to the form or to an Advanced Find view to see their values:

:::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/accepting-entity-receiving-mailbox.png" alt-text="Screenshot that shows the Accepting Entity and Receiving Mailbox properties.":::

Once the **Accepting Entity** is identified, you can change the Incoming Email Filtering Method of the user or queue to prevent future occurrences if needed by referring to the below documentation:

[Set personal options that affect tracking and synchronization between customer engagement apps and Outlook or Exchange](/power-platform/admin/set-personal-options-affect-tracking-synchronization-between-dynamics-365-outlook-exchange)

As mentioned above, the system will evaluate the Incoming Email Filtering method of all resolved recipients. Therefore, if an email address is associated with more than one Dataverse mailbox with different Incoming Email Filtering method settings, emails may unexpectedly synchronize into the system. You can examine the To, Cc, and Bcc fields on the email in Dataverse to identify any unexpected Dataverse recipients.

For example, the below email was addressed to a single recipient in Exchange, but was resolved to both a user and queue that shared the same email address in Dataverse:

:::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/email-resolved-to-user-and-queue.png" alt-text="Screenshot that shows an email example that is resolved to both a user and queue that share the same email address in Dataverse.":::

In this case, the email was automatically accepted by Paul Cannon's Queue because it accepted **All Email Messages**, even though Paul Cannon's personal user options were set to None:

Paul Cannon's Queue:

:::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/all-email-messages-accepeted-by-queue.png" alt-text="Screenshot that shows the Convert Incoming Email To Activities is set to All Email Messages.":::

Paul Cannon User Settings:

:::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/personal-user-set-to-no-mail.png" alt-text="Screenshot that shows the personal user settings.":::

## Duplicate emails are tracked or synchronized in Dataverse

Server-Side Synchronization can be configured to allow users to automatically create **Sent** and **Received** copies of the same email if the email meets the user's **Incoming Email Filtering Method**. This configuration is driven from the below **System Setting**:

1. In Dataverse, click the Gear icon -> **Advanced Settings**
2. Navigate to **Settings** -> **Email Configuration** -> **Email Configuration Settings**
3. Scroll down to "Set tracking options for emails between Microsoft Dynamics 365 users."

:::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/track-emails-sent-between-dynamics-365-as-two-activities.png" alt-text="Screenshot that shows the Set tracking options for emails between Microsoft Dynamics 365 users setting.":::

When the above setting is enabled, the system will automatically track emails that satisfy the user's **Incoming Email Filtering Method** settings, regardless of whether the email is a duplicate of an existing Sent or Received copy. You can learn more about how the system detects if an email should be automatically promoted here:

[Specify which emails are automatically tracked - Power Platform](/power-platform/admin/email-message-filtering-correlation)

### Additional Scenarios

The above System Setting is intended to apply to email messages sent between Users. However, even if the above setting is disabled, duplicate emails can still be created based on a recipient's **Incoming Email Filtering Method** if a queue is a sender or recipient of an email.

These scenarios are described below:

1. An email is sent from a Dataverse Queue to a User.
2. An email is sent from a Dataverse User to a Queue mailbox.

To resolve the first scenario, enable the **IgnoreInternalEmailFromQueues** database setting.

To resolve the second scenario, disable the **DoNotIgnoreInternalEmailToQueues** database setting.

You can learn more about how to set database settings using the instructions below:

[How to change default environment database settings](/power-platform/admin/environment-database-settings)

You can learn more about different database settings that affect Server-Side Synchronization in the article below:

[Default OrgDBOrgSettings for server-side synchronization](/power-platform/admin/orgdborgsettings)

## Old, past, or historic emails are unexpectedly tracked or synchronized to Dataverse

Server-Side Synchronization uses the **Process Email From** (ProcessEmailsReceivedAfter) date on each mailbox record to determine how far back the system should go to process emails. This value is maintained and updated by the system when new emails are processed in subsequent synchronization cycles after initial onboarding.

If you have recently **Tested and Enabled a mailbox** for the first time, the system will initially use the **Process Email From** (ProcessEmailsReceivedAfter) date on the associated **Email Server Profile** record to establish the starting date for processing:

:::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/process-email-from.png" alt-text="Screenshot that shows the Process Email From setting.":::

If you have already Tested and Enabled a mailbox which used an old date, you can customize the **Mailbox form** and add the **Process Email From** attribute so that you can update it to use a newer value which will take effect on the next cycle.

**Note**: The system will always utilize the greater value between the Process Emails From date on the email server profile and the mailbox.

You can read more about how the Process Email From date influences synchronization here:

[Best practices for server-side synchronization](/power-platform/admin/best-practices-server-side-synchronization#considerations)

## Synchronized emails contain unexpected sender or recipient parties in Dataverse

Server-Side Synchronization performs email address resolution on all sender and recipient email addresses when synchronizing incoming emails into the system. This is done by retrieving all records in Dataverse which are associated with a given email address. When a match is found, the system will associate the located record(s) as an activity party on the email.

As a result, if an email address is associated with more than 1 Dataverse record (such as an email address being shared between a user and queue), then all resolved recipients will appear in their respective recipient fields. For example, in the below screenshot, Paul Cannon's email address is associated with both the user's mailbox as well as a queue, causing both of them to appear as recipients even though Paul Cannon's email address only appears a single time in the received email in Exchange:

:::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/email-address-associated-with-user-and-queue.png" alt-text="Screenshot that shows an email address that sis associated with both the user's mailbox as well as a queue.":::

Additional information about this topic can be found in the below resources:

1. [FAQs about email tracking (Dynamics 365 apps)](/dynamics365/outlook-app/user/faq-email-tracking#2-when-resolving-recipient-email-addresses-to-rows-in-dynamics-365-if-there-is-more-than-one-row-in-dynamics-365-with-the-same-email-address-which-row-is-it-resolved-to) (Point #2)
2. [FAQs about email tracking (Dynamics 365 apps)](/dynamics365/outlook-app/user/faq-email-tracking#5-multiple-row-types-exist-in-dynamics-365-with-the-same-email-addresses) (Point #5)

Likewise, if an email address is not associated with a known Dataverse record, the email address will appear unresolved.

### How does the system know which email address fields to check?

Any column in Dataverse that has a format type of "[Email](/power-apps/developer/data-platform/data-type-format-conversions)" will participate in email address resolution:

:::image type="content" source="media/incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data/format-type-is-email.png" alt-text="Screenshot that shows an Email format type.":::

Sender Resolution Order:

Because an email can only have a single sender, when the sender's email address is associated with multiple Dataverse records, the system will utilize a priority order to determine the Sender activity party. This behavior is documented in the article below:

[Associate an email address with a row - Power Platform](/power-platform/admin/associate-email-address)

## Synchronized emails have unexpected owners in Dataverse

When server-side sync synchronizes an email message to Dynamics 365, the system determines the email owner based on the following factors:

1. The system evaluates the **To**, **Cc**, and **Bcc** recipient list in order until an appropriate owner is found. The owner is selected from the first recipient list it’s found in. The system checks each recipient and verifies that the owner of the associated mailbox is authorized to be the owner of the email. Eligibility is based on whether the owner of the mailbox associated with the recipient can also modify email records.
2. If the email is associated with an existing email, the system checks if the best match owner can be found. Using the recipient list, the system checks if any of the recipients are the owner of the associated email. If an eligible owner is found then the user is selected as the email owner.
3. If the best match owner isn’t found, then the system tries to find a second-best owner. If the related owner can't be found in the recipient list, the system attempts to resolve the sender of the email to a known contact, account, or lead. If the resolution is successful and the owner of the resolved record is an eligible owner that is also on the recipient list; only then the user is set as owner of the email.
4. If the second-best owner isn’t found, then the system uses the first eligible owner. If the system can't find an eligible owner based on the associated email owner or the owner of the sender record, the system will pick the first eligible owner in the current recipient list.

More information can be found in the link below:

[How is an email record owner determined](/power-platform/admin/email-record-owner)
