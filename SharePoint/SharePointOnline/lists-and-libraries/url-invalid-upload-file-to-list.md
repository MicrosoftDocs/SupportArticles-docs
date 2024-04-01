---
title: The URL is invalid error when you upload a file to a SharePoint list
description: This article describes an issue where the URL is invalid when you upload a file to a SharePoint list, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Files and Documents\Upload
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server
ms.date: 12/17/2023
---

# "The URL is invalid" error message when you upload a file to a SharePoint list

## Problem

When you upload a file to a SharePoint Online or SharePoint 2013 list, you receive the following error message:

**The URL \<file name> is invalid. It may refer to a nonexistent file or folder, or refer to a valid file or folder that is not in the current Web.**

> [!NOTE]
> The placeholder \<file name> represents the name of the file that you uploaded to the SharePoint list.

## Solution

To work around this issue, remove the Version column from the list of Indexed Columns for the list that has this issue. To do this, follow these steps:

1. Browse to the list where the issue exists.

1. In the ribbon, click the **Library** tab, and then click **Library Settings**.

1. In the fields list, click **Indexed Columns**.

1. In the **Indexed Columns** list, click **Version**.

1. Click **Delete**, and then click **OK**.

1. Upload any files that you previously experienced the issue with.

## More information

This issue occurs when the Version column is configured as an Indexed Column.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
