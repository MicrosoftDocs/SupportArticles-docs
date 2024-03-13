---
title: Error during Canadian Payroll Employee Import
description: Provides a solution to an error during Canadian Payroll Employee Import.
ms.topic: troubleshooting
ms.reviewer: cwaswick
ms.date: 03/13/2024
---
# Error during Canadian Payroll Employee Import: "Employee Exceeds available size. - Import Aborted."

This article provides a solution to an error that occurs when you import in the Canadian Payroll Employee Master file.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3123520

## Symptoms

When importing in the Canadian Payroll Employee Master file, this error occurs:

> Employee Exceeds available size. - Import Aborted.
>
> Employee Exceeds available size. - Import Aborted.  
Address 1 Exceeds set size allowed. \<EmployeeID>

## Cause

Various causes. See the [Resolution](#resolution) section.

## Resolution

There can be several different causes for the message above, so review these troubleshooting steps:

Method 1 - TEMPLATE: Export the same data you are trying to import in, and use that export file as your template. Copy and paste the data in to this file and try to reimport the file back in.

1. Verify that the @ symbol is in the correct column for each import file.*

2. Both .csv and .tab files should be acceptable. However, if you are using .tab, try to import it in as .csv. (Use the template you exported above.)

3. Verify that the fields in the import file are not longer than the size of the field in GP. If you get the "Address 1 Exceeds set size allowed. \<EmployeeID>" error, there is an issue with the address field where the size of the field was increased from 30 to 60 characters in GP, however, the change was not made to the import utility, so the import file must still only have 30 characters for the address field.

Method 2 - BLANK LINES: Make sure that you do NOT have any lines without data in them between the 'A' in column A and the @ symbol in the last column of the import. (You can have blank columns here and there, but if the whole row is blank between A and @, it can cause an issue.) This is commonly seen if you have extra lines at the bottom of the import file.

Method 3 - DUPLICATES: Verify that the employee does not have more than one record or duplicated records in the import file. (In Excel, you can highlight duplicated employee IDs in red by selecting the column and then click **Conditional Formatting** and select **Highlight Cells Rules** and select **Duplicate Values...** which will make the duplicates in red font and you can delete the line that you don't want to keep.)

Method 4 - DATE FORMAT: The date on the Emp.csv file MUST be YYYY/MM/DD. (Note: If you open the file in Excel, it will get automatically formatted in Excel to be MM/DD/YYYY, which is incorrect. Under the **Format Cells** in Excel, set the **Date** to be YYYY/MM/DD which can be found under the Locale 'Tibetan (PRC)'.) The date will get reformatted every time you open the file in Excel, so after changing the date, import it in without opening it. Or you can use Notepad to view the file, as Notepad will not automatically format the date format like Excel does.

## More information

An example of the import files for Canadian Payroll can be found at the end of the PayrollCan.pdf printable manual. To download this, click on the following site and then click on Canadian Payroll to download the document: (This link is for version Microsoft Dynamics GP 2010, but should be the same for later versions.)

[Human resources and payroll guides](/previous-versions/dynamics-gp/appuser-itpro/hh686204(v=gp.20))
