---
title: Unable to add an Address (A) or CNAME record in Office 365 Small Business
description: Describes an issue in which an "Another DNS record already exists with this host name" error occurs when you try to add an Address (A) or CNAME record in the Office 365 portal.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.service: sharepoint-powershell
ms.topic: article
ms.author: v-maqiu
appliesto:
- Office 365 Small Business
---

# "Another DNS record already exists with this host name" when adding an Address or CNAME record

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

In Office 365 Small Business, you try to add an Address (A) record or a CNAME record in the Office 365 portal. However, you get the following error message:

**Another DNS record already exists with this host name. Type a different name.**

## Solution

To add a record other than a www record, use a different host name, or update the existing record.

## More information

This issue occurs if the DNS record already exists.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).