---
title: All dates from the source data are imported when running integration
description: When you run an Integration in Integration Manager it imports in all dates from the source data instead of just the date range that you want. Provides a resolution.
ms.reviewer: theley, dlanglie
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# All dates from source data are imported instead of wanted date range when running an integration in Integration Manager

This article provides a resolution for the issue that the date range isn't imported correctly when you run an integration in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2012466

## Symptoms

When you run your integration in Integration Manager for Microsoft Dynamics GP, the integration brings in all the data in source document. However, you only want the integration to bring in a specified date range from the source data and you want the range to be determined by the user at run time.

## Cause

By default, Integration Manager will read in the entire dataset that is defined in the source queries. You can set up row restrictions in the source queries. However, these are static row restrictions that are defined while you design the integration.

## Resolution

To set up row restrictions that are determined by the user at run time, you have to set up two Visual Basic (VB) scripts to do this. A Before Integration script is needed for the input boxes so that the user can specify the wanted date range when the integration is run. The values from the input boxes are stored as Global variables that are later retrieved in a second script in the Before Query event.

## More information

The following is the Before Integration script that prompts the user for the cutoff dates and set the Global variables. This script also checks to verify that valid dates were entered and that the ending date is equal to or greater than the beginning date.

### Code example 1

```vb
'Before Integration Script

dDocDate = InputBox("Please enter the Beginning cutoff date (mm/dd/yyyy).")

If Not IsDate(dDocDate) then
  MsgBox("You have not entered a valid date. Please start the integration again.")
  CancelIntegration "Invalid date entered."
End If

SetVariable "dDocDate",dDocDate

dDocDateEnd = InputBox("Please enter the Ending cutoff date (mm/dd/yyyy).")

If Not IsDate(dDocDateEnd) then
  MsgBox("You have not entered a valid date. Please start the integration again.")
  CancelIntegration "Invalid date entered."
End If

SetVariable "dDocDateEnd",dDocDateEnd

If CDate(dDocDate) > CDate(dDocDateEnd) Then
  MsgBox("The Beginning cutoff date must be prior to or the same as the Ending cutoff date.")
  CancelIntegration "Invalid Document cutoff dates."
End If
```

The following is the Before Query script that must be used in the Header query of the integration. In this case, the date field being filtered on in this query is named *TrxDate*.

### Code example 2

```vb
'Before Query Script
'Note, replace TrxDate with the date source field in your Integration Source File.
Query.AdditionalCriteria = "TrxDate >= '" & CDate(GetVariable("dDocDate")) & "' AND TrxDate <= '" & CDate(GetVariable("dDocDateEnd")) & "'"
```

> [!NOTE]
> The datatype for the date field your query setup must be set to Date. Also, because this script uses the `AdditionalCriteria` property, it will only work with Text File or Simple ODBC queries. Advanced ODBC queries in Integration Manager cannot use the `AdditionalCriteria` property.
