---
title: Can't open database compiled as MDE, ACCDE or ADE
description: Resolves the problem that you receive an error message when you run a compiled Microsoft Access MDE, ACCDE, or ADE file in Access 2010. Resolution is to compile your Access 2010 MDE, ACCDE, or ADE application by using the version of Access 2010 in which you intend to deploy the MDE, ACCDE, or ADE file.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Access 2010
ms.date: 03/31/2022
---

# "The database cannot be opened because the VBA project contained in it cannot be read" when you run a compiled Microsoft Access MDE, ACCDE, or ADE file in Access 2010

## Summary

Microsoft Access databases that are created by using the 64-bit version of Microsoft Access 2010 and that are compiled as MDE, ACCDE, and ADE files have to be recompiled in Microsoft Access 2010 Service Pack 1 (SP1) to work correctly with Access 2010 SP1. 

Access 2010 MDE, ACCDE, and ADE databases that were built by using the initial release, or RTM, version of 64-bit Access 2010 are incompatible with SP1, Also, Access 2010 MDE, ACCDE, and ADE databases that were compiled in Access 2010 SP1 will not work with the RTM version. Compiled MDE, ACCDE, and ADE databases have to be re-created from their source ACCDB, MDB, or ADP databases.  

Access databases that are created by using the 32-bit version of Access 2010 and that are compiled as MDE, ACCDE, and ADE files will work correctly with Microsoft Access 2010 SP1. However, Access MDE, ACCDE, and ADE databases that are created by using the 32-bit version of Microsoft Access 2010 SP1 will not work correctly with the RTM version.

## Symptoms

Consider the following scenarios:

- Scenario 1: You create a compiled Access 2010 MDE, ACCDE, or ADE file on a computer on which Access 2010 SP1 (64-bit) is installed. Then, you try to use the file on a computer on which the release version of Access 2010 (64-bit) is installed.    
- Scenario 2: You create a compiled Access 2010 MDE, ACCDE, or ADE file on a computer on which the release version of Access 2010 (64-bit) is installed, and then you try to use the file on a computer on which Access SP1 2010 (64-bit) is installed.    
- Scenario 3: You create a compiled Access 2010 MDE, ACCDE, or ADE file on a computer on which Access 2010 SP1 (32-bit) is installed, and then you try to use the file on a computer on which the release version of Access 2010 (32-bit) is installed.   
 
In these scenarios, the first time that you try to run VBA code, you receive the following error message:

```adoc
The database cannot be opened because the VBA project contained in it cannot be read. The database can be opened only if the VBA project is first deleted. Deleting the VBA project removes all code from modules, forms and reports. You should back up your database before attempting to open the database and delete the VBA project.

To create a backup copy, click Cancel and then make a backup copy of your database. To open the database and delete the VBA project without creating a backup copy, click OK.
```

## Cause

This issue occurs because Access 2010 SP1 uses a newer version of the VBE7.dll file (version 7.00.1619).

## Resolution

To resolve this issue, compile your Access 2010 MDE, ACCDE, or ADE application by using the version of Access 2010 in which you intend to deploy the MDE, ACCDE, or ADE file.

## More Information

The following tables provide a summary of which compiled databases will work with which version of Access 2010. The tables assume that you are opening a 32-bit MDE, ACCDE, or ADE file in the 32-bit version of Microsoft Access or that you are opening a 64-bit MDE, ACCDE, or ADE file in the 64-bit version of Access. You cannot open a 32-bit MDE, ACCDE, or ADE file in 64-bit Access, and you cannot open a 64-bit MDE, ACCDE, or ADE file in 32-bit Access.

An MDE, ACCDE, or ADE file that was created in Access 2010 RTM

|Kind of file|Access 2010 RTM|Access 2010 SP1|
|---|---|---|
|32-bit MDE, ACCDE, or ADE|Works|Works|
|64-bit MDE, ACCDE, or ADE|Works|Error occurs|

An MDE, ACCDE, or ADE file that was created in Access 2010 SP1

|Kind of file|Access 2010 RTM|Access 2010 SP1|
|---|---|---|
|32-bit MDE, ACCDE, or ADE|Error occurs|Works|
|64-bit MDE, ACCDE, or ADE|Error occurs|Works|