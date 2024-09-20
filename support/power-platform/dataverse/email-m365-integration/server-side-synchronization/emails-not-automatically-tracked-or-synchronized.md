---
title: Emails aren't automatically tracked or synchronized
description: Provides troubleshooting information for the email synchronization issues when you use erver-side synchronization in Microsoft Dataverse.
ms.date: 09/20/2024
ms.custom: sap:E-mail and Microsoft 365 Integration\Set up and configuration of server-side synchronization
author: rahulmital
ms.author: rahulmital
---
# Emails aren't automatically tracked or synchronized using server-side synchronization

## Common causes

Generally, when an email does not automatically synchronize, it is commonly due to one of the following factors:

1. A failure is encountered when processing the email due to a customization (plugin/workflow) error in Dataverse.
2. There are no known Dataverse user or queue recipients of the email that automatically accept the email based on their incoming email filtering method [configuration](/power-platform/admin/email-message-filtering-correlation).
3. The Dataverse user who owns the receiving mailbox or queue record does not have a license or sufficient privileges to synchronize emails. You can learn more about the required privileges for email synchronization [here](/previous-versions/troubleshoot/dynamics/crm/privilegedenied-error-when-using-server-side-sync).
4. The received email is not in the **root Inbox** folder of the target mailbox. Emails must remain in the root inbox folder until after they are tracked. Moving emails between folders can cause them to be missed by Server-Side Sync.
5. The mailbox is not properly configured in the remote email system (Exchange, Gmail) or is experiencing connectivity issues to the remote email system. Configuration and connectivity errors can be found in the **Mailbox Alert Wall**.

### Using the Server-Side Synchronization Item Level Monitoring Dashboard

The **Server-Side Synchronization Item Level Monitoring Dashboard** can be accessed by clicking on the following navigation link in the **Email Configuration Area** within Dataverse:

:::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/server-side -synchronization-item-level-monitoring-dashboard.png" alt-text="Screenshot that shows the Server-Side Synchronization Item Level Monitoring Dashboard.":::

> [!NOTE]
> Dashboard Failures are visible to the user who owns the mailbox or users who have been assigned the out-of-the-box System Administrator security role.

:::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/question-about-service-email-example.png" alt-text="Screenshot that shows an IsvAborted error occurs in the Question about service email.":::

In the above example, the email **Question about service** was not automatically tracked because of an [IsvAborted](/troubleshoot/dynamics-365/sales/unknownincomingemailintegrationerror-2147220891) error that occurred during processing. This error indicates a failure within a plugin or workflow which would need to be addressed by the solution owner.

:::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/can-we-meet-tomorrow-email-example.png" alt-text="Screenshot that shows an NoCorrelationMatch error occurs in the Can we meet tomorrow email.":::

In this example, the email **Can we meet tomorrow?**  was not automatically tracked due to a  [NoCorrelationMatch](/troubleshoot/dynamics-365/sales/email-fails-to-create-with-nocorrelationmatch-error) response because none of the resolved (known) Dataverse recipients of the email automatically accepted it based on their [personal option settings](/power-platform/admin/email-message-filtering-correlation).

### Review Mailbox Alerts

You can also review the **Alerts** on the intended Dataverse recipient Mailboxes which can also contain helpful information about processing errors:

1. In the Power Platform admin center, select an environment.
2. Select **Settings** > **Email** > **Mailboxes**.
3. Open the affected mailbox record, and on the left navigation bar, under **Common**, click or tap **Alerts**:

:::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/mailbox-alerts.png" alt-text="Screenshot that shows the Alerts option in your mailbox settings.":::

For example, the below Alert message indicates that emails are failing to process due to an error in the '1 Test' custom workflow:

:::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/alert-message.png" alt-text="Screenshot that shows an alert message indicating that emails can't be processed due to an error in a custom workflow.":::

A close examination of the error reveals that the workflow was attempting to set regarding to a Contact which no longer exists in the system, thus causing the creation of the email to fail.

### Specific emails are not automatically tracked as expected

Emails in the **inbox** folder are automatically tracked by Server-Side Synchronization into Dataverse if any of the resolved (known) user or queue recipients of a given email accept the email based on their Incoming **Email Filtering Method** settings:

[Specify which emails are automatically tracked](/power-platform/admin/email-message-filtering-correlation)

