---
title: Emails aren't automatically tracked or synchronized
description: Provides troubleshooting information for the email synchronization issues when you use server-side synchronization in Microsoft Dataverse.
ms.date: 11/11/2024
ms.custom: sap:Email and Exchange Synchronization\Synchronization of incoming email
author: rahulmital
ms.author: rahulmital
ms.reviewer: debrau
---
# Emails aren't automatically tracked or synchronized using server-side synchronization

This article provides troubleshooting information for email synchronization issues when you use [server-side synchronization](/power-platform/admin/set-up-server-side-synchronization-of-email-appointments-contacts-and-tasks) in Microsoft Dataverse.

## Common causes

When emails fail to synchronize to Dataverse, it is often due to one of these reasons:

- A failure occurs when processing the email due to a customization (plugin or workflow) error in Dataverse.
- No known Dataverse users or email queue recipients automatically accept the email based on their [incoming email filtering method configurations](/power-platform/admin/email-message-filtering-correlation).
- The Dataverse user who owns the receiving mailbox or queue record doesn't have a license or sufficient privileges to synchronize emails. Learn more about [the required privileges for email synchronization](/previous-versions/troubleshoot/dynamics/crm/privilegedenied-error-when-using-server-side-sync#more-information).
- The received email isn't in the root _Inbox_ of the target mailbox. Emails must remain in the root _Inbox_ until they're tracked. Moving emails between folders can cause server-side synchronization to omit them.
- The mailbox isn't properly configured in the remote email system (Microsoft Exchange or Google Gmail), or there are connectivity issues between the mailbox and the remote email system. Configuration and connectivity errors can be found on the mailbox alert wall.

### Troubleshoot using the "Server-Side Synchronization Item Level Monitoring" dashboard

