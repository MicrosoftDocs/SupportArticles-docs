---
title: Word slows or stops responding
description: Fixes an issue in which Word slows down or stops responding if you don't periodically accept or reject tracked changes in a document. 
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro 
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- CI 112326
- CSSTroubleshoot
ms.reviewer: warrenr
appliesto:
- Word for Office 365
- Word 2019
- Word 2016
- Word 2013
- Word 2010
search.appverid: MET150
---

# Word slows or stops responding if there are excessive tracked changes or comments

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

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