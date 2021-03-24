---
title: Something went wrong 30016-4 error
description: Describes an issue that occurs when you try to remove Microsoft 365 Apps for enterprise from your computer. This triggers a 30016-4 error. A resolution is provided.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office 365
localization_priority: Normal
ms.reviewer: jalalb
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Microsoft 365 Apps for enterprise
---

# "Something went wrong 30016-4" error when you try to uninstall Microsoft 365 Apps for enterprise

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you try to uninstall Microsoft 365 Apps for enterprise from a computer, you receive the following error message:

> Something went wrong 30016-4

## Cause

This issue occurs if the %temp% drive is mapped to a drive other than %ProgramFiles%.

## Resolution

To fix this issue, completely remove Office from the computer. For the easiest way to do this, follow the guidance at [Uninstall Office 2013, Office 2016, or Office 365 from a PC](https://support.office.com/article/uninstall-office-2013-office-2016-or-office-365-from-a-pc-9dd49b83-264a-477a-8fcc-2fdf5dbf61d8?ui=en-us&rs=en-us&ad=us).
