---
title: Exclusive access errors when saving design changes
description: Fixes an issue in which you must have exclusive access or use an exclusive lock to save design changes to database objects in Access. 
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
ms.reviewer: 
appliesto:
- Microsoft Office Access 2007
- Microsoft Office Access 2003
search.appverid: MET150
---
# You must use an exclusive lock to save design changes to database objects in Access 2003

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_ &nbsp; 824278

> [!NOTE]
> Requires expert coding, interoperability, and multiuser skills. This article applies to a Microsoft Access database (.mdb or .accdb). For a Microsoft Access 2002 version of this article, see [283228](https://support.microsoft.com/help/283228).

## Symptoms

When you try to a customize a toolbar or when you try to open a Microsoft Office Access 2003-specific object such as a form, a report, a macro, or a module in Design view, you may receive the following error message:

> You do not have exclusive access to the database at this time. If you proceed to make changes, you may not be able to save them later.

When you try to save,  design changes that you make to an Access 2003 form, report, macro, or module, you may receive the following error message:

> Microsoft Office Access can't save design changes or save to a new database object because another user has the file open. To save your design changes or to save to a new object, you must have exclusive access to the file.

When you try to save a new data access page, you may receive the following error message:

> A link to this data access page could not be created because the database cannot be exclusively locked.
> To create the link later, open the page by selecting 'Edit web page that already exists', and then save.

> [!NOTE]
> You cannot create or modify data access pages in Microsoft Office Access 2007.

## Cause

This problem may occur for any one of the following reasons:

- You try to open a form, a report, a macro, a module, or a command bar in Design view.
- You try to save design changes to an object type.
- You try to save design changes to a new page link while other users have the same database open that you have open.

## Resolution

To save design changes to object types, Access 2003 must have an exclusive lock on the database. When multiple users are designing the same Access 2003 application at the same time, you must implement source code control by using the Microsoft Visual SourceSafe Add-In for Access 2003. Alternatively, you can distribute local working copies of the database to each user.

### Implement source code control

The Access Visual SourceSafe Add-in permits you to put your Access 2003 application under source code control while your application is being developed. If you put your application under source code control, you may be able to track changes and to store changes that are made to your application. By using Visual SourceSafe, you can review the history of an object and then revert to earlier versions of that object. You may check out objects in the Access 2003 application, modify the objects, or create new objects in the local copy of the object. Then, you can check the objects back into the main database under source code control. The Access 2003 Source Code Control Add-in is available as a free download. To use the Access 2003 Source Code Control Add-in, you must also install Office 2003 SP1 and have access to a computer that is running Visual SourceSafe 6.0.

### Use an individual working copy of the database

You can keep a master copy of the database application in a centralized location and then provide an individual working copy of the database on the computer of each user. Each user develops their portion of the application in their local copy of the database. When the user wants to make a change to an object in the database application, the user imports the object from the master database to the local copy of the database. The user makes the required changes to the object in the local working copy of the database and then saves the object. When the user is ready to commit the changes to the master database, the user exports the object to the master database. This object with the changes overwrites the original object.

If you use an individual working copy of the database, there is a disadvantage. You cannot determine if multiple users are working on the same object locally and at the same time. When you export the object with changes to the master database, you can unknowingly overwrite changes that another user committed to the master database.

## More Information

To save design changes to Access-specific objects, such as forms, reports, new page links, macros, modules, and command bars, Access 2003 must be able to lock the database exclusively during the save operation. Tables, queries, and relationships do not have to lock the database exclusively during the save operation because tables, queries, and relationships are Microsoft Jet-specific objects.

The database must be locked exclusively during the save operation for the following reasons:

- provide consistency with other Microsoft Visual Basic Environment client applications
- stop dependency on the Jet database engine
- improve stability of Access-specific objectsProvide consistency with other Visual Basic Environment client applications

Access 2003 hosts the Visual Basic Environment. Therefore, the save model that is used by Access 2003 must be consistent with other applications that host the Visual Basic Environment. The Visual Basic Environment only permits exclusive editing and exclusive saving of Microsoft Visual Basic projects that are not under source code control. This is true for Microsoft Visual Basic 6.0 and for all Microsoft Office applications that host the Visual Basic Environment.

### Stop dependency on the Jet database engine

Access 2003 permits you to create Access 2003 project (.adp) files and to create Access 2003 database (.mdb) files. In addition to the Jet database engine, you can use Microsoft SQL Server as another database engine for an Access 2003 project. Previously, all Access-specific objects such as forms, reports, macros, modules, and command bars depended on the Jet database engine for storage. These objects were stored in Access-specific system tables in the Jet database.

### Improve stability of Access-specific objects

The project storage model improves the stability of Access-specific objects and the stability of Visual Basic projects. Visual Basic for Applications has never permitted multi-user editing of Visual Basic projects without source code control. Microsoft Access 95 and Microsoft Access 97 can circumvent this restriction by hiding project changes that are made in a multi-user environment from Visual Basic for Applications. Later, Access 95 and Access 97 can merge the project changes into the project. However, merging the project changes into the project later has the potential for affecting the stability of the Visual Basic project. Therefore, Access 2003 requires an exclusive lock when you design Access-specific objects. This requirement makes sure that the project has only one user.

### Edit Access objects in a project storage model in a multi-user environment

You can open a database either for exclusive use or for shared use. The save behavior in Access 2003 depends on how you open the database and on whether multiple users are currently accessing the database.

If you open the database for exclusive use, you can save the design of any Access-specific object. This is true provided that you can open the database for read access, you can open the database for write access, and you have the correct permissions to modify the design of the object.

If you open the database for shared use, you can save the design of any Access-specific object. This is true provided that you can open the database for read access, you can open the database for write access, you have the correct permissions to modify the design of the object, and Access 2003 can obtain an exclusive lock on the database.

### Lock promotion

Access 2003 uses the connection control feature of the Jet database engine to promote your shared lock to an exclusive lock. This makes sure that the database is opened exclusive to you. Access 2003 tries to promote a shared lock to an exclusive lock as soon as you open a form, a report, a macro, or a command bar in Design view. Access 2003 tries lock promotion now so that your design changes will not be lost when you later try to save the design changes and Access 2003 cannot obtain an exclusive lock. By trying lock promotion as soon as you open an object in Design view, Access 2003 can warn you if an exclusive lock cannot be obtained before you make any design changes. Access 2003 does not try lock promotion when you open a module in Design view. However, Access 2003 does try lock promotion as soon as you edit any module in the database.

Access 2003 maintains the exclusive lock until you save the objects or until you discard the dirty objects, and no other objects are open in Design view. Then, Access 2003 changes the lock back to a shared lock if the database was originally opened for shared use.

If Access 2003 cannot promote the lock to exclusive when you open an object in Design view, you may receive the following error message:

> You do not have exclusive access to the database at this time. If you proceed to make changes, you may not be able to save them later.

After you receive this error message, Access 2003 opens the object in Design view, and you can make design changes. If you try to save the object, Access 2003 tries to promote the shared lock to an exclusive lock. If lock promotion is successful, Access 2003 saves the object and then maintains the exclusive lock until you save the object or you discard the dirty object. The exclusive lock is maintained until no object remains open in Design view. If lock promotion fails, you may receive the following error message:

> Microsoft Office Access can't save design changes or save to a new database object because another user has the file open. To save your design changes or to save to a new object, you must have exclusive access to the file.

If you try to save changes and to close the dirty object, Access 2003 then prompts you with the following options:

- Close the object and then discard design changes that have been made to the object.
- Leave the object open, and leave the object unsaved.

### Steps to reproduce the behavior

1. Start two instances of Access 2003.

   > [!NOTE]
   > You must start both instances of Access 2003 on the same computer.

2. Open the Northwind.mdb sample database in both instances of Access 2003.
3. In the first instance of Access 2003, open the Customers form in Design view. To do this, follow these steps:

   1. In the Database window, click **Forms** under **Objects**.
   2. In the right pane, right-click the form that you want, and then click **Design View**. You may receive the following error message:You do not have exclusive access to the database at this time. If you proceed to make changes, you may not be able to save them later.

4. Click **OK** to clear the message.

   Notice that the form opens in Design view.

5. Add a text box control to the form.
6. On the **File** menu, click **Save**.

   You may receive the following error message:Microsoft Office Access can't save design changes or save to a new database object because another user has the file open. To save your design changes or to save to a new object, you must have exclusive access to the file.

7. Click **OK** to clear the message.
8. Close the second instance of Access 2003.
9. In the first instance of Access 2003, save the form again.

   Notice that the form is saved successfully.
