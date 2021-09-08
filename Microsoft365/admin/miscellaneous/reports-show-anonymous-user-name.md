---
title: Microsoft 365 reports show anonymous instead of actual user names
description: Describes an issue in which Microsoft 365 reports show anonymous usernames instead of the actual user names.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-administration
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-maqiu
appliesto:
- Microsoft 365
---

# Microsoft 365 reports show anonymous user names instead of actual user names

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

Microsoft 365 reports show anonymous user names instead of the actual user names in the following reports:

- Email Activity
- Mailbox Activity
- OneDrive files
- SharePoint Activity
- SharePoint Site Usage
- Microsoft Teams Activity
- Yammer Activity
- Active users in Microsoft 365 Services and Apps
- Groups Activity

To see these reports in the Microsoft 365 admin center, go to **Home** > **Reports** > **Usage**.

## Cause

Starting September 1, 2021, we are hiding user information by default for all reports as part of our ongoing commitment to help companies support their local privacy laws. For more information, please see [Microsoft 365 Reports in the admin center](https://docs.microsoft.com/en-us/microsoft-365/admin/activity-reports/activity-reports?view=o365-worldwide#show-user-details-in-the-reports) and [Privacy changes to Microsoft 365 Usage Analytics](https://techcommunity.microsoft.com/t5/microsoft-365-blog/privacy-changes-to-microsoft-365-usage-analytics/ba-p/2694137).

## Resolution

To resolve this issue, change the following account setting in the Microsoft 365 admin center.

> [!NOTE]
> You must be a Microsoft 365 tenant administrator.

1. Go to the [Microsoft 365 admin center](https://admin.microsoft.com).
1. Go to **Settings** > **Org settings** > **Reports**.
1. Clear the **In all reports, display de-identified names for users, groups, and sites.** option.
