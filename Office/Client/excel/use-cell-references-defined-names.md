---
title: How to use cell references and defined names in criteria in Excel
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Excel
---

# How to use cell references and defined names in criteria in Excel

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

In Microsoft Excel, criteria can be set by typing the exact value that is desired in the criteria cells, or by using cell references or defined names.

To use the value of cell D1 as the criteria, type the following formula in the criteria cell:

**=$D$1**

To use the value of a defined name, such as "CritVar", type the following formula in the criteria cell:

**=CritVar**

To use the operators, such as less than (<) and greater than (>), the operator must be concatenated with the formula. For example, to specify a match of greater than the value in cell D1, type the following formula in the criteria cell:

**=">"&$D$1**

To specify a match of greater than or equal to a cell defined as "GVAR", type the following formula in the criteria cell:

**=">="&GVAR**

## More Information

Quotation marks must be used. Otherwise, Excel interprets the information as "greater than "$D$1"" where "$D$1" is a text string. The same applies for a defined name.