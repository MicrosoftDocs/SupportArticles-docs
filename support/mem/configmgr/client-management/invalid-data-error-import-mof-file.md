---
title: Invalid data error when you import a MOF file in Configuration Manager
description: Resolves an invalid data error that occurs when you import a Managed Object Format (MOF) file to customize hardware inventory in Configuration Manager.
ms.date: 08/20/2026
ms.reviewer: kaushika, erinwi, prakask, keiththo, brshaw
ms.topic: troubleshooting-problem-resolution
ai-usage: ai-assisted
ms.custom: sap:Client Operations\Client Settings

#customer intent: As a Configuration Manager administrator, I want to validate a MOF file so that I can import it to customize hardware inventory.
---
# Invalid data error when you import a MOF file in Configuration Manager

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2690570

## Summary

This article helps you resolve an **Invalid data** error that occurs when you import a Managed Object Format (MOF) file to customize hardware inventory in Configuration Manager. This error indicates that the MOF compiler can't parse the file. This article explains how to scan the file for issues so that you can fix them.

## Symptoms

When you try to import a MOF file in the Configuration Manager console, the file doesn't open and you receive an error message that states that the file contains invalid data.

## Cause

The MOF file contains invalid syntax or other data that the MOF compiler can't parse.

## Solution

Validate the MOF file by using the MOF compiler (`mofcomp.exe`). The `-check` option validates the MOF syntax without adding classes or instances to the Windows Management Instrumentation (WMI) repository.

1. Open a Command Prompt window.
1. Change to the directory where you saved the MOF file.
1. Run the following command:

   ```cmd
   mofcomp.exe -check <YourMOFName>.mof
   ```

1. Correct each error that the command reports, and then run the command again. Repeat this step until the validation completes without errors.
1. Import the corrected MOF file in the Configuration Manager console.

## Related content

- [Extend hardware inventory in Configuration Manager](/intune/configmgr/core/clients/manage/inventory/extend-hardware-inventory#how-to-import-classes)
- [mofcomp](/windows/win32/wmisdk/mofcomp)
