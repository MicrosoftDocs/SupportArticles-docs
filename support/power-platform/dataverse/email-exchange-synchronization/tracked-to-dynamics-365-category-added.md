---
title: Tracked to Dynamics 365 category is unexpectedly added to user's mailbox
description: Fixes an issue in which users see a new category called Tracked to Dynamics 365 when they're configured to use server-side synchronization with Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 11/25/2024
ms.custom: sap:Email and Exchange Synchronization
---
# A "Tracked to Dynamics 365" category is unexpectedly added to a user's mailbox

This article helps you fix an issue in which users see a new category called **Tracked to Dynamics 365** when they're configured to use server-side synchronization with Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365
_Original KB number:_ &nbsp; 4501716

## Symptoms

Users configured to use server-side synchronization with Dynamics 365 might see a new category available in their Exchange mailboxes and in Outlook. For example: If the user uses the **Categorize** option in Outlook on an item such as an email message or appointment, they see a new category called **Tracked to Dynamics 365**.

When viewing [the Alerts area for a user's mailbox](/exchange/monitoring/mail-flow-insights/alert-policy-and-its-configuration#viewread-alert-policy), you might see the following information level alert message:

> Outlook Category "Tracked To Dynamics 365" has been enabled for the mailbox [Mailbox Name] as the OrgDBOrgSetting is enabled. Use this Outlook category to track emails, appointments and tasks.

## Cause

Server-side synchronization allows tracking of emails, appointments and tasks in Outlook with a [special category](https://support.microsoft.com/office/set-categories-flags-or-reminders-a894348d-b308-4185-840f-aff63063d076) "Tracked to Dynamics 365". As of version 9.1.0.4039 or later, the category-based tracking feature is on by default. For more information, see [Use Outlook category to track appointments and emails](/power-platform/admin/use-outlook-category-track-appointments-emails).

## Resolution

As an administrator, you can disable the feature within the [Power Platform admin center](https://admin.powerplatform.microsoft.com) or by setting the `TrackCategorizedItems` to **False** using the OrgDBOrgSetting tool.

### Disable the "Tracked to Dynamics 365" category in Power Platform admin center

1. Sign in to [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
2. Select **Environments** on the left navigation pane, select an environment and then select **Settings**.
3. Under the **Email** section, select **Email tracking**.
4. Locate the **People can use categories to track emails and appointments** option and switch it to **Off**.

> [!NOTE]
> Disabling the feature removes the **Tracked to Dynamics 365** category from all Exchange mailboxes of the organization that have server-side synchronization enabled in about 15 minutes.

### Disable the "Tracked to Dynamics 365" category using the OrgDBOrgSetting TrackCategorizedItems

Dynamics 365 provides the OrgDBOrgSettings tool that gives administrators the ability to implement specific updates that were previously reserved for registry implementations.

To disable the **Tracked to Dynamics 365** Outlook category, install the OrgDBOrgSetting tool in your organization. For more information, see [Extract the OrgDBOrgSettings tool and set the value of TrackCategorizedItems to False to remove the category tracking flag and functionality](https://support.microsoft.com/help/2691237/orgdborgsettings-tool-for-microsoft-dynamics-crm).

> [!NOTE]
>
> - Disabling the OrgDBOrgSetting `TrackCategorizedItems` removes the **Tracked to Dynamics 365** category from all Exchange mailboxes of the organization that have server-side synchronization enabled in about 15 minutes.
> - If you disable OrgDBOrgSetting `TrackCategorizedItems`, the "Tracked to Dynamics 365" category is soft-deleted, with the category assignment retained in Outlook. If you delete the category from the master list, it will be deleted permanently.

Instead of using the command-line option, you can also use [OrgDBOrgSetting/Releases](https://github.com/seanmcne/OrgDbOrgSettings/releases/) to edit the OrgDBOrgSetting `TrackCategorizedItems`.
