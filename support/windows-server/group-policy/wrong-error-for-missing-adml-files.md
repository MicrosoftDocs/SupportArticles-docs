---
title: Wrong error message for missing .adml files
description: Provides a solution to an issue where wrong error messages are returned when .adml files are missing.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# Wrong error message for missing .adml files

This article provides a solution to an issue where wrong error messages are returned when .adml files are missing.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2688272

## Symptoms

SR symptoms:

EN-US Domain Controller tries to create a settings report for a GPO. The report is created with the message:

> An appropriate resource file could not be found for file `\\domainname.com\sysvol\domainname.com\Policies\PolicyDefinitions\anyfile.admx` (error = 2): The system cannot find the file specified.  
The .admx Files reported as missing are present in the specified folder.

Repro symptoms:

Renaming the folder that contains the appropriate .adml files returns the error:

> An appropriate resource file could not be found for file `\\domainname.com\sysvol\domainname.com\Policies\PolicyDefinitions\anyfile.admx` (error = 3): The system cannot find the path specified.  
This error also happens when the EN-US folder does not exist and is missing.

Editing the affected GPOs becomes impossible, reports are inaccurate. The problem does not happen in the same way when other language files and folders are missing as EN-US is the fallback language and it will be loaded instead when another language is missing.

## Cause

In order to generate reports or edit the GPO, the .admx file needs to be loaded as well as the appropriate .adml language file. Depending on the native language user requesting the edit / reporting operation the .adml file is searched for in the appropriate language folder (en for en, de for de, an so on). If, for example,  the querying user wants english and the GPO central store only has the german .adml files installed such an error would occur.

The error reporting is incorrect since it is referring to the .admx file as missing, while this file is present at the specified location.

## Resolution

Making the .adml files available for the language queried for in the correct folder solves the problem. See [How to create the Central Store for Group Policy Administrative Template files in Windows Vista](https://support.microsoft.com/help/929841).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
