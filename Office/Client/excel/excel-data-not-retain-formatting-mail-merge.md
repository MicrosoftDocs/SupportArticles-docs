---
title: Excel data doesn't retain formatting in mail merge
description: This article provides two resolutions for the problem where data in an Excel worksheet does not retain its formatting, such as in currency values and percentages, when you perform a mail merge in Word.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Office Products
- Microsoft Word
- Excel 2016
- Excel 2013
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 03/31/2022
---
# Excel data doesn't retain its formatting in mail merge operations in Word

If you perform a mail merge in Microsoft Word and you use a Microsoft Excel worksheet as the data source for the recipient list, some of the numeric data may not retain its formatting when it is merged.

This behavior applies to formatted percentages, currency values, and postal codes, as shown in the following table:

|Format |In Excel data |In Word MergeField|
|-|-|-|
|Percentage| 50% |.5|
|Currency |$12.50 |12.5|
|Postal Code |07865| 7895|

## Cause

This behavior occurs because the data in the recipient list in Word appears in the native format in which Excel stores it, without the formatting that is applied to the worksheet cells that hold the data.

## Resolution

To resolve this behavior, use one of the following methods.

### Method 1

Use Dynamic Data Exchange (DDE) to connect to the Excel worksheet that contains the data that you want to use.

1. Start Word, and then open a new blank document.
2. Select **File** > **Options**.
3. On the **Advanced** tab, go to the **General** section.
4. Select the **Confirm file format conversion on open** check box, and then select **OK**.
5. On the **Mailings** tab, select **Start Mail Merge**, and then select **Step By Step Mail Merge Wizard**.
6. In the **Mail Merge** task pane, select the type of document that you want to work on, and then select **Next**.
7. Under **Select starting document**, select the starting document that you want to use, and then select **Next**.
8. Under **Select recipients**, select **Use an existing list**, and then select **Browse**.
9. In the **Select Data Source** dialog box, locate the folder that contains the Excel workbook that you want to use as your data source, select **workbook**, and then select **Open**.
10. In the **Confirm Data Source** dialog box, select to select the **Show all** check box. select **MS Excel Worksheets via DDE (*.xls)**, and then select **OK**.
11. In the **Microsoft Excel** dialog box, under **Named or cell range**, select the cell range or worksheet that contains the data that you want to use, and then select **OK**.

> [!NOTE]
> Your data now appears in the Mail Merge Recipients dialog box with the same formatting that appears in the Excel worksheet.

### Method 2

Format the Excel field that contains the ZIP Code/Postal Code as text.

1. In Excel, select the column that contains the ZIP Code/Postal Code field.
2. On the **Home** tab, go to the **Cells** group. Then, select **Format**, and then select **Format Cells**.
3. Select **Number** tab.
4. Under **Category**, select **Text**, and then select **OK**.
5. Save the data source. Then, continue with the mail merge operation in Word.

## References

[Date, Phone Number, and Currency fields are merged incorrectly when you use an Access or Excel data source in Word](https://support.microsoft.com/help/304387)
