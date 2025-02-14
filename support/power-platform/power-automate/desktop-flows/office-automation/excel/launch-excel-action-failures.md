---
title: Launch Excel Action failures
description: Solves the errors related to the Launch Excel action in Power Automate for desktop.
ms.reviewer: amitrou
ms.author: nimoutzo
author: NikosMoutzourakis
ms.custom: sap:Desktop flows\Office automation
ms.date: 02/14/2025
---
# An error occurs when opening an Excel file in Power Automate for desktop

This article helps solve the error that occurs when you try to open a blank or existing Excel file in Power Automate for desktop.

## "Exception from HRESULT: 0x800xxxxx" error

> System.Runtime.InteropServices.COMException: Exception from HRESULT: 0x800xxxxx

### Cause

This error can occur if Office apps (or just Excel) aren't properly installed, Power Automate for desktop isn't properly installed, or the Excel file is synchronized with OneDrive.

### Resolution

Manually [uninstall](/power-automate/desktop-flows/install#uninstall-power-automate) and [reinstall](/power-automate/desktop-flows/install) Power Automate for desktop. If it doesn't work, manually [uninstall](https://support.microsoft.com/office/uninstall-office-from-a-pc-9dd49b83-264a-477a-8fcc-2fdf5dbf61d8) and [reinstall](https://support.microsoft.com/office/download-install-or-reinstall-microsoft-365-office-2024-or-office-2021-on-a-pc-or-mac-4414eaaf-0478-48be-9c42-23adc4716658) Excel.

## "Could not load file or assembly or one of its dependencies" error

> System.IO.FileNotFoundException: Could not load file or assembly 'Microsoft.Office.Interop.Excel' or one of its dependencies. The system cannot find the file specified.

### Cause

The Excel application isn't installed on the machine.

### Resolution

To solve this issue, [install Excel](https://support.microsoft.com/office/download-install-or-reinstall-microsoft-365-office-2024-or-office-2021-on-a-pc-or-mac-4414eaaf-0478-48be-9c42-23adc4716658) on the machine.

## "Access to the path 'C:\YourPath\YourFile.xlsx' is denied" error

> System.UnauthorizedAccessException: Access to the path 'C:\YourPath\YourFile.xlsx' is denied.

### Cause

The document is located in a restricted file path, or Power Automate for desktop doesn't have permission to open and access the document.

### Resolution

Move the file to a directory where Power Automate for desktop has access.

## "The process cannot access the file 'C:\YourPath\YourFile.xlsx'" error

> System.IO.IOException: The process cannot access the file 'C:\YourPath\YourFile.xlsx' because it is being used by another process.

### Cause

The Excel application is locked and no other process can access it.

### Resolution

Terminate all opened Excel processes and restart Power Automate for desktop.

## "80040154 Class not registered" error

> System.Runtime.InteropServices.COMException: Retrieving the COM class factory for component with CLSID {00020819-0000-0000-C000-000000000046} failed due to the following error: 80040154 Class not registered (Exception from HRESULT: 0x80040154 (REGDB_E_CLASSNOTREG)).

### Cause

This issue occurs due to the version of Excel is outdated.

### Resolution

To solve this issue, [install](https://support.microsoft.com/office/download-install-or-reinstall-microsoft-365-office-2024-or-office-2021-on-a-pc-or-mac-4414eaaf-0478-48be-9c42-23adc4716658) or [upgrade](https://support.microsoft.com/office/how-do-i-upgrade-office-ee68f6cf-422f-464a-82ec-385f65391350) to the latest Office version.

## "System.OutOfMemoryException: Out of memory" error

### Cause

The Excel application crashes due to insufficient memory, or memory utilization is high due to a specific extension running on Excel.

### Resolution

Terminate all opened Excel applications and try again.

## More information

[Excel actions in Power Automate](/power-automate/desktop-flows/actions-reference/excel)
