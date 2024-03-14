---
title: Inquire COM add-in options do not respond in Excel 2013
description: Works around an issue in which options on the INQUIRE tab in the Inquire COM add-in do not respond in Excel 2013.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
ms.reviewer: xl15beta, brampson, jenl
appliesto: 
  - Excel 2013
ms.date: 03/31/2022
---

# Inquire COM add-in options do not respond in Excel 2013

## Symptoms

When you enable the Inquire COM add-in in Microsoft Excel 2013, the **INQUIRE** tab is displayed as expected. However, there is no response when you click any option (such as the **Clean Excess Cell Formatting** or **Compare Files** option) on the **INQUIRE** tab. When this issue occurs, you do not receive an error message. 

## Cause

This issue occurs because the Inquire COM add-in works only on computers that have the .NET Framework 4 or a later version of the .NET Framework installed.

## Workaround

To work around this issue, install the .NET Framework 4 or a later version of the .NET Framework. 

**Note** We recommend that you install the Microsoft .NET Framework 4.5 to work around the issue. To do this, go to [Download the .NET Framework 4.5](https://www.microsoft.com/download/details.aspx?id=30653).
