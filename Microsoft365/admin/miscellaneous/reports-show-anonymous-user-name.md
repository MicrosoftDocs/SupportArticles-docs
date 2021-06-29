---
title: O365 reports show anonymous instead of actual user names
description: Describes an issue in which Office 365 reports show anonymous usernames instead of the actual user names.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-administration
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-maqiu
appliesto:
- Office 365 Business
---

# Office 365 reports show anonymous user names instead of actual user names

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

Office 365 reports show anonymous user names instead of the actual user names in the following reports:

- Email activities
- OneDrive files
- SharePoint files

To see these reports in the Office 365 Portal, go to **Home**, **Reports**, and then **Usage**.

## Cause

This issue occurs because of a setting in the Office 365 portal.

## Resolution

To resolve this issue, change the following account setting in the Office 365 portal.

> [!NOTE]
> You must be an Office 365 tenant administrator.

1. Go to [https://portal.office.com](https://portal.office.com/).
1. Go to **Settings**, **Org Settings**, and then **Reports**.
1. Disable the **Display anonymous identifiers instead of names in all reports** setting.
