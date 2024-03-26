---
title: Cannot activate Office 2013 on a new computer
description: Resolves the  This product key is for Microsoft Office <Edition Name> 2013, which isn't currently installed error message when you try to active Microsoft Office.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: viwoods, libbyu
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Office Professional Plus 2013
  - Office Professional 2013
  - Office Home and Business 2013
  - Office Home and Student 2013
  - Office Standard 2013
ms.date: 03/31/2022
---

# Cannot activate Office 2013 on a new computer

## Summary

When you enter a product key and then click **Activate** to active Microsoft Office 2013 for the first time on a new computer, you receive the following error message:

> This product key is for Microsoft Office \<Edition Name\> 2013, which isn't currently installed

## Cause

This issue may occur if you install KB2760624, KB2760621, or KB2752100 before you activate Office. If you do this, the following folder may be removed:

\<*system drive*\>\ProgramData\Microsoft\OEMOffice15

## Resolution

To resolve this issue, reinstall Office from the Office website or from another media. To download and reinstall Office from the Office website, go to the following Microsoft website:

[Get Office](https://www.office.com/getoffice)

### Applies to

This article applies to:

- Computers that have Office 2013 preinstalled, purchased and activated between January 29, 2013 and February 4, 2013.
- Computers that have Office 2013 preinstalled, on which KB2760624, KB2760621, or KB2752100 is installed before you try to activate Office.
