---
title: Error when you compile a module or run a procedure in Access
description: Resolves the (Your Microsoft Office Access database or project contains a missing or broken reference to the file) error in Access.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
ms.reviewer: aldox
ms.date: 05/26/2025
---
# Error when you compile a module or run a procedure in Access

_Original KB number:_ &nbsp; 921504

This article applies to either a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file.

## Symptoms

Consider the following scenario. You have a procedure that contains a Microsoft Visual Basic for Applications (VBA) function. The Microsoft Office Access database contains a reference to a missing object library or to a missing type library. You compile a module, or you run a procedure. In this scenario, you may receive one of the following error messages:

Error message 1

> Your Microsoft Office Access database or project contains a missing or broken reference to the file **Filename**.  
To ensure that your database or project works properly, you must fix this reference.

Error message 2

> Compile Error:  
Can't find project or library

## Cause

This problem occurs because at least one object library that is referenced or at least one type library that is referenced is missing or is broken.

## Resolution

To resolve this problem, locate the missing object library, or locate the missing type library. To do this, follow these steps:

1. In Access, open the database.
2. Click the **Database Tools** tab, and then click **Visual Basic** in the **Macro** group.
3. In the Visual Basic Editor, click the **Tools** menu, and then click **References**.
4. In the **References** dialog box, locate the object library or the type library that is displayed as the following: **MISSING:**ReferenceName****  
5. Click to clear the check box next to the object library or the type library that you located in step 4.

> [!NOTE]
> If you know the location of the missing object library file or the location of the missing type library file, you can click **Browse** to locate the object library file or the type library file.
