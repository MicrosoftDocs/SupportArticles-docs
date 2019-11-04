---
title: Create a formula to correctly evaluate blank cells
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

# Create a formula to correctly evaluate blank cells in Excel

## Summary

In Microsoft Excel, when you use a formula that tests for a zero value, you may see unexpected results if the cell is blank. Microsoft Excel interprets a blank cell as zero, and not as empty or blank. Therefore, any cells that are blank are evaluated as zero in the function.

## More information

If you are checking a cell for a zero value and the cell is blank, the test evaluates to true. For example, if you have the following formula in cell A1:

```excel
=IF(B1=0,"zero","blank")
```

and B1 is blank, the formula returns "zero" and not "blank" as expected.

If the range might contain a blank cell, you should use the ISBLANK function to test for a zero value, as in the following example:

```excel
=IF(ISBLANK(B2),"blank",IF(B2=0,"zero","other"))
```

> [!NOTE]
> The above formula returns "zero" if there is a zero value in the cell, "blank" if the cell is blank, and "other" if anything else is in the cell.

You must always use the ISBLANK formula first before you test for a zero value. Otherwise you will always return a "true" for the zero value, and never get to the test for the ISBLANK formula.