You can use the [Server-Side Synchronization Item Level Monitoring](/power-platform/admin/troubleshooting-monitoring-server-side-synchronization#the-server-side-synchronization-item-monitoring-dashboard) dashboard to understand why emails, appointments, contacts, and tasks aren't synchronized.

To get troubleshooting information in the **Server-Side Synchronization Item Level Monitoring** dashboard:

1. In Microsoft Dataverse, go to the **Email Configuration** area, and then select the **Server-Side Synchronization Item Level Monitoring** navigation link.

   :::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/server-side -synchronization-item-level-monitoring-dashboard.png" alt-text="Screenshot that shows how to open the Server-Side Synchronization Item Level Monitoring dashboard.":::

   > [!NOTE]
   > Dashboard failures are visible to the user who owns the mailbox or a user who has the out-of-the-box **System Administrator** security role.

2. The **Sync Error** column contains information about why an item didn't synchronize. Selecting the link directs you to an article about the error, if available. For example:

   - This screenshot shows a "Question about service" email that isn't automatically tracked due to an [IsvAborted](unknownincomingemailintegrationerror-2147220891.md) error that occurs during processing. This error indicates a failure within a plugin or workflow that needs to be addressed by the solution owner.

     :::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/question-about-service-email-example.png" alt-text="Screenshot that shows an IsvAborted error in a Question about service email.":::

   - This screenshot shows a "Can we meet tomorrow?" email that isn't automatically tracked due to a [NoCorrelationMatch](email-fails-to-create-with-nocorrelationmatch-error.md) error. This error occurs because none of the resolved (known) Dataverse email recipients automatically accept the email based on their [personal option settings](/power-platform/admin/email-message-filtering-correlation).

     :::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/can-we-meet-tomorrow-email-example.png" alt-text="Screenshot that shows a NoCorrelationMatch error in a Can we meet tomorrow email.":::

### Troubleshoot using mailbox alerts

Review mailbox alerts in the target Dataverse recipient's mailbox to identify and address synchronization issues and processing errors.

To get the information:

1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select an environment.
2. Select **Settings** > **Email** > **Mailboxes**.
3. Open the affected mailbox record, and then on the left navigation bar, under **Common**, select **Alerts**.

   :::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/mailbox-alerts.png" alt-text="Screenshot that shows the Alerts section in mailbox settings.":::

For example, the following alert message indicates that emails can't be processed due to an error in the "1 Test" custom workflow.

> Starting sync workflow '1 Test', id:\<ID> Entering UpdateStep1_step:  
> Sync workflow '1 Test' terminated with error 'Entity 'Contact' With Id = \<ID> Does Not Exist'

:::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/alert-message.png" alt-text="Screenshot that shows an alert message indicating that emails can't be processed due to an error in a custom workflow.":::

A closer examination of the error reveals that the workflow was trying to set a contact that no longer existed in the system, thus causing the email creation to fail.

## Specific emails aren't automatically tracked

Emails in the _Inbox_ folder are [automatically tracked](/power-platform/admin/email-message-filtering-correlation) by server-side synchronization into Dataverse if any of the resolved (known) users or email queue recipients accept them based on their [incoming email filtering method configurations](/power-platform/admin/email-message-filtering-correlation). For more information, see [Set personal options that affect tracking and synchronization between customer engagement apps and Outlook or Exchange](/dynamics365/outlook-addin/user-guide/set-personal-options-affect-tracking-synchronization-exchange).

To narrow down why an email might not be automatically tracked, check each of the following:

1. For the email in question, ensure the email is in the _Inbox_ folder of the target Dataverse mailbox. Emails outside the _Inbox_ folder can't be processed, even if they're moved back to the _Inbox_ later.

    - If you want to reprocess an email that was moved back to the _Inbox_ folder, you can reset the processing date (`ProcessEmailsReceivedAfter`) on the Dataverse mailbox record. This action allows server-side synchronization to discover and process the email. The details are outlined in the Note section of this [best practices page](/power-platform/admin/best-practices-server-side-synchronization#considerations).
    - If you want to automatically track email responses sent from Outlook (in your _Sent Items_ folder), see [Outlook replies aren't automatically synchronized](#outlook-replies-arent-automatically-synchronized).
    - If you want to track emails that were moved to subfolders, you need to enable [Folder-Based tracking](/power-platform/admin/configure-outlook-exchange-folder-level-tracking).

2. Examine the recipient email addresses in the **To:** and **Cc:** lines and ensure that at least one of them is associated with a Dataverse mailbox, which is [tested and enabled](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) for server-side synchronization and is configured to automatically track the email based on its associated incoming email filtering method. If the email is sent to a distribution group or has a Bcc recipient, refer to the topic below to ensure that the underlining Dataverse mailbox is correctly configured.

3. Ensure that the recipient email addresses in Exchange or Gmail match the corresponding email address of the Dataverse user or queue mailbox.

## Emails to distribution groups and BCC recipients aren't automatically tracked

Dataverse will resolve the recipient email addresses on the email to known Dataverse users or queue records. If the recipient email addresses include a distribution group or Bcc recipients, Dataverse can't resolve these recipients to known Dataverse users or queues.

### Resolution

To automatically track emails that are addressed to distribution groups or Bcc recipients, set up the underlining Dataverse user or queue mailbox that receives the email to accept **All Email Messages**. For more information, see [Set personal options that affect tracking and synchronization between customer engagement apps and Outlook or Exchange](/power-platform/admin/set-personal-options-affect-tracking-synchronization-between-dynamics-365-outlook-exchange).

## Emails assigned the Undeliverable category in Exchange

### Cause

When server-side synchronization processes an email but can't create an email activity record in Dataverse, the "Undeliverable" category is assigned to the email. This issue typically occurs due to a custom plugin, workflow failure, or privilege issue when processing the email. Privilege issues usually occur when the user who owns the receiving mailbox or queue doesn't have sufficient [privileges](/previous-versions/troubleshoot/dynamics/crm/privilegedenied-error-when-using-server-side-sync#more-information) to synchronize the email records.

:::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/undeliverable-email.png" alt-text="Screenshot that shows an email that is assigned to the Undeliverable category.":::

### Resolution

To solve this issue, review the [the required privileges for email synchronization](/previous-versions/troubleshoot/dynamics/crm/privilegedenied-error-when-using-server-side-sync#more-information) and ensure the required privileges are set up.

You can review information about failed emails by inspecting the [Server-Side Synchronization Item Level Monitoring dashboard](#troubleshoot-using-the-server-side-synchronization-item-level-monitoring-dashboard).

## Outlook replies aren't automatically synchronized

Ensure that the synchronization settings are correctly configured for Outlook replies. An administrator can configure the **AutoTrackSentFolderItems** value of [OrgDBOrgSettings](/power-platform/admin/orgdborgsettings). This action will enable server-side synchronization to process emails in the _Sent Items_ folder in Exchange and automatically track reply emails to Microsoft Dynamics 365 by honoring the email acceptance options in [Set Personal Options](/power-platform/admin/set-personal-options-affect-tracking-synchronization-between-dynamics-365-outlook-exchange).

> [!IMPORTANT]
>
> - Automatic tracking of sent items is disabled by default, and you must enable it by configuring the **AutoTrackSentFolderItems** value in **OrgDBOrgSettings**.
> - Enabling tracking for sent items is only supported with a Microsoft Exchange mailbox.

For more information, see [Automatically track sent folder items with server-side synchronization](/power-platform/admin/track-sent-folder-items).

## More information

[Incoming emails are unexpectedly synchronized or contain unexpected or missing data](incoming-emails-unexpectedly-synchronized-have-unexpected-missing-data.md)
