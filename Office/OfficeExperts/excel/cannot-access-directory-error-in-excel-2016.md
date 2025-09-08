---
title: Cannot access directory when change the default save location in Excel 2016
description: Fixes the error of cannot access directory when you change the default save location to a SharePoint location.
author: Cloud-Writer
ms.author: meerak
ms.reviewer: warrenr
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Excel 2016
ms.date: 06/06/2024
---

# "Cannot access directory" error when you change the default save location in Excel 2016

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

When you try to change the default save location to a SharePoint location in Microsoft Excel 2016 through the **Default local file location** setting, you receive the following error message:

:::image type="content" source="media/cannot-access-directory-error-in-excel-2016/cannot-access-directory.png" alt-text="Screenshot of the error message after changing the default save location to a SharePoint location.":::

## Cause

For some unknown reasons, some Office 2016 installations can't create a necessary directory.

## Workaround

To work around this issue, add the following directory to the systems that are experiencing this issue:

C:\Users\userid\AppData\Roaming\Microsoft\Excel\URL\

> [!NOTE]
> You need to change the *userid* to a real user ID when you add this directory.
