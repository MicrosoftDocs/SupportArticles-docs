---
title: Power View sheet is not displayed in a workbook
description: Works around an issue in which a graphic is displayed instead of a Power View sheet in an Excel workbook. This issue occurs when you open the workbook in Excel 2013.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer: Jenl 
appliesto:
- Excel 2013
---

# Power View sheet is not displayed in a workbook when you open the workbook in Excel 2013

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

Consider the following scenario:

- You insert a Power View sheet that provides interactive reports for data models into a Microsoft Excel workbook.   
- You save and close the workbook.   
- You open the workbook in Microsoft Excel 2013.   

In this scenario, a graphic is displayed instead of the Power View sheet in the workbook. 

##  Workaround

To work around this issue, disable hardware acceleration for Microsoft Office applications. To do this, follow these steps:


1. On the **File** tab in Excel 2013, click **Options**.   
2. In the **Excel Options** dialog box, click the **Advanced** tab.   
3. Under the **Display** heading, select **Disable hardware graphics acceleration**.   
4. Click **OK**.   

## More Information

The graphic that is displayed in the workbook is a generic graphic that is displayed when Excel cannot build a Power View sheet. To identify whether you are experiencing the issue that is described in this article, add another Power View sheet to the workbook. If both Power View sheets are displayed, you are experiencing the issue that is described in this article.

## Status

This is a confirmed issue in the Power View add-in for Excel for some computer configurations. Microsoft is currently investigating this issue.