---
title: Mentions in SharePoint files don’t send email notifications to participant
description: When you @mention someone in a SharePoint file for their collaboration, they don't receive the intended notifications.
author: Cloud-Writer
ms.reviewer: salarson
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Files and Documents\Versioning
  - CSSTroubleshoot
  - CI 150095
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# @Mentions in SharePoint files don’t send email notifications to participants

## Symptoms

When you [@mention someone](https://support.microsoft.com/office/use-mention-in-comments-to-tag-someone-for-feedback-644bf689-31a0-4977-a4fb-afe01820c1fd#ID0EAADAAA=Windows) in a SharePoint file so that they can collaborate on the file, that person doesn't receive the intended email notifications.

## Cause

This problem can occur if one of the following conditions is true:

- The file is in the [Checked out](https://support.microsoft.com/office/check-out-check-in-or-discard-changes-to-files-in-a-library-7e2c12a9-a874-4393-9511-1378a700f6de) state.

- The file is in the **Draft** state, and the library’s **Draft item security options** don’t include **Any user who can read items**.

## Resolution

To fix this problem, try to check in the file by following these steps:

1. In the Document Library where the file is stored, highlight the file, and then select the three vertical dots in that row.

1. Select **More** > **Check in**.

If checking in the file doesn't work, or if the file is already checked in, you can move the file from the draft state by using the following steps. If you want to leave the file in the draft state, skip the first three steps, and go to the steps to change the Library settings.

1. Open the Document Library where the file is stored (**File** > **Open** > **View more files**).

1. Highlight the file that you want, and select the three vertical dots in its row.

1. In the menu that opens, select **More** > **Approve**.

If you want to leave the file in the draft state, change the Library settings by following these steps:

1. In the Document Library where the file is stored, select the Settings button (the gear icon at the top of the page).

1. Select **Versioning settings**. 

1. Under **Draft Item Security** > **Who should see draft items in this document library?**, select **Any user who can read items**.
