---
title: Can't import the Sms_def.mof file with invalid data
description: Fixes a problem in which the Sms_def.mof file doesn't open when you try to import the file to customize your hardware inventory in System Center 2012 Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, erinwi, prakask, keiththo, brshaw
---
# Configuration Manager Sms_def.mof file gives an invalid data error message when you import the file

This article helps you fix a problem in which the Sms_def.mof file doesn't open when you try to import the file to customize your hardware inventory in Microsoft System Center 2012 Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2690570

## Symptoms

When you try to import the Sms_def.mof file to customize your hardware inventory in System Center 2012 Configuration Manager, the file does not open. Additionally, you receive an error message that states that the file contains invalid data.

## Resolution

To resolve this problem, check the integrity of your MOF file. To do this, open a Command Prompt window, enter the following command in the directory in which you last saved your MOF file:

```console
mofcomp.exe -check <YourMOFName>.mof
```

## More information

For more information about how to test your MOF file, see [How to Extend the Sms_def.mof File by Using the Windows Management Instrumentation Registry Providers](/previous-versions//cc723607(v=technet.10)?redirectedfrom=MSDN#xsltsection126121120120).
