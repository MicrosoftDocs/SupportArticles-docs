---
title: Differences between the 1900 and the 1904 date system
description: Provides the description of the differences between the 1900 date system and the 1904 date system in Excel. Discusses the problems that you may experience when you use these two different date systems in Excel workbooks.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: mikestow
search.appverid: 
  - MET150
appliesto: 
  - Excel 2019
  - Excel 2016
  - Excel 2013
  - Excel 2010
  - Office Excel 2007
  - Excel for Macintosh
ms.date: 03/31/2022
---

# Differences between the 1900 and the 1904 date system in Excel

## Summary

Microsoft Excel supports two different date systems. These systems are the 1900 date system and the 1904 date system. This article describes the two date systems and the problems that you may encounter when you use workbooks that use different date systems.

## More Information

### The 1900 Date System

In the 1900 date system, the first day that is supported is January 1, 1900. When you enter a date, the date is converted into a serial number that represents the number of elapsed days starting with 1 for January 1, 1900. For example, if you enter July 5, 1998, Excel converts the date to the serial number 35981.

By default, Microsoft Excel for Windows uses the 1900 date system. The 1900 date system enables better compatibility between Excel and other spreadsheet programs, such as Lotus 1-2-3, that are designed to run under MS-DOS or Microsoft Windows.

### The 1904 Date System

In the 1904 date system, the first day that is supported is January 1, 1904. When you enter a date, the date is converted into a serial number that represents the number of elapsed days since January 1, 1904, starting with 0 for January 1, 1904. For example, if you enter July 5, 1998, Excel converts the date to the serial number 34519.

Because of the design of early Macintosh computers, dates before January 1, 1904, were not supported. This design was intended to prevent problems related to the fact that 1900 was not a leap year. In the past, Excel for Macintosh defaulted to using the 1904 date system for workbooks originating on a Macintosh. However, Excel for  Macintosh now defaults to the 1900 date system and supports dates as early as January 1, 1900.

> [!note]
> For more information, see [Excel incorrectly assumes that the year 1900 is a leap year](wrongly-assumes-1900-is-leap-year.md).

### The Difference Between the Date Systems

Because the two date systems use different starting days, the same date is represented by different serial numbers in each date system. For example, July 5, 1998 can have two different serial numbers, as follows.

|Date system|Serial number of July 5, 1998|
|----|---|
|1900 date system| 35981|
|1904 date system| 34519|

The difference between the two date systems is 1,462 days; that is, the serial number of a date in the 1900 Date System is always 1,462 days bigger than the serial number of the same date in the 1904 date system. 1,462 days is equal to four years and one day (including one leap day).

### Setting the Date System for a Workbook

In Excel, each workbook can have its own date system setting, even if multiple workbooks are open.

To set the date system for a workbook in Microsoft Office Excel 2003 and in earlier versions of Excel, follow these steps:

1. Open or switch to the workbook.
2. On the **Tools** menu, click **Options**. In Excel X and later versions for Macintosh, click **Preferences** on the **Excel** menu.
3. Click the **Calculation** tab.
4. To use the 1900 date system in the workbook, click to clear the **1904 date system** check box. To use the 1904 date system in the workbook, click to select the **1904 date system** check box.
5. Click **OK**.

To set the date system for a workbook in Microsoft Office Excel 2007, follow these steps:

1. Open or switch to the workbook.
2. Click the **Microsoft Office Button**, and then click **Excel Options**.
3. Click **Advanced**.
4. Click to select the **Use 1904 data system** check box under the **When calculating this workbook**, and then click **OK**.

Notice that if you change the date system for a workbook that already contains dates, the dates shift by four years and one day. For information about how to correct shifted dates, see the "Correcting Shifted Dates" section.

### Problems Linking and Copying Dates Between Workbooks

If two workbooks use different date systems, you may encounter problems when you link or copy dates between workbooks. Specifically, the dates may be shifted by four years and one day.

To see an example of this behavior, follow these steps:

1. In Excel, create two new workbooks (Book1 and Book2).
2. Follow the steps in the "Setting the Date System for a Workbook" section to use the 1900 date system in Book 1. Use the 1904 date system in Book2.
3. In Book1, enter the date July 5, 1998.
4. Select the cell that contains the date, and then click **Copy** on the **Edit** menu.

   **Note** In Excel 2007, select the cell that contains the date, and then click **Copy** in the **Clipboard** group on the **Home** tab.
5. Switch to Book2, select a cell, and then click **Paste** on the **Edit** menu.

   **Note** In Excel 2007, switch to Book2, select a cell, and then click **Paste** in the **Clipboard** group on the **Home** tab.

   The date is pasted as July 6, 2002. Notice that the date is four years and one day later than the date in step 3 because Book2 uses the 1904 date system.
6. In Book2, type the date July 5, 1998. Select the cell that contains the date and then click **Copy** on the **Edit** menu.

   **Note** In Excel 2007, type the date July 5, 1998 in Book2. Select the cell that contains the date, and then click **Copy** in the **Clipboard** group on the **Home** tab.
7. Switch to Book1, select a cell, and then click **Paste** on the **Edit** menu.

   **Note** In Excel 2007, switch to Book1, select a cell, and then click **Paste** in the **Clipboard** group on the **Home** tab.

   The date is pasted as July 4, 1994. It has been shifted down by four years and one day because Book1 uses the 1900 date system.

### Correcting Shifted Dates

If you link from or copy dates between workbooks, or if you change the date system for a workbook that already contains dates, the dates may be shifted by four years and one day. You can correct shifted dates by following these steps:

1. In an empty cell, enter the value 1462.
2. Select the cell. On the **Edit** menu, click **Copy**.

   **Note** In Excel 2007, select the cell, and then click **Copy** in the **Clipboard** group on the **Home** tab.
3. Select the cells that contain the shifted dates. On the **Edit** menu, click **Paste Special**.

   **Note** In Excel 2007, select the cells that contain the shifted dates, click **Paste** in the **Clipboard** group on the **Home** tab, and then click **Paste Special**.
4. In the **Paste Special** dialog box, click to select the **Values** check box under **Paste**, and then click to select either of the following check boxes under **Operation**.

    |Select this| If|
    |---|---|
    |Add| The dates must be shifted up by four years and one day.|
    |Subtract |The dates must be shifted down by four years and one day.|

5. Click **OK**.

Repeat these steps until all the shifted dates have been corrected.

If you are using a formula to link to a date in another workbook, and if the date returned by the formula is incorrect because the workbooks use different date systems, modify the formula to return the correct date. For example, use the following formulas:

```excel
=[Book2]Sheet1!$A$1+1462

=[Book1]Sheet1!$A$1-1462
```

In these formulas, 1,462 is added or deleted from the date value.
