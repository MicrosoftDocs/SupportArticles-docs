---
title: Object Model calls fails from WorkbookOpen event
description: This article provides two resolutions for the problem where Object Model calls may fail with a runtime error 1004 - Method of Object failed.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Excel 2013
- Excel 2016
- Excel 2019
- Excel 2021
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 03/31/2022
---
# Object Model calls may fail from WorkbookOpen event when exiting Protected View

## Symptoms

Consider the following scenario:

- You have an Excel add-in (VBA, COM, or VSTO) that captures the `WorkbookOpen` event and makes Object Model calls into Excel from this event handler.

- You open a Workbook in protected view (because of opening workbook from Internet, email attachment etc.) and select **Enable Editing**.

- Some Object Model calls (for example, Sheet.Activate) being made from the `WorkbookOpen` event handler fail with a runtime error 1004 - Method of Object failed.

## Cause

Clicking on **Enable Editing** transitions the workbook from protected view to normal view. While transitioning, the `WorkbookOpen` event is fired before the protect view workbook is closed, resulting into failure on object model calls.

## Resolution

You can work around the issue by either:

- If the location from where the workbooks are being open is trusted, add that location to the Excel's Trusted Locations.

- Defer Object Model calls to outside of the `WorkbookOpen` event to `WorkbookActivate` event.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More information

Below is a sample VBA code that demonstrates how you could defer Object Model calls to the `WorkbookActivate` event.

```vba
Option Explicit
Public WithEvents oApp As Excel.Application 
Private bDeferredOpen As Boolean 
Private Sub oApp_WorkbookActivate(ByVal Wb As Workbook) 
If bDeferredOpen 
Then bDeferredOpen = False Call WorkbookOpenHandler(Wb) 
End If End Sub 
Private Sub oApp_WorkbookOpen(ByVal Wb As Workbook) 
Dim oProtectedViewWindow As ProtectedViewWindow On Error Resume Next 'The below line will throw error (Subscript out of range) 
if the workbook is not opened in protected view. 
Set oProtectedViewWindow = oApp.ProtectedViewWindows.Item(Wb.Name) On Error GoTo 0 'Reset error handling 
If oProtectedViewWindow Is Nothing 
Then bDeferredOpen = False Call WorkbookOpenHandler(Wb) 
Else 'Delay open actions till the workbook gets activated. bDeferredOpen = True 
End If End Sub 
Private Sub WorkbookOpenHandler(ByVal Wb As Workbook)'The actual workbook open event handler code goes here... 
End Sub
```
