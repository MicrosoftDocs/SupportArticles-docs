---
title: Mentions in SharePoint documents don’t send email to participant
description: When you @mention someone in a SharePoint document so they can participate in collaboration on the document, they might not get an email as intended.
author: sallarson
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-matham
ms.custom: 
- CSSTroubleshoot
- CI 150095
appliesto:
- SharePoint Online
---

# Mentions in SharePoint documents don’t send email to participant

## Symptom

When you [@mention someone](https://support.microsoft.com/office/use-mention-in-comments-to-tag-someone-for-feedback-644bf689-31a0-4977-a4fb-afe01820c1fd#ID0EAADAAA=Windows) in a SharePoint document so they can participate in collaboration on the document, they might not get an email as intended.

## Cause

This problem can occur if one of the following conditions is true:

- The file is in the [Checked out](https://support.microsoft.com/office/check-out-check-in-or-discard-changes-to-files-in-a-library-7e2c12a9-a874-4393-9511-1378a700f6de) state.

- The file is in the **Draft** state, and the library’s **Draft item security options** don’t include **Any user who can read items**.

## Resolution

Try checking the document in using the following steps:

1. In the Document Library where the file is stored, highlight the file, and select the three vertical dots in its row.

1. Select **More** > **Check in**.

Checking in the file might fix the problem. If not, or if the file was already checked in, you can remove it from draft state by using the below steps. If you want to leave it in the draft state, skip the following two steps, and see the instructions for changing the Library settings.

1. In the Document Library where the file is stored, highlight the file, and select the three vertical dots in its row.

1. Select **More** > **Approve**.

If you want to leave the file in the draft state, change the Library settings using the following steps:

1. In the Document Library where the file is stored, select Settings (the gear icon at the top of the page).

1. Select **Versioning settings**. Under **Draft Item Security** > **Who should see draft items in this document library?** select **Any user who can read items**.