---
title: Change from absolute to relative or mixed references in a formula
description: Explains that you can use the F4 key to toggle from one reference type to another in a formula in Excel.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Excel
---

# How to change from absolute to relative or mixed references in a formula in Excel

## Summary

In Excel, you can create absolute, relative, or mixed references in a formula. You can easily change from one reference type to another without having to retype it by pressing F4. 

## More information

The following is a description of different reference types.

|Type|Example|Description|
|---|---|---|
|Absolute|$A$1|Both the row and column are fixed|
|Mixed|A$1|Only the row is fixed|
|Mixed|$A1|Only the column is fixed|
|Relative|A1|Neither the row or column is fixed|

To toggle from one reference type to another: 

1. Select the cell that contains the reference you want to change.   
2. In the formula bar, select the reference or references that you want to change. 

    Select the whole formula if you want to change all the references.
3. Press F4.

Each time you press F4, Excel cycles through the different types of reference in the order of the table. For example, if you type a relative reference and then press F4, the reference changes to absolute. When you press F4 again, the reference changes to mixed with the row fixed.

## References

For more information about Referencing, click
 **Microsoft Excel Help** on the **Help** menu, type
 References in the Office Assistant or the Answer Wizard, and then click **Search** to view the topic.
