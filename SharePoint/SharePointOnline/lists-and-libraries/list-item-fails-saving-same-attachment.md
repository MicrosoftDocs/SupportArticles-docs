---
title: Unable to reattach a file with the name that's same as a deleted attachment
description: Something went wrong or A file with the name already exists when you delete a list item attachment and then attach a file with the same name.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Error when you delete a SharePoint Online list item attachment and then attach a file with the same name

## Problem

Consider the following scenario:

- You're using the classic view for a Microsoft SharePoint Online list.
- You edit a list item that has an attachment, and you select the option to **Delete** the attachment.
- You reattach the same file or a file that has the same file name.

When you click **Save** in this scenario, you receive the following error message:

**Sorry, something went wrong.**

**A file with the name already exists.**

## Solution/Workaround

To work around this issue, use one of the following methods:

- After you delete the attachment for the list item, click **Save**. Edit the list item again, reattach the file, and then click **Save**.
- Upload the attachment with a different file name before you click **Save**.

## More information

This is a known issue in SharePoint Online.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
