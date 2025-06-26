---
title: Document contains invalid signatures error if opening digitally signed in newer version Excel file
description: Describes a problem in which you receive an error message when you open an Excel 2007 digitally signed workbook in Excel 2010. Provides a workaround for this problem.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: hgkim，gaberry, akeeler
ms.custom: 
  - Security\Trust
  - CI 114484
  - CSSTroubleshoot
search.appverid: MET150
appliesto: 
  - Excel 2016
  - Excel 2013Excel 2010
  - Microsoft Office Excel 2007
ms.date: 05/26/2025
---

# "This document contains invalid signatures" error when opening Excel workbooks that were digitally signed in an earlier version

## Symptoms

You open a Microsoft Excel workbook that was digitally signed in an earlier version of Excel than the one that you are using. In this situation, the signature is no longer valid, and the following warning message is displayed in the Trust Bar:

> This document contains invalid signatures. [View Signatures]

> [!NOTE]
> When you open the digitally signed workbook in same program version that it was created in, the workbook opens as expected without an error message.

## Cause

When Excel opens a workbook that was last recalculated in a different version (either a different product version or an update that introduced changes in the recalculation behavior), it updates the internal recalculation data to the current version. Because this data is part of the file content, the digital signature is no longer valid because of this change in the content.

## Workaround

### Workaround 1

Before you sign the workbook, switch the calculation mode to **Manual**. To do this, select the **Formulas** tab on the ribbon, and then select **Manual** on the **Calculation Options** list.

> [!NOTE]
> Although the calculation option is saved per workbook, it can affect the setting for other workbooks that are opened in the same instance of Excel.

### Workaround 2

If the workbook is already signed, follow these steps:

1. Before you open the workbook, start Excel through the **Start** menu.
2. Change the calculation mode to **Manual**. To do this, select the **Formulas** tab on the ribbon, and then select **Manual** on the **Calculation Options** list.
3. To open the signed file, select **Open** on the **File** menu.

The signature should be displayed as valid.

> [!NOTE]
> If the calculation in any workbook is made when the workbook is open, the signatures will be invalidated because they are updated even if they return the same value.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
