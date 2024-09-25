---
title: Emails aren't automatically tracked or synchronized
description: Provides troubleshooting information for the email synchronization issues when you use server-side synchronization in Microsoft Dataverse.
ms.date: 09/25/2024
ms.custom: sap:E-mail and Microsoft 365 Integration\Set up and configuration of server-side synchronization
author: rahulmital
ms.author: rahulmital
---
# Emails aren't automatically tracked or synchronized using server-side synchronization

This article provides troubleshooting information for the email synchronization issues when you use server-side synchronization in Microsoft Dataverse.

## Common causes

Generally, when an email isn't automatically synchronized, it's commonly due to one of the following issues:

1. A failure occurs when processing the email due to a customization (plugin or workflow) error in Dataverse.
2. There are no known Dataverse user or queue recipients of the email that automatically accept the email based on their [incoming email filtering method configuration](/power-platform/admin/email-message-filtering-correlation).
3. The Dataverse user who owns the receiving mailbox or queue record doesn't have a license or sufficient privileges to synchronize emails. [Learn more about the required privileges for email synchronization](/previous-versions/troubleshoot/dynamics/crm/privilegedenied-error-when-using-server-side-sync).
4. The received email isn't in the _root inbox_ folder of the target mailbox. Emails must remain in the _root inbox_ folder until after they are tracked. Moving emails between folders can cause them to be missed by server-side synchronization.
5. The mailbox isn't properly configured in the remote email system (Exchange or Gmail), or has connectivity issues to the remote email system. Configuration and connectivity errors can be found on the mailbox alerts wall.

### Troubleshooting with the Server-Side Synchronization Item Level Monitoring dashboard

