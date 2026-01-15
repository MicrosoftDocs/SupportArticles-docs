---
title: Can't import the Sms_def.mof file with invalid data
description: Fixes a problem in which the Sms_def.mof file doesn't open when you try to import the file to customize your hardware inventory in System Center 2012 Configuration Manager.
ms.date: 02/11/2025
ms.reviewer: kaushika, erinwi, prakask, keiththo, brshaw
ms.custom: sap:Client Operations\Client Settings
---
# Configuration Manager gives an invalid data error message when you import the MOF file to customize hardware inventory

This article helps you fix a problem in which the Managed Object Format (MOF) fil doesn't open when you try to import the file to customize your hardware inventory in Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2690570

## Symptoms

When you try to import the Managed Object Format (MOF) file to customize your hardware inventory in Configuration Manager, the file does not open. Additionally, you receive an error message that states that the file contains invalid data.

## Resolution

To resolve this problem, check the integrity of your MOF file. To do this, open a Command Prompt window, enter the following command in the directory in which you last saved your MOF file:

```console
mofcomp.exe -check <YourMOFName>.mof
```
