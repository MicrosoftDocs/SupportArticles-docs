---
title: Object reference not set to an instance of an object error when creating a report in Microsoft Management Reporter 2012
description: Describes an error you may receive when you generate a report in Microsoft Management Reporter 2012. Provides resolutions.
ms.reviewer: theley, gbyer
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Object reference not set to an instance of an object" error when you generate a report in Microsoft Management Reporter 2012

This article provides resolutions for the **Object reference not set to an instance of an object** error that occurs when you create a report in Microsoft Management Reporter 2012.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 2976908

## Symptoms

When you generate a report using Microsoft Management Reporter 2012 (MR 2012), you receive the following error message:

> Object reference not set to an instance of an object

To troubleshoot Management Reporter 2012 report problems, go to the Windows Event Viewer to get additional information on the error. The Event Viewer can be found in Control Panel, under **Administrative Tools**. In Event Viewer, select **Windows Logs** and then select **Application**. Under the Source column look for Management Reporter Report Designer or Management Reporter 2012 Services. Client errors can be found at the workstation and MR Service errors can be found at the MR server. You may need to check the Event Viewer in one or both places.

Here is a list of errors received when the report error occurs and the possible associated error(s) in Event Viewer. Find your error in the list and use the appropriate Cause\Resolution sections.

Event Viewer messages:

> Microsoft.Dynamics.Performance.Reporting.Engine.Server.WorksheetLinkAdapter.PopulateReportCellFromWorksheet(String workSheetName, ExcelWorkbook workBook, RowCriterion reportRowCriteria, ValueColumn reportValueColumn, WorksheetModifierType offset)

See Cause 1.

> Microsoft.Dynamics.Performance.Reporting.Engine.Server.ReportCalculator.ColumnCalculateOneRowAllColumns(ValueRow rowDetail)

See Cause 2.

## Cause 1

The Excel link in the row definition has an incorrect reference. See Resolution 1.

## Cause 2

Summary level of tree has a mask in the Dimension column. See Resolution 2.

## Resolution 1

In the row definition, check the Excel links and verify they are not referencing a CALC column. For example, the row definition has a reference of @WKS(B=B2, C=C2). In the column definition, column C is a formatted as a CALC column. Excel data cannot be placed in a CALC column.

## Resolution 2

In the tree definition, remove any dimension restrictions from the Dimension column, at the summary level.
