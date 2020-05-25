---
title: An unexpected value returned when using the DAYS360 function in Excel
description: Describes a behavior in which an unexpected number of days is returned by the DAYS360 function in Microsoft Excel. Provides a workaround.
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
- Excel 2003
- Excel 2002
- Excel 97
---

# An unexpected value is returned when you use the DAYS360 function in Excel

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you use the DAYS360 function to calculate the number of days between two dates, an unexpected value is returned. For example, when you use the DAYS360 function with a start date of February 28 and with an end date of March 28, a value of 28 days is returned. You expect a value of 30 days to be returned for every full month.

## Cause

This behavior may occur if you use the U.S. method, also known as the NASD method, with the DAYS360 function.

> [!NOTE]
> By default, the U.S. method is used in the DAYS360 function. If you do not specify a method, the default method is used.

## Workaround

To work around this behavior, use the European method with the DAYS360 function. To use the European method with the DAYS360 function, use the following syntax:

=DAYS360(**cell number of start date**,**cell number of end date**,TRUE)

## More Information

### Steps to reproduce the behavior

1. In cell A1, type 2/28/2006, and then press ENTER.
2. In cell A2, type 3/28/2006, and then press ENTER.
3. In cell A3, type =DAYS360(A1,A2), and then press ENTER.

Results: A value of 28 is returned in cell A3.

## References

For more information about the DAYS360 function in Microsoft Office Excel 2003, click **Microsoft Excel Help** on the **Help** menu, type DAYS360 in the **Search for** box in the Assistance pane, and then click **Start searching** to view the topic.

For more information about the DAYS360 function in Microsoft Excel 2002 or in Microsoft Excel 2000, click **Microsoft Excel Help** on the **Help** menu, type DAYS360 in the Office Assistant or the Answer Wizard, and then click **Search** to view the topic.

For more information about the DAYS360 function in Microsoft Excel 97, click the **Index** tab in **Microsoft Excel Help**, type DAYS360, and then double-click the selected text to view the "DAYS360 worksheet function" topic.