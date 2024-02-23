---
title: OneDrive sync error Sorry, OneDrive can’t add your folder right now
description: Describes fix for error Sorry, OneDrive can't add your folder right now.
author: helenclu
ms.reviewer: PramodBalusu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 149486
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - OneDrive for Business
ms.date: 12/17/2023
---

# OneDrive sync error “Sorry, OneDrive can’t add your folder right now”

## Symptoms

When you try to sync a OneDrive or SharePoint team site, you get the following error:

> Sorry, OneDrive can't add your folder right now.

## Cause

The following are some possible causes for this error:

- The **Require Check Out** option is enabled on the library.

- There are **Required columns** entries for the library.

- The **Draft Item Security** option is set to **Only users who can edit items**.

- You're syncing by using an external or guest account for OneDrive.

## Resolution

To fix this problem, use the resolution for the appropriate cause.

### Change “Require Check Out” to “No”

1. In the Classic view of the library, select the Settings (gear) icon, and turn on the Ribbon (if it is not already on).

1. Select the **Library** tab.

1. Select **Library Settings**, and then select **Versioning Settings**.

1. Change **Require Check Out** from **Yes** to **No**.

### Remove any required columns

1. Go to **Library Settings**.

1. Check each column for a check mark under **Required**.

1. For any columns that have the check mark, change the **Require this column to contain information** value to **No**.

### Make sure “Draft Item Security” is set to “Any user who can read items”

1. Go to **Library Settings**.

1. Select **Versioning Settings**.

1. Set **Draft Item Security** to **Any user who can read items**.

### Use an internal account to sync content

Syncing content by using a guest or external account is not supported. Instead, use an account that's internal to your organization.

For more information, see the "Libraries with specific columns or metadata" section under [Restrictions and limitations in OneDrive and SharePoint](https://support.microsoft.com/office/64883a5d-228e-48f5-b3d2-eb39e07630fa).
