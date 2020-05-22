---
title: Unable to save a database as an accde or mde file
description: There is an error in the VBA code that prevents you from compiling a database or project or there is a reference.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro 
ms.topic: article
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- CI 114797
- CSSTroubleshoot
ms.reviewer: cathmill
appliesto:
- Access 2010
- Microsoft Office Access 2007
- Microsoft Office Access 2003
search.appverid: MET150
---
# "Unable to create an MDE, ACCDE, or ADE database" error with a database that you can't compile

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_ &nbsp; 283788

> [!NOTE]
> Requires basic macro, coding, and interoperability skills. This article applies to a Microsoft Access database (.mdb/.accdb) and to a Microsoft Access project (.adp).

## Symptoms

When you try to save a Microsoft Access database as an ACCDE or MDE file, you may receive the following error message and the ACCDE file isn't created.

> Microsoft Access was unable to create the .accde, .mde, or .ade file.

When you try to save a Microsoft Access database as a MDE file, you may receive the following error message and the MDE file isn't created.

> Microsoft Access was unable to create an MDE database.

When you try to save a Microsoft Access project as an ADE file, you may receive the following error message and the ADE file isn't created.

> Microsoft Access was unable to create an ADE database.

## Cause

You may receive this error message if either of the following conditions is true:

- There is an error in the Visual Basic for Applications code that prevents you from compiling the database or project.
- There is a reference to an Access database (.mdb/.accdb) or an Access project (.adp).

## Resolution

1. Correct any problems in the code that prevent you from compiling the database or project.
2. Remove any references to .mdb, .accdb, and .adp files.

If you need to maintain a reference to a .mdb, .accdb, or .adp file, convert that file into an MDE, ACCDE or an ADE file, and then create a reference to the new file. You should now be able to convert the database or project to an MDE, ACCDE or an ADE file.

## Steps to reproduce the behavior

1. Create a new database.
2. Press ALT+F11 to open the Visual Basic Editor.
3. On the **Insert** menu, click **Module**.
4. Type the following code:

   ```vb
   Sub Generate_Compile_Error()
    MsgBoxx "This will cause an error"
   End Sub
   ```

5. On the **File** menu, click **Save projectname**.
6. Press ALT+F11 to return to Microsoft Access.
7. On the **Tools** menu, point to **Database Utilities**, and then click **Make MDE File**.

   You receive the error message that is mentioned in the "Symptoms" section of this article.
