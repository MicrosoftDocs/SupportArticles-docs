---
title: Word slows or stops responding
description: Fixes an issue in which Word slows down or stops responding if you don't periodically accept or reject tracked changes in a document.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Reliability
  - CI 112326
  - CSSTroubleshoot
ms.reviewer: warrenr
appliesto: 
  - Word for Microsoft 365
  - Word 2019
  - Word 2016
  - Word 2013
  - Word 2010
search.appverid: MET150
ms.date: 06/06/2024
---

# Word slows or stops responding if there are excessive tracked changes or comments

## Symptoms

Microsoft Word becomes very slow or stops responding if an open document contains excessive tracked changes or comments.

## Cause

This issue may occur if tracked changes in the document are not periodically accepted or rejected.

## Resolution

To fix this issue, follow these steps:

1. Close all instances of Word.
2. Restart Word, and then open a new blank document.
3. On the **Review** tab, select **All Markup** in the **Tracking** group.
4. Select **Show Markup**, and then set **Balloons** to **Show only comments and formatting in balloons**.
5. Use **File** > **Open** to open the problematic document.

At this point, Word should be responsive. You can now accept or reject any changes, and remove comments.

> [!NOTE]
> Table changes have the biggest performance effect.

## More information

For more information about how to accept or reject tracked changes, see [Accept or reject tracked changes in Word](https://support.office.com/article/accept-or-reject-tracked-changes-in-word-b2dac7d8-f497-4e94-81bd-d64e62eee0e8).
