---
title: Cannot paste any attributes into a workbook in another Excel instance
description: Describes a behavior in which  you cannot paste cell attributes from one instance of Excel  to another instance of Excel. Provides a workaround.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - Editing\CopyOrPaste
  - CSSTroubleshoot
  - CI 10745
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: akeeler, v-lisalozano
appliesto: 
  - Excel for Microsoft 365
  - Microsoft Excel 2024
  - Microsoft Excel 2021
  - Microsoft Excel 2016
ms.date: 03/23/2026
---

# You cannot paste any attributes into a workbook in another instance of Excel

## Symptoms

Consider the following scenario:

- You run two instances of Microsoft Excel.

> [!NOTE]
> To force Excel to open in a second instance, press Alt, and then click the Excel icon.

- You open a workbook in each instance of Excel.
- Then, you intend to use the following **Paste Special** menu command to paste attributes from a cell in one workbook to a cell in the other workbook:

    :::image type="content" source="media/cannot-paste-attributes/paste-attributes.png" alt-text="Screenshot to use the Paste Special menu command to paste attributes." border="false":::

In this scenario, you cannot paste any attributes into the other workbook. The Excel **Paste Special** dialog box does not appear. Instead, the following Windows **Paste Special** dialog box appears:

   :::image type="content" source="media/cannot-paste-attributes/windows-paste-special.png" alt-text="Screenshot of the Windows Paste Special dialog box." border="false":::

Therefore, you cannot select any one of the following options:

- **Formulas**
- **Values**
- **Formats**
- **Comments**

These options appear only in the Excel **Paste Special** dialog box.

## Cause

This behavior occurs because Excel cannot use its internal copying functionality when you run multiple instances of Excel. Instead, Excel relies on the Windows **Paste Special** dialog box for its copying functionality. When you run a single instance of Excel, Excel uses its internal copying functionality. Therefore, the Excel **Paste Special** dialog box is available in this situation.  

## Workaround

To work around this behavior, open both workbooks in the same instance of Excel.
