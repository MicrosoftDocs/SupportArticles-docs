---
title: Error message (ActiveX component can't create object) when using Access
description: You receive a (ActiveX component can't create object) error when using Access.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 120588
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Access 2007
  - Access 2003
search.appverid: MET150
ms.date: 06/06/2024
---

# You receive a "ActiveX component can't create object" error message when using Access

_Original KB number:_ &nbsp; 319844

## Symptoms  

When you use Microsoft Access, you receive the following error message:

> ActiveX component can't create object

This article describes some common causes for this error message and offers methods that you can use to resolve the issue.

## Cause

This behavior can occur if any of the following conditions are true:

- Data Access Objects (DAO) is not properly registered.
- One or more references are missing.
- There is a utility database reference that is not valid.
- You do not have the required permissions for required libraries.
- There is a damaged wizard file.

## Resolution  

### Cause 1: DAO is not properly registered  

Re-register the DAO 3.6 library. To do this, follow these steps:

1. On the computer on which Microsoft Access is installed, or on the computer that hosts Microsoft Windows Terminal Server, click **Start**, and then click **Run**. (If you don't see Run, you can search for it or open a Command Prompt).
1. In the Run text box, type **regsvr32** followed by the path to your DAO file. Enclose this path in quotation marks. For example, to register the DAO 3.6 library, use the following command, which includes the default path to the DAO library file: `regsvr32 "C:\Program Files\Common Files\Microsoft Shared\DAO\DAO360.DLL"`.
  
### Cause 2: One or more references are missing

Check for missing references. To this, follow these steps:

1. Open the database for which you receive the error message.
2. Press ALT+F11 to open the Microsoft Visual Basic Editor.
3. In the Visual Basic Editor, click References on the Tools menu.
4. Review the list of available references that are checked. If any of the checked items display the word "Missing," uncheck the reference.

Alternatively, you can click the Browse button in the References dialog box to browse to the location of the library file associated with the missing reference.  

### Cause 3: There is a utility database reference that is not valid

As of the release of Microsoft Access 2000, a reference to Utility is not required. If you converted a database from a previous version, you may still see a reference to Utility in your list of references. Uncheck any references to Utility or Utility.mda. To do this, follow these steps:

1. Open the database for which you receive the error message.
2. Press ALT+F11 to open the Visual Basic Editor.
3. In the Visual Basic Editor, click References on the Tools menu.
4. Click to clear the check box next to any reference to Utility Database or Utility.mda.  

### Cause 4: You do not have the required permissions for required libraries 

All Microsoft Access users must have permissions to Windows System folders.

- Make sure that users have "read" permissions for all files in the following folders.

   |Operating System|Location|
   |---|---|
   |32 bit or (x86)|\Windows\System32|
   |64 bit or (x64)|\Windows\SysWOW64|

- If you cannot grant read permissions, you can use a utility such as Process Monitor to determine which file or files the users do not have the required permissions to use. To obtain Process Monitor, visit the following Sysinternals Web site: [Sysinternals](https://technet.microsoft.com/sysinternals/default.aspx).
  
### Cause 5: There is a damaged wizard file

To repair damaged wizard files, follow these steps:

1. Use Windows Explorer to locate the following wizard files: Acwzmain.mde, Acwztool.mde, and Acwzlib.mde.
1. Change the file name extension of each file to "old." For example, change Acwzmain.mde to Acwzmain.old.
1. Repair Microsoft Access or Microsoft Office Professional to reinstall the Wizard files.  

## More Information

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]
