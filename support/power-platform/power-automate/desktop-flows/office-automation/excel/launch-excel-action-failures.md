---
title: Launch Excel Action Failures
description: Solves errors related to the Launch Excel action in Power Automate for desktop.
ms.reviewer: amitrou
ms.author: nimoutzo
author: NikosMoutzourakis
ms.custom: sap:Desktop flows\Office automation
ms.date: 03/03/2025
---
# Error occurs when opening an Excel file in Power Automate for desktop

This article helps solve errors that occur when you try to open a blank or existing Excel file in Power Automate for desktop.

## "Exception from HRESULT: 0x800xxxxx" error

> System.Runtime.InteropServices.COMException: Exception from HRESULT: 0x800xxxxx

### Cause

This error can occur if:

- Office apps (or just Excel) aren't properly installed.
- Power Automate for desktop isn't properly installed.
- The Excel file is synchronized with OneDrive.

### Resolution

- Manually [uninstall](/power-automate/desktop-flows/install#uninstall-power-automate) and [reinstall](/power-automate/desktop-flows/install) Power Automate for desktop. If it doesn't work, ensure you have Excel properly installed.
- To work around the error caused by the synchronization with OneDrive, see [Using Excel files synchronized through OneDrive or SharePoint](/power-automate/desktop-flows/actions-reference/excel#using-excel-files-synchronized-through-onedrive-or-sharepoint).

## "Could not load file or assembly or one of its dependencies" error

> System.IO.FileNotFoundException: Could not load file or assembly 'Microsoft.Office.Interop.Excel' or one of its dependencies. The system cannot find the file specified.

### Cause

The Excel application isn't installed on the machine.

### Resolution

Ensure you have Excel installed on the machine.

## "Access to the path 'C:\YourPath\YourFile.xlsx' is denied" error

> System.UnauthorizedAccessException: Access to the path 'C:\YourPath\YourFile.xlsx' is denied.

### Cause

The document is located in a restricted file path, or Power Automate for desktop doesn't have permission to open and access the document.

### Resolution

Move the file to a directory where Power Automate for desktop has access.

## "The process cannot access the file 'C:\YourPath\YourFile.xlsx'" error

> System.IO.IOException: The process cannot access the file 'C:\YourPath\YourFile.xlsx' because it is being used by another process.

### Cause

The Excel application is locked, and no other process can access it.

### Resolution

Terminate all opened Excel processes and restart Power Automate for desktop.

## "80040154 Class not registered" error

> System.Runtime.InteropServices.COMException: Retrieving the COM class factory for component with CLSID {*ID*} failed due to the following error: 80040154 Class not registered (Exception from HRESULT: 0x80040154 (REGDB_E_CLASSNOTREG)).

### Cause

This issue can occur if you're using an older version of Excel, such as Excel 2013 or earlier.

### Resolution

Ensure you have Excel 2013 or a later version installed on your machine.

## "System.OutOfMemoryException: Out of memory" error

### Cause

The Excel application crashes due to insufficient memory or high memory utilization caused by a specific extension running on Excel.

### Resolution

Terminate all opened Excel applications and try again.

## More information

[Excel actions in Power Automate](/power-automate/desktop-flows/actions-reference/excel)
