---
title: DQS Export to 64-bit Excel file fails with error
description: This article provides a resolution for the problem where File Download Failed, Check that the export destination file does not already exist error occurs. 
ms.date: 01/14/2021
ms.custom: sap:Data Quality Services
ms.reviewer: JasonH, MatthewL
ms.topic: troubleshooting 
---
# SQL Server 2012 DQS Export to 64-bit .xls Excel file fails with error

This article helps you resolve the problem where **File Download Failed, Check that the export destination file does not already exist** error occurs.

_Applies to:_ &nbsp; SQL Server 2012 Business Intelligence, SQL Server 2012 Developer, SQL Server 2012 Enterprise  
_Original KB number:_ &nbsp; 2712972

## Symptoms

When using SQL Server 2012 Data Quality Services, on a computer where Microsoft Excel 64-bit is installed, consider the following scenario:

- You use Data Quality Client to run a Cleansing or Matching Data project.

- You complete the necessary steps to reach the final Export page of the data quality project.

- You attempt to Export cleansing results, to Destination Type *Excel File*.

  - You click the browse button to specify an existing Excel file to export to.
  - You specify the export file type as `Excel 97-2003 Workbook (*.xls)` and point to a file with the .xls extension.
  - You click the **Open** button to choose the destination file.

- You click the **Export** button to run the export action.

An error appears:

> File Download Failed, Check that the export destination file does not already exist.

## Cause

In this scenario exporting to the Excel 2003-2007 file type *.xls fails, which is a bug.

DQS should be able to export to *.xls when Microsoft Excel 64-bit is installed without error.

## Resolution

Service pack information for SQL Server 2012

To resolve this problem, obtain the latest service pack for SQL Server 2012. For more information, see [KB2755533 - How to obtain the latest service pack for SQL Server 2012](https://support.microsoft.com/help/2755533).

You can now browse and specify the export file that has *.xls extension and run the Export action without the error, when Excel 64-bit is installed on the computer.

## More information

When using 64-bit Microsoft Excel 2007 or 2010 on the computer where Data Quality Client is installed, you can export only to the backward compatible Excel 2003-2007 *.xls file format, or choose another Destination Type such as SQL Server or CSV (a comma-delimited text file).

It is expected behavior that SQL Server 2012 Data Quality Client cannot export data projects to the newer *.xlsx file format when the Microsoft Excel version installed is 64-bit. This is by design.

When using 32-bit Microsoft Excel 2007 or 2010 on the computer where Data Quality Client is installed, you may export to \*.xlsx*.xls, or choose another Destination Type such as SQL Server or CSV.

- [Cleanse Data Using DQS (Internal) Knowledge](/previous-versions/sql/sql-server-2012/hh213061(v=sql.110))

- [Run a Matching Project](/previous-versions/sql/sql-server-2012/hh270289(v=sql.110))

To view the version of Excel and detect if it is 64-bit or 32-bit.

- In Excel 2007

  Click the **circular Office** button in the upper left. Choose the options button, view the references page. View the about section.

- In Excel 2010

  Click the **File** tab on the ribbon, Click the **Help** page, and note the version on the right pane under the heading About Microsoft Excel.

  The version number and architecture will be listed, such as (32-bit) or (64-bit).
