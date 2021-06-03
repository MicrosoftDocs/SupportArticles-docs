---
title: OneDrive sync error “Sorry, OneDrive can’t add your folder right now” 
description: Describes fix for error "Sorry, OneDrive can't add your folder right now."
author: PramodBalusu
ms.author: v-matham
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office 365
ms.custom: 
- CSSTroubleshoot
- CI 149486
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- OneDrive for Business
---

# OneDrive sync error “Sorry, OneDrive can’t add your folder right now”

## Symptoms

When trying to sync a OneDrive or SharePoint team site, you get the following error:

> Sorry, OneDrive can't add your folder right now.

## Cause

The following are some possible causes for this error:

- **Require Check Out** was enabled on the library.

- There are **Required columns** for the library.

- The **Draft Item Security** is set to **Only users who can edit items**.

- You are syncing using an external or guest account for OneDrive.

## Resolution

The following are the resolutions for each of the causes.

### Change “Require Check Out” to “No”

1. In the Classic View of the library, select Settings (gear icon) and turn the Ribbon on (if it is not already).

1. Select the **Library** tab.

1. Select **Library Settings**, and then select **Versioning Settings**.

1. Change **Require Check Out** from **Yes** to **No**.

### Remove any required columns

1. Go to **Library Settings**.

1. Check each column for a check mark under **Required**.

1. Edit any columns that have the check mark, and change **Require this column to contain information** to **No**.

### Make sure “Draft Item Security” is set to “Any user who can read items”

1. Go to **Library Settings**.

1. Select **Versioning Settings**.

1. Set **Draft Item Security** to **Any user who can read items**.

### Use an internal account to sync content

Syncing content using a guest or external account is not supported. Use an account that is internal to your organization.

For more information, see "Libraries with specific columns or metadata" section under [Restrictions and limitations in OneDrive and SharePoint](https://support.microsoft.com/office/64883a5d-228e-48f5-b3d2-eb39e07630fa).