---
title: Database contains a missing or broken reference
description: Fixes an issue in which the procedure contains a VBA function and your database contains a reference to a missing object library or a missing type library.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: jlucey
appliesto: 
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---
# Visual Basic for Applications (VBA) functions break in a database with missing references

_Original KB number:_ &nbsp; 283806

> [!NOTE]
> Requires basic macro, coding, and interoperability skills. This article applies to a Microsoft Access database (.mdb and .accdb) and to a Microsoft Access project (.adp).

## Symptoms

If you have a procedure that contains a Visual Basic for Applications function and your database contains a reference to a missing object library or type library, you may receive one of the following error messages when you compile your modules or run the procedure:

### Error message 1

> Your Microsoft Access database or project contains a missing or broken reference to the file \<filename>.<br/>
> \* To ensure that your database or project works properly, you must fix this reference.<br/>
> \* To learn how to fix this reference, click Help.

### Error message 2

> Compile Error:<br/>
> Can't find project or library

## Cause

Your database contains a reference to a database, type library, or object library that is marked as **MISSING: \<referencename>** in the References dialog box.

## Resolution

To remove the missing reference, follow these steps:

1. Open your database.
2. Press ALT+F11 to open the Visual Basic Editor.
3. On the **Tools** menu, click **References**.
4. Click to clear the check box for the type library or object library marked as **MISSING: \<referencename>**.

An alternative to removing the reference is to restore the referenced file to the path that is specified in the References dialog box. If the referenced file is in a new location, clear the **MISSING: \<referencename>** reference, and then create a new reference to the file in the new folder.

> [!NOTE]
> In an Access run-time application, you cannot view references from a menu. However, the following article demonstrates how to view references using code:
[209849](https://support.microsoft.com/help/209849) How to loop through references to view their properties

## Steps to reproduce the behavior

1. Open the sample database Northwind.mdb.
2. Create a new form that is not based on any table or query.
3. On the **Insert** menu, click **ActiveX Control**.
4. In the **Select an ActiveX control** list, click **Kodak Image Edit Control**, and then click **OK**.
5. Save the form as frmReference, and then close it.
6. Close Northwind.mdb, and then quit Access.
7. Find and rename the ImgEdit.ocx file to ImgEdit.old.
8. Start Access, and then open Northwind.mdb.
9. Open the Startup module in Design view.
10. On the **Debug** menu, click **Compile Northwind**. Note that you receive both of the error messages that are mentioned in the "Symptoms" section of this article.
11. Click **OK**. Note that the References dialog box appears; the following reference is highlighted in the **Available References** dialog box:

    `MISSING: Kodak Image Edit Control`

12. Click **Cancel** in the Available References dialog box.
13. Find and rename the ImgEdit.old file to ImgEdit.ocx.
14. Repeat step 10 and note that the error message no longer appears.
