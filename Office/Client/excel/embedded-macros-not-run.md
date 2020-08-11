---
title: Macros in embedded Excel workbook are blocked from running
description: Describes an issue that macros in embedded workbook are blocked from running when the Block macros from running in Office files from the Internet policy is enabled.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Excel for Office 365
- Excel 2019
- Excel 2016
---

# Macros in embedded Excel workbook are blocked from running

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptom

In an environment that has the **Block macros from running in Office files from the Internet** Group Policy setting enabled for Microsoft Excel 2016, macros in embedded Excel workbooks are blocked from running.

For example, when you create a new Excel workbook and embed a macro-enabled workbook in the new workbook, you receive the following security notice:

```adoc
Microsoft Office has identified a potential security concern.

Macros in this document have been disabled by your enterprise administrator for security reasons.   
```

## Cause

This issue occurs if the embedded Excel workbook isn't from a trusted location, or the new workbook isn't saved to a trusted location. 

## Resolution

To work around the issue, save the embedded or new workbook to a trusted location.

For more information about the **Block macros from running in Office files from the Internet** Group Policy setting, see [New feature in Office 2016 can block macros and help prevent infection](https://cloudblogs.microsoft.com/microsoftsecure/2016/03/22/new-feature-in-office-2016-can-block-macros-and-help-prevent-infection/?source=mmpc).