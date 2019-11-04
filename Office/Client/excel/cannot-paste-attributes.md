---
title: Cannot paste any attributes into a workbook in another Excel instance
description: Describes a behavior in which  you cannot paste cell attributes from one instance of Excel  to another instance of Excel. Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Excel for Office 365
- Excel 2019
- Excel 2016
- Excel 2013
- Excel 2010
- Microsoft Office Excel 2007
---

# You cannot paste any attributes into a workbook in another instance of Excel

## Symptoms

Consider the following scenario:

- You run two instances of Microsoft Excel. 

> [!NOTE]
> To force Excel to open in a second instance, press Alt, and then click the Excel icon.
- You open a workbook in each instance of Excel.
- Then, you intend to use the following **Paste Special** menu command to paste attributes from a cell in one workbook to a cell in the other workbook:

    ![use Paste Special to paste attributes](./media/cannot-paste-attributes/paste-attributes.png)

In this scenario, you cannot paste any attributes into the other workbook. The Excel **Paste Special** dialog box does not appear. Instead, the following Windows **Paste Special** dialog box appears:

   ![cannot use Paste Special to paste attributes](./media/cannot-paste-attributes/cannot-paste-attributes.png)

Therefore, you cannot select any one of the following options:

- **Formulas**
- **Values**
- **Formats**
- **Comments**

These options appear only in the Excel **Paste Special** dialog box.

## Cause

This behavior occurs because Excel cannot use its internal copying functionality when you run multiple instances of Excel. Instead, Excel relies on the Windows **Paste Special** dialog box for its copying functionality. When you run a single instance of Excel, Excel uses its internal copying functionality. Therefore, the Excel **Paste Special** dialog box is available in this situation.  

## Workaround

To work around this behavior, open both workbooks in the same instance of Excel.