You can use the [Server-Side Synchronization Item Level Monitoring](/power-platform/admin/troubleshooting-monitoring-server-side-synchronization#the-server-side-synchronization-item-monitoring-dashboard) dashboard to understand why emails, appointments, contacts, and tasks aren't synchronized.

To open the **Server-Side Synchronization Item Level Monitoring** dashboard:

1. In Microsoft Dataverse, go to **Email Configuration** area, select the following navigation link.

   :::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/server-side -synchronization-item-level-monitoring-dashboard.png" alt-text="Screenshot that shows how to open the Server-Side Synchronization Item Level Monitoring dashboard.":::

   > [!NOTE]
   > Dashboard failures are visible to the user who owns the mailbox or users who has the out-of-the-box System Administrator security role.

2. The **Sync Error** column contains information about why the item didn't synchronize. Selecting the link directs you to an article for the error, if one exists. For example,

   - This screenshot shows a "Question about service" email that isn't automatically tracked due to an [IsvAborted](/troubleshoot/dynamics-365/sales/unknownincomingemailintegrationerror-2147220891) error that occurs during processing. This error indicates a failure within a plugin or workflow which would need to be addressed by the solution owner.

     :::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/question-about-service-email-example.png" alt-text="Screenshot that shows an IsvAborted error that occurs in a Question about service email.":::

   - This screenshot shows a "Can we meet tomorrow?" email that isn't automatically tracked due to a [NoCorrelationMatch](/troubleshoot/dynamics-365/sales/email-fails-to-create-with-nocorrelationmatch-error) error. This error occurs because none of the resolved (known) Dataverse recipients of the email automatically accept it based on their [personal option settings](/power-platform/admin/email-message-filtering-correlation).

     :::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/can-we-meet-tomorrow-email-example.png" alt-text="Screenshot that shows an NoCorrelationMatch error that ccurs in a Can we meet tomorrow email.":::

### Troubleshooting by reviewing mailbox alerts

You can also review the **Alerts** in the intended Dataverse recipient mailboxes. It also contain helpful information about processing errors. To get the information,

1. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select an environment.
2. Select **Settings** > **Email** > **Mailboxes**.
3. Open the affected mailbox record, and on the left navigation bar, under **Common**, select or tap **Alerts**.

:::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/mailbox-alerts.png" alt-text="Screenshot that shows the Alerts section in your mailbox settings.":::

For example, the following alert message indicates that emails can't be processed due to an error in the '1 Test' custom workflow.

> Starting sync workflow '1 Test', id:\<ID> Entering UpdateStep1_step:  
> Sync workflow '1 Test' teminated with error 'Entity 'Contact' With Id = \<ID> Does Not Exist'

:::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/alert-message.png" alt-text="Screenshot that shows an alert message indicating that emails can't be processed due to an error in a custom workflow.":::

A close examination of the error reveals that the workflow tries to set regarding to a contact which no longer exists in the system, thus causing the creation of the email to fail.

## Specific emails aren't automatically tracked as expected

Emails in the _Inbox_ folder are automatically tracked by server-side synchronization into Dataverse if any of the resolved (known) user or queue recipients of a given email accept the email based on their [incoming email filtering method configuration](/power-platform/admin/email-message-filtering-correlation). For more information, see:

- [Specify which emails are automatically tracked](/power-platform/admin/email-message-filtering-correlation)
- [Set personal options that affect tracking and synchronization between customer engagement apps and Outlook or Exchange](/power-platform/admin/set-personal-options-affect-tracking-synchronization-between-dynamics-365-outlook-exchange)

To narrow down why an email might not be automatically tracked, check each of the followings:

1. For the email in question, ensure the email is in the _Inbox_ folder of the target Dataverse mailbox. Emails outside of the inbox folder can't be reliably processed, even if they are moved back to the _Inbox_ later. For example, if an email is initially sent to your _Spam_ folder or is moved to a sub-folder by an Outlook rule, server-side synchronization won't be unable to process those emails, even if they are eventually moved back to the _Inbox_ folder.

    - If you need to reprocess an email that was moved back to the _Inbox_ folder, you can reset the processing date (`ProcessEmailsReceivedAfter`) on the Dataverse mailbox record which will allow server-side synchronization to discover and process the email. Details are [outlined in the "Note" here](/power-platform/admin/best-practices-server-side-synchronization#considerations).
    - If you try to automatically track email responses sent from Outlook (which are in your _Sent Items_ folder), see [Welcome to Alchemy Portal](https://alchemyportal.azurewebsites.net/#autotracksentfolderitems).
    - If you'd like to track emails that are moved to sub-folders, you need to enable [Folder-Based tracking](/power-platform/admin/configure-outlook-exchange-folder-level-tracking).

2. Examine the recipient email addresses in the **To:** and **Cc:** lines and ensure that at least one of the addresses is associated with a Dataverse mailbox which is tested and enabled for server-side synchronization and is configured to automatically track the email based on its associated [incoming email filtering method](/power-platform/admin/set-personal-options-affect-tracking-synchronization-between-dynamics-365-outlook-exchange). If the email is addressed to a "Distribution Group" or has a "BCC" recipient, see [this topic](https://alchemyportal.azurewebsites.net/#DLNote) to ensure that the underlining Dataverse mailbox is correctly configured.

3. Ensure that the recipient email addresses in Exchange or Gmail match the corresponding email address of the Dataverse user or queue mailbox.

## Troublechooting issues with distribution groups and BCC recipients

Dataverse will resolve the recipient email addresses on the email to known Dataverse user or queue records. As such, if the recipient email addresses include a dstribution group or have been included as "BCC" recipients, Dataverse can't resolve these recipients to known Dataverse users or queues.

To allow emails to automatically track from distribution groups or "BCC" recipients, the underlining Dataverse user or queue mailbox that receives the email must be configured to accept **All Email Messages**.

For more information, see [Set personal options that affect tracking and synchronization between customer engagement apps and Outlook or Exchange](/power-platform/admin/set-personal-options-affect-tracking-synchronization-between-dynamics-365-outlook-exchange).

## Emails can't be tracked or synchronized to Dataverse and are assigned the Undeliverable category in Exchange

:::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/undeliverable-email.png" alt-text="Screenshot that shows an email that is assigned to the Undeliverable category.":::

The "Undeliverable" category is assigned to emails if server-side synchronization processes the email but can't create the email activity record in Dataverse. This will typically occur due to a custom plugin or workflow failure, or a privilege issue when processing the email. Privilege issues will commonly occur when the user who owns the receiving mailbox or queue doesn't have sufficient privileges to synchronize email records. [Learn more about the required privileges for email synchronization](/previous-versions/troubleshoot/dynamics/crm/privilegedenied-error-when-using-server-side-sync).

You can review information about **Failed Emails** by inspecting the [Server-Side Synchronization Item Level Monitoring dashboard](#troubleshooting-with-the-server-side-synchronization-item-level-monitoring-dashboard).

## Emails replies sent from Outlook aren't automatically synchronized using server-side synchronization

An administrator can configure the **AutoTrackSentFolderItems** value of [OrgDBOrgSettings](/power-platform/admin/orgdborgsettings), which will enable server-side synchronization to process emails in the _Sent items_ folder in Microsoft Exchange and automatically track reply emails to Microsoft Dynamics 365 by honoring the email acceptance options in [Set Personal Options](/power-platform/admin/set-personal-options-affect-tracking-synchronization-between-dynamics-365-outlook-exchange).

> [!IMPORTANT]
>
> - This feature is disabled by default and you must enable it by configuring the **AutoTrackSentFolderItems** value in OrgDBOrgSettings.
> - Enable tracking for sent items is only supported with a Microsoft Exchange mailbox.

For more informaiton, see [Automatically track sent folder items with server-side synchronization](/power-platform/admin/track-sent-folder-items).
