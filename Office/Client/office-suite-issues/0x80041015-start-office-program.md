---
title: 0x80041015 error when you start an Office program
description: Discusses that you receive a 0x80041015 error when you try to start a Microsoft Office 2013 or Microsoft Office 365 program. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.prod: office 365
ms.topic: article
ms.author: luche
appliesto:
- Microsoft 365 Apps for enterprise
- Office 365 Home
- Office 365 Personal
---

# You receive a "0x80041015" error message when you try to start an Office program

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you try to start a Microsoft Office 365 program, you receive the following error message:

```adoc
Sorry, we ran into a problem While trying to install the product key.

If this keeps happening, you should try repairing your office product.

System error: 0x80041015
```

## Cause

This problem can occur when all the following conditions are true:

- An Office product was activated before the May Public Update was installed.
- There was an attempt to add another Office product (such as Microsoft Visio, OneDrive for Business, or Office 365) or to reinstall an Office product on the same computer after the May Public Update was installed.

## Resolution

### Click-to-Run information

An updated Office 2013 Click-to-Run image has been published that also resolves this problem. To obtain the image and for more information, see the following Microsoft Office Sustained Engineering Team blog article:

[C2R Update - May 2014](https://blogs.technet.com/b/office_sustained_engineering/archive/2014/05/22/c2r-update-may-2014.aspx)
