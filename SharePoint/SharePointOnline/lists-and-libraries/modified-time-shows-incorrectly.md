---
title: Modified time shows incorrectly for a SharePoint list
description: When viewing modified column in a SharePoint Online list, the list item shows the time stamp as "12:00 AM," even though no change was made at that specific time.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Lists and Libraries\Columns
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Modified time is not displayed correctly for a SharePoint Online list item

## Problem

When you view the **Modified** column in a SharePoint Online list, the list item shows the time stamp as "12:00 AM," even though no change was made at that specific time. The following conditions are also true in this situation:

- Under **Site Settings, Regional Settings, Locale**, your locale is set as **English (South Africa)**.
- Under **Site Settings, Regional Settings, Time Format**, the time format is set as **12 Hour**.

## Solution

To work around this issue, set the time format to **24 Hour**. To do this, follow these steps:

1. Browse to the site where the issue exists.
1. Click the gear icon to open the **Settings** menu, and then click **Site settings**.
1. In the **Site Administration** section of the Site Settings page, click **Regional settings**.
1. Change the **Time Format** setting to **24 Hour**, and then click **OK**.

> [!NOTE]
> After you make this configuration change, the time stamp will reflect an accurate time. However, it'll be displayed in 24-hour format.

## More information

This is a known issue in SharePoint Online.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
