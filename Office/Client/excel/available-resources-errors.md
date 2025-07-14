---
title: How to troubleshoot available resources errors in Excel
description: Provides methods to resolve memory errors in Microsoft Excel.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - Reliability
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Excel for Microsoft 365
  - Excel 2019
  - Excel 2016
  - Excel 2013
  - Excel 2010
  - Excel 2007
ms.date: 05/26/2025
---

# How to troubleshoot "available resources" errors in Excel

## Symptoms

When you work with a Microsoft Excel file, you receive one of the following messages:

- Excel cannot complete this task with available resources. Choose less data or close other applications.
- Out of Memory
- Not enough System Resources to Display Completely
- There isn't enough memory to complete this action. Try using less data or closing other applications. To increase memory availability, consider:
  - Using a 64-bit version of Microsoft Excel.
  - Adding memory to your device.

## Cause

The above memory error messages can be generic and don't always identify the real cause of the issue. However, if your file is large or contains a large number of features, it's possible you're running low on available memory resources.

Before we explore the more common reasons for the memory errors, it good to understand Excel's limitations. For more information, see the following resources:

- [Excel specifications and limits](https://support.office.com/article/excel-specifications-and-limits-ca36e2dc-1f09-4620-b726-67c00b05040f)
- [Excel 2010 Performance: Performance and Limit Improvements](https://msdn.microsoft.com/library/office/ff700514.aspx)
- [Memory usage in the 32-bit edition of Excel 2013 and 2016](https://support.microsoft.com/help/3066990)

If you aren't hitting a resource limitation, these are the most common resolutions.

## Resolution

Follow the provided methods in this article to resolve the available resource error message in Excel. If you have previously tried one of these methods and it didn't help, go to another method from this list:

### Method 1: Contents of the spreadsheet

The first thing to determine is if the error is specific to one workbook (or others created from the same template). Typical actions that cause memory error messages are:

- Inserting a row or column
- Sorting
- Performing calculations
- Copy and pasting
- Opening or closing the workbook
- Running VBA

If you're seeing the error when performing any of the above actions, it's time to look to determine what's going on in your file. These are addressed in the sections below.

**Calculations**

If you're inserting rows and columns, performing calculations, or copying and pasting and receive the message, it can be tied to formulas having to recalculate.

Consider this scenario:

You have a spreadsheet with 1 million formulas on a sheet and you insert a new column. This forces Excel to recalculate all the formulas in the spreadsheet adjusting for the new column that you inserted. It's possible, depending on the complexity of your spreadsheet, bitness of Excel, and how the spreadsheet is built, and what formulas are used, that you receive the out of resources error.

The following articles address how to optimize performance with calculations:

- [Excel 2010 Performance: Tips for Optimizing Performance Obstructions](/previous-versions/office/developer/office-2010/ff726673(v=office.14))
- [Excel 2010 Performance: Improving Calculation Performance](/previous-versions/office/developer/office-2010/ff700515(v=office.14))

**Other Spreadsheet Elements**

Other areas that can cause the memory issues are excess shapes, complex PivotTables, macros, and complex charts with many data points. The following article walks through identifying and fixing these issues.

[Top 10 List of Performance Issues in Excel Workbooks](https://blogs.technet.com/b/the_microsoft_excel_support_team_blog/archive/2012/12/18/top-10-list-of-performance-issues-in-excel-workbooks.aspx)

#### Custom Views in a Shared Workbook

If you're using the feature Shared Workbook (Review Ribbon > Share Workbook), cleaning out the Custom Views might help with available memory. To do this:

1. On the **View Ribbon**
2. **Custom Views** on the dialog choose **Delete**

Deleting Custom Views doesn't delete anything in the spreadsheet, it does delete the print areas, and filters. These can easily be reapplied.

If your issue isn't resolved after you clean up the file, go to method 2.

### Method 2: Verify/install the latest updates

You might have to set Windows Update to automatically download and install recommended updates. Installing any important, recommended, and optional updates can frequently correct problems by replacing out-of-date files and fixing vulnerabilities. To install the latest Office updates, click the link specific to your version of Windows and follow the steps in that article.

**Operating system updates:**

[Install Windows updates](https://support.microsoft.com/help/12373)

**Office updates:**

For more information about Office updates, see [Office downloads & updates](/officeupdates/).

If your issue isn't resolved after you install the updates, go to method 3.  

### Method 3: Add-ins interfering

Check the Add-ins that are running, and try disabling them to see if Excel is working properly. Follow the directions in the following article to disable the add-ins.

[View, manage, and install add-ins in Office programs](https://support.office.com/article/view-manage-and-install-add-ins-in-office-programs-16278816-1948-4028-91e5-76dca5380f8d)

If you find that Excel is no longer giving you the error after you remove the add-ins, then it's recommended to contact the manufacturer of the add-in for support.

If your issue isn't resolved after you remove the add-ins, go to method 4.
  
### Method 4: Test disabling Preview/Details Pane in Windows 7

If you're running Windows 7, try disabling the preview and details panes in Windows. You'll have to disable them in three locations.  

Windows Explorer:

1. Right-click the Start button.
1. Click Open Windows Explorer.
1. Click Organize | Layout.
1. Uncheck Details Pane and Preview Pane.

Excel:

1. Click File | Open.
1. Click Organize | Layout.
1. Uncheck Details Pane and Preview Pane Outlook.
1. Open a new e-mail.
1. In the "Include" group on the Ribbon, click Attach File.
1. Click Organize | Layout.
1. Uncheck Details Pane and Preview Pane.

If your issue isn't resolved after you turn off preview and details panes, go to method 5.

### Method 5: Test a different Default Printer

When Excel launches, it uses the default printer to help render the file. Try testing with the "Microsoft XPS Document Writer" as the default printer and see if we continue to get the error. To do so, follow these steps:

1. Close Excel.
2. Open the printer and faxes window (XP) or Devices and Printers (Vista, 7, 8, 10).
3. Right-click the "Microsoft XPS Document Writer" printer.
4. Click Set as Default.

If your issue isn't resolved after you change your default printer, go to method 6.

### Method 6: Test without Antivirus

Antivirus can sometimes cause problems by continuously trying to scan the Excel file or something in the file. Many times the memory error will be random and will be found with any spreadsheet. Test this by shutting off the antivirus temporarily, or by not having Excel files scanned. In some cases, the AV will need to be removed.  

If your issue is not resolved after you turn off antivirus, go to method 7.

### Method 7: Test with 64-bit version of Excel

Working with large Excel files can use the memory available to the 32-bit Excel application. In any 32-bit application, there's a 2-GB limitation.

If your processes need to use more than 2 GB's, then you need to carefully consider moving to Microsoft Excel 64-bit version. The 64-bit version allows all available physical RAM on the machine to be used. If you're interested in researching 64-bit versions, see [64-bit editions of Office 2013](https://technet.microsoft.com/library/ee681792.aspx).

If your issue isn't resolved after testing on 64 bit, go to method 8.

### Method 8: Other applications are consuming the computer's memory and not enough is being allocated to Excel

Does the message clear up for some time after you reboot or shut off some of your applications? That's probably a good sign this is your issue, follow the steps to shut down some of the extra applications running on your computer.

[How to perform a clean boot in Windows](https://support.microsoft.com/help/929135)

## More Information

Additional article

[Excel cannot complete this task with available resources error, Excel 2010](https://support.microsoft.com/help/2655178)

If the information in this article didn't help resolve the error in Excel, select one of the following options:  

- More Microsoft online articles:
 [Perform a search to find more online articles about this specific error](https://support.microsoft.com/)
- Help from the Microsoft Community online:
 [Visit the Microsoft Community and post your question about this error](https://answers.microsoft.com/)
- Contact Microsoft support:
 [Find the phone number to contact Microsoft Support](https://support.microsoft.com/contactus/)
