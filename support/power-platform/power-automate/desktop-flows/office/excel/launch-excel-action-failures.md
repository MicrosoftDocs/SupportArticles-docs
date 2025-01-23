---
title: Launch Excel Action failures
description: Solves various issues regarding the launch excel action.
ms.custom: sap:Desktop flows\UI or Browser automation issues
ms.date: 01/22/2025
ms.author: amitrou 
author: amitrou
---

# Launch Excel Action failures

## Symptom(s)

Launching an excel document could lead to errors containing the below information:

1. System.Runtime.InteropServices.COMException: Exception from HRESULT: 0x800xxxxx
2. System.IO.FileNotFoundException: Could not load file or assembly 'Microsoft.Office.Interop.Excel' or one of its dependencies. The system cannot find the file specified.
3. System.UnauthorizedAccessException: Access to the path 'C:\YourPath\YourFile.xlsx' is denied.
4. System.IO.IOException: The process cannot access the file 'C:\YourPath\YourFile.xlsx' because it is being used by another process.
5. System.Runtime.InteropServices.COMException: Retrieving the COM class factory for component with CLSID {00020819-0000-0000-C000-000000000046} failed due to the following error: 80040154 Class not registered (Exception from HRESULT: 0x80040154 (REGDB_E_CLASSNOTREG)).
6. System.OutOfMemoryException: Out of memory

## Detection

- The above issues could occur when launching an excel document, either a blank or an existing file.

## Cause

1. Either office apps (or just Excel) are not properly installed, Power automate desktop is not properly installed or the excel file is synchronized with onedrive drive.
2. Excel application is not installed on the machine.
3. The document is located in a restricted path, or pad doesn't have permission to launch and access the document.
4. The excel application is locked and no other process can access it.
5. Incompatible version of excel.
6. Excel application crashes due to insufficient memory, or memory utilization is high due to a specific extension running on excel.

## Resolution

1. Manually unistall and re-install pad. If it doesn't work, manually unistall and re-install excel.
2. Install excel on the machine.
3. Move the file into a directory where pad has access.
4. Terminate all opened excel processes and restart pad
5. The current version of excel is too old for pad to support, install latest office version.
6. Terminate all opened excel applications and try again.
