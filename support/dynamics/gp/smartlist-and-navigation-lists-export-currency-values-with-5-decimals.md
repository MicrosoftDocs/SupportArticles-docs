---
title: Smartlist and Navigation Lists export currency values with five decimals
description: Smartlist and Navigation Lists export currency values with five decimals in Excel using Microsoft Dynamics GP 2013.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Smartlist and Navigation Lists export currency values with five decimals in Excel using Microsoft Dynamics GP

This article provides methods to solve the issue that Smartlist and Navigation Lists export currency values with five decimals in Excel by using Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2881746

## Symptoms

Smartlist, SmartList Designer, Excel Builder, and Navigation Lists export currency values with five decimals in Excel using Microsoft Dynamics GP 2013 and greater versions.

## Cause

In Microsoft Dynamics GP 2013, the way data is exported from Smartlist and Navigation Lists to Excel has been changed. You'll notice that amount columns are populated with five decimals in Excel and the formatting shown in the Smartlist appears to have been lost during the export. This behavior is by design in Microsoft Dynamics GP 2013. This change was made to increase the performance of exporting data to Excel from Smartlist, and also to allow for exports through Smartlist from the Web Client. The code was changed from COM to OpenXML SDK, and to export the full five decimals directly from the SQL tables to ensure there's no data loss. This approach is safer than truncating the data to two decimals, and allows the user to format the field how they want in Excel. This change is by design to improve performance and prevent data loss.

## Resolution

In Microsoft Dynamics GP 2013 and later versions, you'll have to use one of the methods below to format the data:

### Method 1 - Format in Excel each time

Format the currency field directly in Excel to two decimals:

1. Open Smartlist and export the data to Excel.
2. In the excel spreadsheet, right-click on column heading for the column you wish to format, and select Format Cells...
3. In the format cells window, select **Currency** and set the Decimal places to 2.
4. Choose if you want a Symbol displayed or not, and how you want negative numbers to appear. Select **OK**.
5. Save the spreadsheet.

### Method 2 - Use Export Solutions in Smartlist

Create a formatted spreadsheet in Excel and use Export Solutions in Smartlist to reuse the same spreadsheet as a template to export to:

1. Open Smartlist and export the data to Excel.
2. In the excel spreadsheet, right-click on column heading for the column you wish to format, and select Format Cells...
3. In the format cells window, select **Currency** and set the Decimal places to 2.
4. Choose if you want a Symbol displayed or not, and how you want negative numbers to appear. Select **OK**.
5. Enter a file name and location to save it to. Select **Save**.
6. Open the saved file again in Excel. (It should be listed under **File** > **Recent**). The line numbers are listed in the left-most column. Right above the '1' for line 1, you'll see a blank cell. Right-click on this blank cell and choose **Clear Contents**. This option should clear all the data from the spreadsheet. Close the spreadsheet and save your changes to create a blank template or worksheet.

7. Now in Microsoft Dynamics GP, set up the export to use the formatted spreadsheet:

    1. Select Microsoft Dynamics GP and select **Smartlist**.
    2. In the top menu-bar, select **Smartlist** and select **Export Solutions**.
    3. Key in a Name in the Name filed in the upper right side of the window.
    4. In the **Document** field, browse out to the formatted spreadsheet you created.
    5. Change the **Application** field to **Excel**.
    6. In the Works for Favorites section, expand what Smartlist and mark the checkbox to the left of that Smartlist(s) you want to use with the saved spreadsheet. You can mark as many of favorites that you want to use this formatted spreadsheet.
    7. Select **Save**. Exit out of the Export Solutions window.
    8. Refresh the Smartlist window.
    9. Select the Smartlist. And you should now see a drop-down arrow under the **EXCEL** button, where you can select to use the formatted spreadsheet you made (or the Quick export will be the old way showing all five decimals.)
    10. Select the name of the formatted spreadsheet you created. And the data will export to Excel, where the currency column will now be formatted to two decimals.
    11. Select **FILE** > **SAVE AS** and save the spreadsheet under a new name, to leave your template empty.

   > [!NOTE]
   > Create as many formatted spreadsheets as you need and use Export Solutions to link them to the appropriate Smartlist.
