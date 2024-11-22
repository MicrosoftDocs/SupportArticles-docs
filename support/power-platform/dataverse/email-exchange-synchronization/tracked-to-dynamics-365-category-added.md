---
title: Tracked to Dynamics 365 category is added to user's mailbox
description: Fixes an issue in which users see a new category called Tracked to Dynamics 365 when they're configured to use server-side synchronization with Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 11/22/2024
ms.custom: sap:Email and Exchange Synchronization
---
# A "Tracked to Dynamics 365" category is added to user's mailbox

This article helps you fix an issue in which users see a new category called **Tracked to Dynamics 365** when they're configured to use server-side synchronization with Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365
_Original KB number:_ &nbsp; 4501716

## Symptoms

Users configured to use server-side synchronization with Dynamics 365 might see a new category available in their Exchange mailboxes and in Outlook. For example: If the user uses the **Categorize** option in Outlook on an item such as an email message or appointment, they see a new category called **Tracked to Dynamics 365**.

When viewing the **Alerts** area for a user's mailbox, you might see the following information level alert message:

> Outlook Category "Tracked To Dynamics 365" has been enabled for the mailbox [Mailbox Name] as the OrgDBOrgSetting is enabled. Use this Outlook category to track emails, appointments and tasks.

## Cause

As of version 9.1.0.4039 or later, category tracking is on by default. For more information, see [Use Outlook category to track appointments and emails](/power-platform/admin/use-outlook-category-track-appointments-emails).

## Resolution

As an administrator, you can disable the feature within the [Power Platform admin center](https://admin.powerplatform.microsoft.com) or by setting the `TrackCategorizedItems` to **False** using the OrgDBOrgSetting tool.

### Remove the "Tracked to Dynamics 365" category in Power Platform admin center

1. Sign in to [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
2. Select **Environments** on the left navigation pane, select an environment and then select **Settings**.
3. Under the **Email** section, select **Email tracking**.
4. Locate the **People can use categories to track emails and appointments** option and switch it to **Off**.

> [!NOTE]
> Disabling the feature removes the **Tracked to Dynamics 365** category from all Exchange mailboxes of the organization that have server-side synchronization enabled in about 15 minutes.

### Remove the "Tracked to Dynamics 365" category using the OrgDBOrgSetting TrackCategorizedItems

To disable the special **Tracked to Dynamics 365** Outlook category, you need to install the OrgDBOrgSetting tool in your organization. Dynamics 365 provides the OrgDBOrgSettings tool that gives administrators the ability to implement specific updates that were previously reserved for registry implementations.

For more information, see [Extract the OrgDBOrgSettings tool and set the value of TrackCategorizedItems to False to remove the category tracking flag and functionality](https://support.microsoft.com/help/2691237/orgdborgsettings-tool-for-microsoft-dynamics-crm).

> [!NOTE]
>
> - Disabling the OrgDBOrgSetting `TrackCategorizedItems` removes the **Tracked to Dynamics 365** category from all Exchange mailboxes of the organization that have server-side synchronization enabled in about 15 minutes.
> - If you disable OrgDBOrgSetting `TrackCategorizedItems`, the "Tracked to Dynamics 365" category is soft-deleted, with the category assignment retained in Outlook. If you delete the category from the master list, it will be deleted permanently.

Instead of using the command-line option, you can also use [this tool](https://github.com/seanmcne/OrgDbOrgSettings) to edit the OrgDBOrgSetting `TrackCategorizedItems`.
