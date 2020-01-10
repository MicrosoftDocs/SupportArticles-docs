﻿---
title: Cannot access directory when change the default save location in Excel 2016
author: AmandaAZ
ms.author: warrenr
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Excel 2016
---

# "Cannot access directory" error when you change the default save location in Excel 2016

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

When you try to change the default save location to a SharePoint location in Microsoft Excel 2016 through the **Default local file location** setting, you receive the following error message:

![the error message dialog box](./media/cannot-access-directory-error-in-excel-2016/cannot-access-directory.png)

## Cause

For some unknown reasons, some Office 2016 installations can’t create a necessary directory.

## Workaround

To work around this issue, add the following directory to the systems that are experiencing this issue:

C:\Users\userid\AppData\Roaming\Microsoft\Excel\URL\

> [!NOTE]
> You need to change the *userid* to a real user ID when you add this directory.