[Set personal options that affect tracking and synchronization between customer engagement apps and Outlook or Exchange](/power-platform/admin/set-personal-options-affect-tracking-synchronization-between-dynamics-365-outlook-exchange)

As such, to narrow down why an email may not have been automatically tracked, please check each of the below bullet points:

1. For the email in question, ensure the email is in the **Inbox** folder of the target Dataverse mailbox. Emails outside of the inbox folder cannot be reliably processed, even if they are moved back to the Inbox later. For example, if an email is initially sent to your Spam folder or is moved to a sub-folder by an Outlook rule, Server-Side Sync will be unable to process those emails, even if they are eventually moved back to the Inbox folder.

    - If you need to reprocess an email that was moved back to the Inbox folder, you can reset the processing date (ProcessEmailsReceivedAfter) on the Dataverse mailbox record which will allow Server-Side Sync to discover and process the email. Details are [outlined in the "Note" here](/power-platform/admin/best-practices-server-side-synchronization#considerations).
    - If you are trying to automatically track email responses sent from Outlook (which are in your Sent Items folder), please see [this section](https://alchemyportal.azurewebsites.net/#autotracksentfolderitems).
    - If you'd like to track emails that are moved to sub-folders, you will need to enable [Folder-Based tracking](/power-platform/admin/configure-outlook-exchange-folder-level-tracking).

2. Examine the recipient email addresses in the To: and Cc: lines and ensure that at least one of the addresses is associated with a Dataverse mailbox which is Tested and Enabled for Server-Side Synchronization and is configured to automatically track the email based on its associated [Incoming Email Filtering Method](/power-platform/admin/set-personal-options-affect-tracking-synchronization-between-dynamics-365-outlook-exchange). If the email is addressed to a **Distribution Group** or has a **BCC recipient**, please see [this topic below](https://alchemyportal.azurewebsites.net/#DLNote) to ensure that the underlining Dataverse mailbox is correctly configured.

3. Ensure that the recipient email addresses in Exchange or Gmail match the corresponding email address of the Dataverse User or Queue mailbox.

### Distribution Groups and BCC Recipients

Dataverse will resolve the recipient email addresses on the email to known Dataverse user or queue records. As such, if the recipient email addresses include a Distribution Group or have been included as BCC recipients, Dataverse will not be able to resolve these recipients to known Dataverse users or queues.

To allow emails to automatically track from Distribution Groups or BCC recipients, the underlining Dataverse User or Queue mailbox that received the email must be configured to accept **All Email Messages**:

[Set personal options that affect tracking and synchronization between customer engagement apps and Outlook or Exchange](/power-platform/admin/set-personal-options-affect-tracking-synchronization-between-dynamics-365-outlook-exchange)

## Emails are failing to track or synchronize to Dataverse and are assigned the Undeliverable category in Exchange

:::image type="content" source="media/emails-not-automatically-tracked-or-synchronized/undeliverable-email.png" alt-text="Screenshot that shows an email that is assigned to the Undeliverable category.":::

The "Undeliverable" category is assigned to emails if Server-Side Synchronization processed the email but was unable to create the email activity record in Dataverse. This will typically occur because of a **custom plugin / workflow failure** or a **privilege issue** when processing the email. Privilege issues will commonly occur when the user who owns the receiving mailbox or queue does not have sufficient privileges to synchronize email records. You can learn more about the required privileges for email synchronization [here](/previous-versions/troubleshoot/dynamics/crm/privilegedenied-error-when-using-server-side-sync).

You can review information about **Failed Emails** by inspecting the **Item Level Monitoring Dashboard** as noted in the preceding section above.

## Emails replies sent from Outlook are not automatically synchronized using Server-Side Sync

An administrator can configure the [OrgDBOrgSettings](/power-platform/admin/orgdborgsettings) **AutoTrackSentFolderItems**, which will enable server-side synchronization to process emails in the **Sent items** folder on Microsoft Exchange and automatically track reply emails to Dynamics 365 by honoring the email acceptance options in [Set Personal Options](/power-platform/admin/set-personal-options-affect-tracking-synchronization-between-dynamics-365-outlook-exchange).

> [!IMPORTANT]
>
> - This feature is disabled by default and you must enable it with the OrgDBOrgSettings AutoTrackSentFolderItems setting.
> - Enable tracking for sent items is only supported with a Microsoft Exchange mailbox.

Please review the below documentation for full details:

[Automatically track sent folder items with server-side synchronization](/power-platform/admin/track-sent-folder-items)
