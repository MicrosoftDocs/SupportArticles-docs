---
title: How to resolve Access reference issues
description: Provides some methods to check and resolve the reference issues in an Access database and provides some guidelines for avoiding reference issues.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: jatiles
appliesto: 
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---
# How to resolve reference issues in an Access database

_Original KB number:_ &nbsp; 310803

## Summary

This article describes issues that concern the use of references in an Access database.

Understanding reference errors requires an understanding both of how libraries are referenced in an Access database and of what is needed to install a database on a target computer without breaking these references. This article is a summary of the following topics:

- Viewing Access database references
- Resolving Microsoft Visual Basic for Applications references in Access
- Understanding reference error messages
- Resolving reference issues on the development computer
- Distributing database files
- Updating the reference list
- Distributing database files that have ActiveX controls
- Re-registering a file

## Viewing Access database references

To view the current database references:

1. Open the database.
2. Press ALT+F11 to start Visual Basic Editor.
3. On the **Tools** menu, click **References**.

## Resolving Visual Basic references in Access

Access loads the pertinent file (for example, a type library, an object library, or a control library) for each reference, according to the information that is displayed in the References box. If Access cannot find the file, Access runs the following procedures to locate the file:

1. Access checks to see whether the referenced file is currently loaded in memory.
2. If the file is not loaded in memory, Access tries to verify that the `RefLibPaths` registry key exists. If the key exists, Access looks for a named value that has the same name as the reference. If there is a match, Access loads the reference from the path that the named value points to.
3. Access then searches for the referenced file in the following locations, in this order:
   1. The Application folder (the location of the Msaccess.exe file).
   2. The current folder that you see if you click **Open** on the **File** menu.
   3. The Windows or Winnt folder where the operating system files are running.
   4. The System folder under the Windows or Winnt folder.
   5. The folders in the PATH environment variable that are directly accessible by the operating system.
4. If Access cannot find the file, a reference error occurs.

## Understanding reference error messages

There are several error messages that relate to a missing file or to a file that has a different version from the version that is used in the database. In most cases, you can search the Microsoft Knowledge Base for an article about the specific error message, and you can then resolve the error by following the steps in the article. In some cases, a dependency file is not correctly matched with the primary file.

The following list describes some of the reference error messages that you may receive. However, note that the list does not include all of the possible reference error messages.

- "Method **MethodName** of Object **ObjectName** Failed"

  Typically, you may receive this error message if there is a problem with a programming type library, for example, an invalid Data Access Object (DAO) dynamic-link library (DLL) file. You can search the Microsoft Knowledge Base for articles that describe the various forms of this error message.

- "Function is not available in **Usage** expression"

  You may receive this error message if there is a problem with a programming type library, or if the code does not specifically call out the correct library and the file is listed at a lower priority in the reference list than a file that contains the same function name--for example, if DAO code is used with the ActiveX Data Object (ADO) library listed at a higher priority than the DAO library. You may also receive this error message if a form or a report contains an ActiveX control.

- "Can't find project or library"

  You may receive this error message if Access cannot locate a file in the reference list. Often the file is flagged asMissingin theReferencesdialog box. Sometimes the file exists on the development computer but not on the target computer.

- "Variable not defined" or "User-defined type not defined"

  You may receive one of these error messages if you use the User-Level Security Wizard to secure a database that references libraries other than the libraries that are included by default. For example, references to libraries that existed in the unsecured database are not automatically created in the new, secured database.

- "Run-time error 5," "Invalid procedure call or argument," "The library which contains this symbol is not referenced by the current project," or "The library which contains this symbol is not referenced by the current project, so the symbol is undefined"

  You may receive one of these error messages if there is a reference to a database, a type library, or an object library that is flagged asMissing.

- "ActiveX component can't create object"

  This error message does not necessarily mean that an ActiveX control is involved. For example, one possible cause is that DAO, which is an ActiveX component, cannot create an object because the DAO Automation Server cannot start. Frequently, the cause is that DLLs that provide referenced functionality for the program are not registered or are incorrectly registered.

## Resolving reference issues on the development computer

Creating a new, blank database and then importing objects from another database file can create reference issues if the code or ActiveX controls rely on references that are not included in a database by default. The default references for an Access 2000 database are:

- Visual Basic for Applications
- Microsoft Access 9.0 object library
- OLE Automation
- Microsoft ActiveX Data Objects (ADO) 2.1 library

If the source is another Access 2000 database, verify that the references match. If the source is in an earlier version of Access, DAO 3.5 or earlier is probably in use; however, Access 2000 does not provide DAO 3.5 by default. Try removing the reference to the ADO 2.1 library (if it exists) and adding the reference to the DAO 3.6 object library.

If you converted the database from an earlier version of Access, and the database contains a reference to the Utility.mda file, in most cases you can remove this reference because the functions that this reference calls are included in the default references in Access 2000. If there are references to earlier versions of DAO, you can also remove these references because DAO 3.6 can address these functions.

To add a reference to a library:

