---
title: Parts of Excel 2013 turn white or gray
description: Describes an issue in which the screen flickers or appears completely white in Excel 2013. This issue occurs when you run VBA code that performs a specific action such as inserting a new worksheet or creating a new workbook.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: xl15beta, anitao, jenl, anatolyg
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
ms.date: 03/31/2022
---

# Parts of Excel turn white or gray when you run VBA code in Excel 2013

## Symptoms

When you run Microsoft Visual Basic for Applications (VBA) code in Microsoft Excel 2013, portions of Excel may appear white or gray, depending on your Office Theme. It stays blank until the code completes. This issue may occur if the VBA code performs one or more of the following actions in a macro that runs long enough for the user to see the results before the macro completes:

- Repeatedly select cells   
- Insert sheets   
- Update or opens task panes   
- Add a workbook   

## Cause

This issue is caused by the changes that are made in Microsoft Office 2013 to optimize the new graphics engine.

## Workaround

1. Use ScreenUpdatingto disable the screen updates of Excel so you do not see the changes while they are disabled. This also may improve your macro performance.

    ```vb
    Application.ScreenUpdating = False
    Workooks.Add
    Application.ScreenUpdating = True
    ```

2. If you need to see the screen changes, insert a DoEvents command after the line in the code that causes the screen to appear white. Using DoEvents sparingly will help maintain macro performance.

    ```vb
    Workbooks.Add
    DoEvents
    ```

## Status

This is a known limitation in Excel 2013.

> [!NOTE]
> For all versions of Excel, a similar effect can occur in long running macros when Windows turns the application white and marks it not responding. This occurs because Excel is not responding to Windows while the macro is running. DoEvents will also assist in this scenario by allowing Excel to respond to Windows and allow the application screen to recover.
