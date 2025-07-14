---
title: Use a logical AND or OR in a SUM+IF statement
description: Describes how to use a logical AND or OR in a SUM+IF statement in Excel.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: SISHAM
ms.custom: 
  - Editing\Formulae
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Excel 2003
  - Microsoft Office Excel 2007
  - Excel 2010
ms.date: 05/26/2025
---

# How to use a logical AND or OR in a SUM+IF statement in Excel

## Summary

In Microsoft Excel, when you use the logical functions AND and/or OR inside a SUM+IF statement to test a range for more than one condition, it may not work as expected. A nested IF statement provides this functionality; however, this article discusses a second, easier method that uses the following formulas.

**For AND Conditions**

```excel
=SUM(IF(Test1*Test2*...*Testn))
```

**For OR Conditions**

```excel
=SUM(IF(Test1+Test2+...+Testn))
```

## More Information

Use a SUM+IF statement to count the number of cells in a range that pass a given test or to sum those values in a range for which corresponding values in another (or the same) range meet the specified criteria. It behaves similarly to the DSUM function in Microsoft Excel.

### Example

This example counts the number of values in the range A1:A10 that fall between 1 and 10, inclusively.

You can use the following nested IF statement:

```excel
=SUM(IF(A1:A10>=1,IF(A1:A10<=10,1,0)))
```

The following method also works and is easier to read if you're conducting multiple tests:

```excel
=SUM(IF((A1:A10>=1)*(A1:A10<=10),1,0))
```

The following method counts the number of dates that fall between two given dates:

```excel
=SUM(IF((A1:A10>=DATEVALUE("1/10/99"))*(A1:A10<=DATEVALUE("2/10/99")),1,0))
```

> [!NOTE]

> - You must enter these formulas as array formulas by pressing CTRL+SHIFT+ENTER simultaneously. On the Macintosh, press COMMAND+RETURN instead.
> - Arrays can't refer to entire columns.

With this method, you're multiplying the results of one logical test by another logical test to return TRUEs and FALSEs to the SUM function. You can equate these to:

```adoc
TRUE*TRUE=1
TRUE*FALSE=0
FALSE*TRUE=0
FALSE*FALSE=0
```

The method shown above counts the number of cells in the range A1:A10 for which both tests evaluate to TRUE. To sum values in corresponding cells (for example, B1:B10), modify the formula as shown below:

```excel
=SUM(IF((A1:A10>=1)*(A1:A10<=10),B1:B10,0))
```

You can implement an OR in a SUM+IF statement similarly. To do so, modify the formula shown above by replacing the multiplication sign (*) with a plus sign (+). It gives the following generic formula:

```excel
=SUM(IF((Test1)+(Test2)+...+(Testn),1,0))
```

## References

For more information about how to calculate a value based on a condition, select Microsoft Excel Help on the Help menu, type about calculating a value based on a condition in the Office Assistant or the Answer Wizard, and then select Search.