1. Open the database.
2. Press ALT+F11 to start Visual Basic Editor.
3. On the **Tools** menu, click **References**.
4. Under **Available References**, click to select the check box next to the name of the library, and then click **OK**.

To remove a reference to a library:

1. Open the database.
2. Press ALT+F11 to start Visual Basic Editor.
3. On the **Tools** menu, click **References**.
4. Under **Available References**, click to clear the check box next to the name of the library, and then click **OK**.

## Distributing database files

There are two basic database file distribution methods. You can copy the file from the development computer to the target computer, or you can use the Package and Deployment Wizard to create a setup package.

If you copy the file from the development computer to the target computer, only the database file is copied. You must manually ensure that all files that are listed in the reference list are available, at the correct version level and in the same relative location on the target computer as on the development computer.

When you develop run-time applications in Access, be aware that some operating system files must be distributed with the run-time application. The packaging of these files is performed automatically by the Package and Deployment Wizard component of Microsoft Office 2000 Developer. Sometimes the versions of the files that are included depend on other applications that are installed on the development computer and that might have modified the operating system files.

Following certain guidelines will usually ensure that the versions of the files that you use will not conflict with files on the target computer when you install the run-time application. Here are the guidelines:

1. Develop the Access database on any computer.
2. Create a computer environment where the hard disk has been reformatted and where only the earliest version of the applicable operating system, of Office, and of Office 2000 Developer is installed. Run the Package and Deployment Wizard on this computer to create the run-time version of the application. This ensures that the revision levels of the files will work on any of the target computers.
3. Create a computer environment where the hard disk has been reformatted and where only the operating system is installed. Test the run-time application in this environment.
   - If the application does not run successfully, you know that there is something wrong with the application itself. You need to identify and correct the problem before you distribute the application.
   - If the application works successfully on the test computer but does not work on the target computer, you know that there is something wrong on the target computer rather than in the application. You need to identify and correct the probable cause on the target computer, probably an incompatibility or a corrupted file.

## Refreshing the reference list

If the reference issue involves an ActiveX control, you can sometimes resolve the issue by refreshing the reference list. To refresh the reference list:

1. In Visual Basic Editor, click **References** on the **Tools** menu.
2. In the **References** dialog box, click to select a reference that is not already selected, make note of which one you select, and then click **OK**.
3. On the **Tools** menu, click **References** again.
4. Click to cancel the selection of the reference, and then click **OK**.

## Distributing database files that have ActiveX Controls

There are two types of licenses for ActiveX controls: a design-time license and a run-time license.

- A design-time license permits you to insert licensed ActiveX controls from Office 2000 Developer into forms and reports in an Access database.
- A run-time license permits you to use the ActiveX controls in an Access database on a computer that does not have Office 2000 Developer installed, but a run-time license does not permit you to insert new licensed ActiveX controls. To install a run-time license, distribute the ActiveX controls by using the Package and Deployment Wizard, which writes the license for the controls in the target computer's registry.

A Missing flag, which you may see when you open a module in Design view and then click **References** on the **Tools** menu, indicates that the reference to the Common Dialog control on the target computer does not match the source in the database file from the development computer.

If you distribute a database file without installing the distributable Common Dialog control, the control's reference may be flagged as Missing, or you may receive an error message that "You don't have the license required to use this ActiveX control" if the non-distributable control is already installed on the target computer.

Even when the database file is part of a run-time application, you may receive the error message that "You don't have the license required to use this ActiveX control" if the non-distributable control that's already installed on the target computer is of a later version than the control that's provided by your run-time application. This issue can occur because the Setup program does not overwrite later versions of a file with an earlier version of the same file.

## Re-registering a file

It is possible for a file to be in the reference list without being correctly registered in the registry. If you suspect that this might be the case, follow these steps to re-register the file:

1. In Microsoft Windows NT 4.0, clickStart, point toFind, and then click **Files or Folders**, or in Windows 2000, clickStart, point toSearch, and then click **For Files and Folders**.
2. In the **Named** box, or in the **Search for files and folders named** box, type **regsvr32.exe**.
3. In the **Look in** box, click the root of the hard disk (usually C:).
4. Click to select the **Include Subfolders** check box if it is not already selected, and then click **Find Now** or **Search Now**.
5. After you find the file, click **Start**, click **Run**, and then delete anything that is in the **Open** box.
6. Drag the Regsvr32.exe file from the search results pane to the **Open** box.
7. Repeat steps 2 through 6, this time searching for *FileName.dll*, where *FileName* is the name of the file that you want to re-register.
8. After the *FileName.dll* file is in the **Open** box with the Regsvr32.exe file, click **OK**.
9. In Access, test to see whether the problem still exists.

If you don't have the Regsvr32.exe file on your computer, check other computers for the file. If the file is not available, you can obtain the file from the Microsoft Web site.

> [!NOTE]
> Remember to compile all modules after you adjust references. To compile all modules, with the module still open, click **Compile database** on the **Debug** menu. If the modules don't compile, there may be additional unresolved references.
