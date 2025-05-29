---
title: Unable to save design changes to Access objects
description: Explains that you can't save design changes if Access is unable to obtain an exclusive lock on the database. You must implement source code control using Visual SourceSafe add-in or distribute local working copies of the database to each developer.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: keithf, REBC
appliesto: 
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---
# Exclusive lock is required for saving design changes to Access objects

_Original KB number:_ &nbsp; 283228

> [!NOTE]
> Advanced: Requires expert coding, interoperability, and multiuser skills. This article applies only to a Microsoft Access database (.mdb and .accdb).

## Symptoms

When you try to customize toolbars or open a Microsoft Access form, report, macro, or module in Design view, you receive the following message:

> You do not have exclusive access to the database at this time. If you proceed to make changes, you may not be able to save them later.

When you try to save design changes that you made to an Access form, report, macro, or module, you receive the following message:

> You do not have exclusive access to the database at this time. Your design changes will not be saved.

When you try to save a new data access page, you receive the following message:

> A link to this data access page could not be created because the database cannot be exclusively locked.

## Cause

- You are trying to open a form, report, macro, module, or command bar in Design view.
- You are trying to save design changes to one of these object types or a new page link while other users have the same database open.

To save design changes to these object types, Access must be able to obtain an exclusive lock on the database.

## Resolution

In situations where multiple developers are designing an Access application simultaneously, you must implement source code control by using the Microsoft Visual SourceSafe Add-in for Microsoft Access. Or you must distribute local working copies of the database to each developer. A discussion of each of these options follows.

### Implementing source code control

The Microsoft Access Visual SourceSafe add-in permits you to put your Access application under source code control while it is under development. If you put your application under source code control, this permits you to track and to store changes that are made to your application over time. By using Microsoft Visual SourceSafe, you can review the history of an object and then revert to earlier versions of an object. You may check out objects in the Microsoft Access application, modify them or create new objects in their local copy, and then check them back into the main database under source code control. The Microsoft Access Visual SourceSafe add-in is available with Microsoft Office XP Developer. To use the Microsoft Access Visual SourceSafe add-in, you must also install Microsoft Visual SourceSafe, which is also available with Microsoft Office XP Developer, separately.

### Using individual working databases

Another option you can implement is to keep a master copy of the database application in a centralized location, and then use individual working copies of the database on each developer's computer. Each developer would develop individual portion of the application in the local working copy of the database. When the developers want to make a change to an object in the database application, they would import the object from the master database into the local working database. Then the developers would make the required changes to the object in the local working database, and save the object. When the developers are ready to commit the changes to the master database, they would export the object to the master database, overwriting the original object.

One disadvantage of using this approach is that there is no way to determine if multiple developers are concurrently working on the same object locally. When the developer exports the object to the master database, the developer can unknowingly overwrite changes that another developer committed to the master database.

## More Information

To save design changes to Access-specific objects, such as forms, reports, new page links, macros, modules, and commandbars, Access 2002 must be able to lock the database exclusively during the **Save** operation. Tables, queries, and relationships do not fall under this restriction because they are Microsoft Jet-specific objects. Microsoft uses this requirement with Access 2002 for several reasons:

- It provides consistency with other Visual Basic Environment client applications.
- It stops dependency on the Jet database engine.
- It improves stability of Access-specific objects.

### Provides consistency with other Visual Basic environment client applications

Because Access 2002 hosts the Visual Basic environment, the save model used by Microsoft Access must be consistent with other applications that host the Visual Basic environment. The Visual Basic environment only permits exclusive editing and saving of Visual Basic projects that are not under source code control. This is true of Visual Basic 6.0, and also all Office applications that host the Visual Basic environment.

### Stops dependency on the Jet database engine

Access offers the ability to create Microsoft Access project (.adp) files and also Microsoft Access databases (.mdb). By using an Access project, developers can use Microsoft SQL Server as another database engine to Microsoft Jet. In the past, all Access specific objects (forms, reports, macros, modules, and commandbars) were dependent upon the Jet database engine for storage. These objects were stored in Access-specific system tables in the Microsoft Jet database. Because it is possible for Access to use Microsoft SQL Server as an alternative to Microsoft Jet, Microsoft had to develop a storage mechanism for Access-specific objects that does not rely on the Jet database engine.

### Improves stability of Access-specific objects

The project storage model improves the stability of Access-specific objects and the Visual Basic project. Visual Basic for Applications has never allowed multi-user editing of Visual Basic projects without source code control. Microsoft Access 95 and Microsoft Access 97 could circumvent this restriction by hiding project changes made in a multi-user environment from Visual Basic for Applications, and then merging them into the project later. However, this had the potential for affecting the stability of the Visual Basic project. Therefore, Microsoft Access requires an exclusive lock when designing Access-specific objects to make sure that the project has only one editor.

### Editing Access objects in a multi-user environment

Because users may open a database either for exclusive or shared use, the save behavior exhibited by Access depends on how the user opened the database and on whether multiple users are currently accessing it.

If a developer opens the database for exclusive use, the developer can save the design of any Access-specific object, provided the developer can open the database for read/write access and has the correct permissions to modify the design of the object.

If a user opens the database for shared use, the user can save the design of any Access-specific object, provided the user can open the database for read/write access, has the correct permissions to modify the design of the object, and Access can obtain an exclusive lock on the database.

### Lock promotion

To make sure use of the database is exclusive, Access uses the connection control feature of the Jet database engine to promote the user's shared lock to exclusive. Access tries to promote a shared lock to an exclusive lock as soon as the user opens a form, report, macro, or commandbar in Design view. Access tries lock promotion at this time in order to prevent the scenario where a user has made multiple design changes only to later find that the user cannot save them because Access cannot obtain an exclusive lock. By trying lock promotion as soon as the user opens an object in Design view, Access can warn the user if it cannot obtain an exclusive lock before the user makes any design changes. Access will not try lock promotion when opening a module in Design view; however, it will try lock promotion as soon as the user edits any module in the database.

Access maintains the exclusive lock until the user saves or discards all dirty objects and no other objects are open in Design view. Following this, Access demotes the lock back to shared if the database was originally opened for shared use.

If Access cannot promote the lock to exclusive when the user opens an object in Design view, Access alerts the user with the message:

> You do not have exclusive access to the database at this time. If you proceed to make changes, you may not be able to save them later.

Following this warning message, Access will open the object in Design view and allow the user to make design changes. If the user tries to save the object, Access tries to promote the shared lock to exclusive. If lock promotion is successful, Access saves the object and maintains the exclusive lock until the user saves or discards all other dirty objects and no object remains open in Design view. If lock promotion fails, the user receives the following message:

> You do not have exclusive access to the database at this time. Your design changes will not be saved.

If the user tries to close the dirty object and save changes, Access then prompts the user with the option of closing the object and discarding design changes made to it, or with the option of leaving it open and unsaved.

### Steps to reproduce the behavior

1. Start two instances of Microsoft Access on the same computer.
2. Open the sample database Northwind.mdb in both instances.
3. In the first instance of Microsoft Access, open the **Customers** form in **Design** view.
   
   You receive the message:
   
   > You do not have exclusive access to the database at this time. If you proceed to make changes, you may not be able to save them later.

4. Click **OK** to clear the message.

   The form opens in **Design** view.

5. Add a text box control to the form.
6. On the **File** menu, click **Save**.

   You receive the following message:
   
   > You do not have exclusive access to the database at this time. Your design changes will not be saved.

7. Click **OK** to clear the message.
8. Close the second instance of Access on your computer.
9. In the first instance of Access, try to save the form again.

   The form is saved successfully.
