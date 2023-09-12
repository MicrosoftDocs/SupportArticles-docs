---
title: Tracked To Dynamics 365 category added to user's mailbox
description: Fixes an issue in which users see a new category called Tracked to Dynamics 365 when they're configured to use Server-Side Synchronization with Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Tracked To Dynamics 365 category added to user's mailbox

This article helps you fix an issue in which users see a new category called **Tracked to Dynamics 365** when they're configured to use Server-Side Synchronization with Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4501716

## Symptoms

Users configured to use Server-Side Synchronization with Microsoft Dynamics 365 may see a new category available in their Exchange mailbox and in Outlook. For example: If the user uses the **Categorize** option in Outlook on an item such as an email message or appointment, they see a new category called **Tracked to Dynamics 365**.

When viewing the **Alerts** area for a user's mailbox, you may see the following information level alert message:

> Outlook Category "Tracked To Dynamics 365" has been enabled for the mailbox [Mailbox Name] as the OrgDBOrgSetting is enabled. Use this Outlook category to track emails, appointments and tasks.

## Cause

This experience is part of a feature that's now enabled by default:

[Use Outlook category to track appointments and emails](/power-platform/admin/use-outlook-category-track-appointments-emails)  

## Resolution

You can disable this feature within the [Power Platform Admin Center](https://admin.powerplatform.microsoft.com):

1. Access [Power Platform Admin Center](https://admin.powerplatform.microsoft.com/) as an administrator.
2. On the **Environments** tab, click **...** next to the name of the environment and then click **Settings**.
3. Click **Email Tracking**.
4. Locate the **People can use categories to track emails and appointments** option and switch the option to **Off**.
5. Disabling this setting will remove the category **Tracked to Dynamics 365** on all Exchange mailboxes of the Dynamics 365 for Customer Engagement organization that have server-side synchronization enabled in about 15 minutes.

As mentioned in the article above, it is also possible to disable this feature using the `OrgDBOrgSetting` named **TrackCategorizedItems**. The following information copied from the FAQ describes how to change this setting:

**How do I remove category-based tracking through OrgDBOrgSetting?**  

To disable the special **Tracked to Dynamics 365** Outlook category, you need to enable the `OrgDBOrgSetting` in your Dynamics 365 for Customer Engagement apps organization. Dynamics 365 for Customer Engagement apps provides the OrgDBOrgSettings tool that gives administrators the ability to implement specific updates that were previously reserved for registry implementations.

1. Follow the instructions [in this article](https://support.microsoft.com/help/2691237/orgdborgsettings-tool-for-microsoft-dynamics-crm) for steps to extract the tool.
2. After extracting the tool, disable the OrgDBOrgSetting `TrackCategorizedItems`.
3. Disabling the `OrgDBOrgSetting` will remove the category **Tracked to Dynamics 365** on all Exchange mailboxes of the Dynamics 365 for Customer Engagement organization that have server-side synchronization enabled in about 15 minutes.

Instead of using the command-line option mentioned above, you can also use [this tool](https://github.com/seanmcne/OrgDbOrgSettings/releases/) to edit the OrgDBOrgSetting `TrackCategorizedItems`.
