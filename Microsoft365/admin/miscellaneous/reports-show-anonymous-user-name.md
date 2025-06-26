---
title: Microsoft 365 reports show anonymous instead of actual user names
description: Describes an issue in which Microsoft 365 reports show anonymous usernames instead of the actual user names.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# Microsoft 365 reports show anonymous user names instead of actual user names

## Symptoms

Microsoft 365 reports show anonymous user names instead of the actual user names in the following reports:

- Email Activity
- Mailbox Activity
- OneDrive files
- SharePoint Activity
- SharePoint Site Usage
- Microsoft Teams Activity
- Viva Engage Activity
- Active users in Microsoft 365 Services and Apps
- Groups Activity

To see these reports in the Microsoft 365 admin center, go to **Home** > **Reports** > **Usage**.

## Cause

Starting September 1, 2021, we're hiding user information by default for all reports as part of our ongoing commitment to help companies support their local privacy laws. For more information, see [Microsoft 365 Reports in the admin center](/microsoft-365/admin/activity-reports/activity-reports?view=o365-worldwide&preserve-view=true#show-user-details-in-the-reports) and [Privacy changes to Microsoft 365 Usage Analytics](https://techcommunity.microsoft.com/t5/microsoft-365-blog/privacy-changes-to-microsoft-365-usage-analytics/ba-p/2694137).

## Resolution

To fix this issue, change the following setting in the Microsoft 365 admin center.

> [!NOTE]
> You must be a Microsoft 365 global administrator.

1. Go to the [Microsoft 365 admin center](https://admin.microsoft.com).
1. Go to **Settings** > **Org Settings** > **Services**.
1. Select **Reports**.  
1. Clear **Display concealed user, group, and site names in all reports**, and then select **Save**. 
