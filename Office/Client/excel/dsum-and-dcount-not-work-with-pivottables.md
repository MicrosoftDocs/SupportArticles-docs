---
title: DSUM and DCOUNT functions do not work with PivotTables
description: Describes the issue in which the DSUM and DCOUNT functions in Excel do not work with PivotTables. These functions return the #VALUE! error when they are calculated.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: ryanwei, mosesma, clatonh, jenl, gquintin
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
  - Excel 2010
ms.date: 05/26/2025
---

# The DSUM and DCOUNT functions in Excel do not work with PivotTables

## Symptoms

Consider the following scenario in Microsoft Excel:

- You create a table that has two or more columns of data on a worksheet.   
- You insert a new PivotTable into the worksheet that is based on the new table's data.   
- You enter a formula by using either of the following database functions:
  - DCOUNT   
  - DSUM   

- You use the PivotTable's cell references for the database parameter of the database function. And, you use the cell reference for the column in the PivotTable for the field parameter of the database function. 

  For example, consider the following scenario. The PivotTable is in cells C10:F20. The targeted column is F10, and this column has the column label of "Total." The database table on which the PivotTable is based is in N1:Q10. The criteria for the function are H2:H12. The DCOUNT function parameters are as follows:

  database= C10:F20

  field= F10 

  criteria= H2:H12

  The function is written as follows: DCOUNT(C10:F20,F10,H2:H12)   
  In this scenario, when the DCOUNT and DSUM functions are calculated, they return the following error: 

    "#VALUE!" 

  And, if you use the column label "Total" for the fieldparameter, the DCOUNT and DSUM functions also return the "#VALUE!" error.

## Cause

This problem occurs because the field parameter of the DCOUNT and DSUM functions cannot use a cell reference or a column label to retrieve data from the database table. When you use the DCOUNT and the DSUM functions on a PivotTable, the field parameter can only use a number to represent the position of the column within the list. For example, the parameter can use 1 for the first column, 2 for the second column, and so on. Do not use quotation marks around the number.

## Workaround

To work around this issue, use either a column label or the column position value to identify the column to use in the field parameter. 

For example, by using the example in the "Symptoms" section, the DCOUNT function can be rewritten as follows:

DCOUNT(C10:F20,4,H2:H12)
